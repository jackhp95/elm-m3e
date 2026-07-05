# ⑤ Build shape — crossbar redesign

**Date:** 2026-07-04
**Status:** Design approved, ready to plan
**Supersedes:** `docs/superpowers/specs/2026-07-04-build-shape-emitter-design.md`
**Epic:** #138, second ship (in-flight rewrite)

---

## 1. Status and context

The ⑤ Build shape emitter epic (`2026-07-04-build-shape-emitter-design.md`) shipped Tasks 1–10 on `main` (commits through outer `78ca0bf` / elm-cem `445018a`). During Task 10's type-behavior test we surfaced two related design frictions:

1. **Verbose child seams.** Every slot child requires `.build` at the point it enters the parent's slot: `Select.default (Option.option {…} |> Option.build)`. In a page with N children, that's N calls to `.build` that add nothing beyond a type coercion the compiler could infer.

2. **Concrete-vs-polymorphic row bugs.** The naive emission produced `Builder a {} msg` (concrete empty record) for components without required-multi slots, and `Element {} msg` inputs on arbitrary-kinded slot setters. Both required patches; both indicated the type parameters were doing too much load-bearing work at the setter/build boundary.

This spec proposes a redesign built around a **unified Builder type + per-container crossbar sub-modules of specialized setter aliases**. It ships in place of Tasks 4–10's existing emissions — Tasks 1 (`Shape5` variant), 2 (`M3e.Build.Internal` markers), and 3 (`codeShape5` field in examples) survive; Tasks 4–9's `generateBuildModule` code is rewritten; Task 10's test file is rewritten to match the new API.

---

## 2. Motivation

**What we want at the call site:**

```elm
-- Leaf child (Radio, Option, Divider): no .build ceremony
Select.select
    |> Slots.option (Option.option { value = "a", label = "A" })
    |> Slots.option (Option.option { value = "b", label = "B" } |> Option.disabled True)
    |> Select.build

-- Container child (Card inside BottomSheet): pipeline builds inline, no .build
BottomSheet.bottomSheet
    |> BottomSheet.Slots.card
        ( Card.card
            |> Card.title myHeading
            |> Card.action myFooter
            |> Card.elevation 4
        )
    |> BottomSheet.build

-- Missing required slot: TYPE MISMATCH at the parent's slot setter
BottomSheet.bottomSheet
    |> BottomSheet.Slots.card
        ( Card.card
            |> Card.title myHeading           -- forgot Card.action
        )
    |> BottomSheet.build
-- Compile error: Card.action must be Filled before insertion.
```

**What we don't want:**

- `.build` sprinkled on every child.
- Concrete `{}` type errors leaking from generator internals.
- A separate `Sealed` marker that shows up in error messages.

---

## 3. The design in one paragraph

Every generated `M3e.Build.<Comp>` module shares **one** underlying `Builder` type declared in `M3e.Build.Internal`. Per-component modules expose a **type alias** that pins the kind-row phantom to that component's kind. Slot children flow into parents through **crossbar sub-modules** (`M3e.Build.<Container>.Slots`) that expose one specialized alias per allowed child component. Each alias's signature demands the child's `slotCaps` be in its fully-filled state — no `Sealed` marker, no `.build` on the child, and no import cycles because the crossbar sub-module is the only place that imports across components.

---

## 4. Type-level architecture

### 4.1 The unified `Builder` type

```elm
-- module M3e.Build.Internal
type Builder kindRow attrCaps slotCaps msg
    = Builder (M3e.Node.Node msg)
```

Four phantom parameters:

- `kindRow` — mirrors `Element`'s `supported` row. Records which slot kinds this builder can be placed in (`{ kind | radio : Supported }`).
- `attrCaps` — record of `Available`/`Used` markers per optional attribute and event.
- `slotCaps` — record of slot state: `Available`/`Used` for optional-singular, `NotFilled`/`Filled` for required-multi.
- `msg` — the message type.

`Builder`'s constructor is exposed only within `M3e.Build.Internal`. Generated modules use two internal helpers to wrap/unwrap:

```elm
-- module M3e.Build.Internal (exposed to the M3e.Build.* generator output)
node_ : Builder k a s msg -> M3e.Node.Node msg
wrap_ : M3e.Node.Node msg -> Builder k a s msg
```

These are the *only* Node↔Builder escape hatches. Users writing application code never see them.

### 4.2 The four marker types

Unchanged from the current spec (`M3e.Build.Internal`):

```elm
type Available     -- optional-singular capability not yet consumed
type Used          -- optional-singular capability consumed
type NotFilled     -- required-multi slot not yet filled
type Filled        -- required-multi slot filled at least once
```

### 4.3 Per-component type alias

Each `M3e.Build.<Comp>` module hides the shared Builder behind a component-specific alias:

```elm
-- module M3e.Build.Radio
type alias Builder attrCaps slotCaps msg =
    M3e.Build.Internal.Builder
        { kind | radio : M3e.Value.Supported }
        attrCaps
        slotCaps
        msg
```

Users write `Radio.Builder Radio.AttrCaps Radio.SlotCaps msg` — same familiar shape as today's per-module Builder. The kind-row detail is hidden.

### 4.4 The kind-row phantom

Every seed sets its own kind row:

```elm
-- M3e.Build.Radio
radio : Builder AttrCaps SlotCaps msg
-- Expands to:
-- Internal.Builder { kind | radio : Supported } AttrCaps SlotCaps msg

-- M3e.Build.Divider
divider : Builder AttrCaps SlotCaps msg
-- Expands to:
-- Internal.Builder { kind | divider : Supported } AttrCaps SlotCaps msg
```

Consumers (parent slot setters) can constrain on kind row:

- **Arbitrary slots** — accept any component: `Builder anyKind ...`.
- **Kinded slots** — accept only components claiming the specified kind, e.g. `Builder { option : Supported } ...` (closed record — same gate Shape3 uses).

### 4.5 Setter phantom transitions

Unchanged in spirit from current spec:

- Optional-singular attr / event: `{ a | field : Available } → { a | field : Used }`.
- Optional-singular slot: `{ s | slot : Available } → { s | slot : Used }`.
- Optional-multi slot: passthrough, no row change.
- Required-multi slot: `{ s | slot : filled } → { s | slot : Filled }` (lowercase `filled` accepts any state).

### 4.6 The `.build` terminal

`M3e.Build.<Comp>.build` transitions from `Builder` to `Element`. Its input demands the component's specific required-multi slots at `Filled`:

```elm
-- module M3e.Build.RadioGroup
build :
    Builder AttrCaps { default : Filled } msg
    -> M3e.Element.Element { kind | radioGroup : Supported } msg
build (Internal.Builder n) =
    M3e.Element.fromNode n
```

`.build` **remains** — it's the boundary crossing at the app root when handing off to `Html.map` or `M3e.Element.toHtml`. It's just no longer called on every child.

---

## 5. Module layout

```
M3e/
├── Build/
│   ├── Internal.elm                    ← existing; add wrap_/node_ helpers
│   ├── Radio.elm                       ← seed + attr setters + own `.build`
│   ├── Radio/
│   │   └── (no Slots — Radio is a leaf, has no slots)
│   ├── RadioGroup.elm                  ← seed + attr setters + own `.build`
│   ├── RadioGroup/
│   │   └── Slots.elm                   ← ONE alias per allowed child component
│   ├── Card.elm
│   ├── Card/
│   │   └── Slots.elm
│   └── ...
```

**Per-component module** (`M3e.Build.<Comp>.elm`) exposes:

- `type alias Builder attrCaps slotCaps msg = ...`
- `type alias AttrCaps = { ... }`
- `type alias SlotCaps = { ... }`
- The seed function (e.g., `radioGroup : Builder AttrCaps SlotCaps msg` or `radioGroup : { required } -> Builder ...`).
- One setter per optional attr, event, and optional-singular slot.
- The `.build` terminal.
- **No slot setters that take a specific child type** — those live in the `.Slots` sub-module.

**Per-container `.Slots` sub-module** (`M3e.Build.<Comp>.Slots.elm`) exposes:

- One alias per allowed child component, per slot.
- Alias name: `<slotName><ChildComp>` when the container has multiple slots, or just `<childComp>` when the slot is `unnamed` / `default`.
- Each alias has a specific input type that pins the child to its component-local Builder alias with the fully-filled `SlotCaps`.

The `.Slots` module imports both its parent container's Builder and every child component's Builder. Because no component's `Foo.elm` imports any other component, cycles are impossible.

### 5.1 Slot alias generation rules

For each container `Parent` and each slot `slotName` in `Parent`:

- **If the slot's `kinds: arbitrary`**: generate one alias per component in the codebase. Alias name: `<slotName><ChildComp>` (or `<childComp>` if slot is `unnamed` / `default`), where `<ChildComp>` is the child's decapitalized component name for the first-letter and remainder capitalized (e.g., `Radio` → `Radio` in `titleRadio`, `defaultRadio`).
- **If the slot's `kinds: ["kind1", "kind2", ...]`**: generate one alias per component whose kind row includes any of those kinds. Same naming rule.
- If the slot is `optional-singular`: alias's transition is `Available → Used`.
- If the slot is `optional-multi`: alias's transition is passthrough (accepts multiple; no row change).
- If the slot is `required-multi`: alias's transition is `filled → Filled`.

**Each alias's child input type is polymorphic in attrCaps and in optional-singular slot fields, but pinned to `Filled` on the child's required-multi slot fields.** Written as an extensible row:

```elm
-- child has no required-multi (a leaf): fully polymorphic
Radio.Builder a s msg

-- child has required-multi slots `title` and `action`:
Card.Builder a { c | title : Filled, action : Filled } msg
--                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ extensible: pins only what must be Filled
```

This means:

- Optional attrs and events on the child can be in any state (`Available` or `Used`) — the parent doesn't care.
- Optional-singular slots on the child can be in any state — the parent doesn't care.
- Required-multi slots on the child MUST be `Filled` — enforced by the extensible row's fixed portion.

No separate `FilledSlotCaps` type alias needs to be emitted; the constraint lives inline in the alias signature.

### 5.2 The polymorphic core

For each slot on each container, the generator emits **one** polymorphic private helper:

```elm
-- module M3e.Build.RadioGroup.Slots

-- Private: implementation detail. Not exposed.
default_core :
    Internal.Builder anyKind anyAttrs anySlots msg
    -> Internal.Builder { k | radioGroup : Supported } a { s | default : filled } msg
    -> Internal.Builder { k | radioGroup : Supported } a { s | default : Filled } msg
default_core child parent =
    Internal.wrap_
        (M3e.Node.appendChild (Internal.node_ child) (Internal.node_ parent))
```

Each specialized alias is `= default_core`, with a narrower type annotation. Elm's inference specializes the type variables per binding.

```elm
radio :
    Radio.Builder a s msg
    -> RadioGroup.Builder ra { rs | default : filled } msg
    -> RadioGroup.Builder ra { rs | default : Filled } msg
radio = default_core

card :
    Card.Builder a { c | title : Filled, action : Filled } msg
    -> RadioGroup.Builder ra { rs | default : filled } msg
    -> RadioGroup.Builder ra { rs | default : Filled } msg
card = default_core
```

---

## 6. User-facing API examples

Consumers import the container's main module and its `.Slots` sub-module. Because Elm forbids two imports sharing the same alias, `.Slots` uses a distinct alias (convention: `Slots`).

### 6.1 Kinded slot (Select's `default : option`-kind)

```elm
import M3e.Build.Select as Select
import M3e.Build.Select.Slots as Slots
import M3e.Build.Option as Option

view : Element { kind | select : Supported } Msg
view =
    Select.select
        |> Slots.option (Option.option { value = "a", label = "A" })
        |> Slots.option
            ( Option.option { value = "b", label = "B" }
                |> Option.disabled True
            )
        |> Select.build
```

`Select.select` and `Select.build` come from `M3e.Build.Select`. `Slots.option` comes from `M3e.Build.Select.Slots`.

### 6.2 Arbitrary slot (RadioGroup's `default`)

```elm
import M3e.Build.RadioGroup as RadioGroup
import M3e.Build.RadioGroup.Slots as Slots
import M3e.Build.Radio as Radio
import M3e.Build.Divider as Divider

view =
    RadioGroup.radioGroup
        |> RadioGroup.name "flavor"
        |> Slots.radio (Radio.radio |> Radio.value "vanilla")
        |> Slots.divider Divider.divider
        |> Slots.radio (Radio.radio |> Radio.value "chocolate")
        |> RadioGroup.build
```

### 6.3 Container child (Card inside BottomSheet)

```elm
import M3e.Build.BottomSheet as BottomSheet
import M3e.Build.BottomSheet.Slots as Slots
import M3e.Build.Card as Card

view =
    BottomSheet.bottomSheet
        |> Slots.card
            ( Card.card
                |> Card.title (Kit.text "Details")
                |> Card.action myFooter
                |> Card.elevation 4
            )
        |> BottomSheet.build
```

If `Card.action` is omitted and Card's `action` slot is required-multi, the parenthesized pipeline ends with `action : NotFilled`. `Slots.card` demands `action : Filled`. TYPE MISMATCH — pointing at the parenthesized expression.

### 6.4 Consuming multiple containers' slots in one view

If a view constructs both a Select and a RadioGroup, each container's `.Slots` gets its own alias:

```elm
import M3e.Build.Select as Select
import M3e.Build.Select.Slots as SelectSlots
import M3e.Build.RadioGroup as RadioGroup
import M3e.Build.RadioGroup.Slots as RadioGroupSlots
```

Verbose but explicit. In practice a single view typically deals with one container's slots at a time.

---

## 7. Safety invariants

The type system enforces:

1. **Enum tokens** — unchanged, via `M3e.Value` axes.
2. **Slot kind matching** — kinded slot aliases demand a specific kind-row on the child. Arbitrary slot aliases accept any kind row.
3. **Required attributes** — passed as a seed record (unchanged).
4. **Optional-singular dedup** — each `Available → Used` transition consumes the capability; double-apply is a TYPE MISMATCH.
5. **Required-multi completeness** — the child's `slotCaps` in a slot alias's input type demands specific fields at `Filled`. A pipeline that fails to fill them produces `NotFilled`, which doesn't unify.
6. **Kind-row escape isolation** — `Internal.wrap_` and `Internal.node_` are internal helpers. Users have no route to construct a Builder with a fabricated kind row.

Every guarantee ⑤ delivered before survives, plus:

7. **Container-as-child completeness** — the alias's extensible-row input type pins required-multi fields to `Filled`, gating incomplete containers without needing a separate `Sealed` marker.

The ⑤ shape continues to need **no elm-review rules**. Types cover everything.

---

## 8. Generator responsibilities

### 8.1 Per-component (`M3e.Build.<Comp>.elm`)

1. Emit type alias `Builder attrCaps slotCaps msg = Internal.Builder { kind | <comp> : Supported } attrCaps slotCaps msg`.
2. Emit `AttrCaps` (fields for optional attrs and events).
3. Emit `SlotCaps` (fields for optional-singular and required-multi slots).
4. Emit the seed function — takes required attrs as a record, returns `Builder AttrCaps SlotCaps msg` with a Node stub containing the bottom-layer render function.
5. Emit one setter per optional attr, event, and optional-singular slot (Available → Used ratchet).
6. Emit **no cross-component slot setters** in this file.
7. Emit `.build`: `Builder a { s | <required-multi-1> : Filled, <required-multi-2> : Filled, ... } msg -> Element { kind | <comp> : Supported } msg`. The input's slotCaps constraint is an extensible row pinning only the component's required-multi fields; optional-singular slot fields stay polymorphic.

### 8.2 Per-container `.Slots` (`M3e.Build.<Comp>.Slots.elm`)

Generated only if the container has at least one slot that can hold a child (i.e., has multi slots or optional-singular slots where children are meaningful).

1. Emit one polymorphic private core setter per slot (`<slot>_core`).
2. For every allowed child component (per §5.1 rules), emit one specialized alias `= <slot>_core` with a narrowed type.
3. Import every referenced child module by qualified name; `.Slots` is the only place cross-component imports happen.

### 8.3 What survives from Tasks 1–3

- Task 1 (`Shape5` variant, `shapesFor`, Facts alias) — unchanged.
- Task 2 (`M3e.Build.Internal` markers) — unchanged; add `wrap_` and `node_` helpers.
- Task 3 (`codeShape5 : Maybe String` in ExampleRecord) — unchanged.

### 8.4 What gets rewritten

- Task 4 (`generateBuildModule` skeleton) — restructured for the new module layout.
- Task 5 (Fields alias + seed) — Fields disappears; seed constructs a Node directly.
- Task 6/7/8 (setters) — attr/event setters unchanged in spirit; slot setters MOVE to `.Slots` sub-module.
- Task 9 (`build` terminal) — simpler: just an `Element.fromNode` wrapping the Builder's Node.
- Task 10 (type-behavior test) — rewritten to match the new API.

---

## 9. Migration story

**In-repo consumers.** No shipped consumer uses ⑤ yet — the entire ⑤ surface is post-Task-10 experimental. There are no user-facing migrations.

**Existing artefacts to replace:**

- `packages/m3e/src/M3e/Build/*.elm` — regenerated wholesale.
- `packages/m3e/tests/BuildShapeTest.elm` and `BuildShapeNegative.elm` — rewritten against the new API.
- `elm-cem/codegen/Generate.elm` — `generateBuildModule` gutted and rebuilt to emit two files per container (main + `.Slots`).

**Path to landing:**

1. Plan the sequence (writing-plans).
2. Execute via SDD with fresh implementer per task.
3. After every task, verify: (a) `pnpm run test` in `elm-cem` passes; (b) `elm make --docs=/tmp/x.json` in `packages/m3e` succeeds; (c) Task-10-equivalent tests pass.
4. Final DoD check before shipping.

---

## 10. Cross-spec invariants

- **Shape3** (`M3e.<Comp>`) unaffected. It uses `Content` and closed-row kind gates; independent of ⑤.
- **Shape4** (`M3e.Record.<Comp>`) unaffected.
- **Facts** — `M3e.Review.Facts.Shape` retains `Shape5`. No field additions needed.
- **Rules** — ⑤ still needs zero elm-review rules; types cover everything.
- **Gradient** — ⑤ output is still `M3e.Element.Element`, same as ③/④; single `toHtml` at the app root remains the only eager point.
- **ADR 0013 amendment** — unchanged in spirit. This spec refines the specific *encoding* of the ⑤ builder pattern; ADR's monotonic-safety table is preserved.

---

## 11. Definition of done

- [ ] `elm-cem/codegen/Generate.elm` emits per-component modules and per-container `.Slots` sub-modules matching this spec.
- [ ] All 128 components produce a `M3e.Build.<Comp>.elm`.
- [ ] Every container with slots that can hold children produces a `M3e.Build.<Comp>/Slots.elm`.
- [ ] `elm make --docs=/tmp/out.json` in `packages/m3e/` succeeds — all exposed modules compile.
- [ ] `packages/m3e/tests/BuildShapeTest.elm` (positive) compiles cleanly with cases covering:
  - Kinded slot + leaf child, no `.build` on child.
  - Arbitrary slot + leaf child.
  - Arbitrary slot + heterogeneous leaf children (row unification test).
  - Arbitrary slot + container child with all required-multi filled.
- [ ] `packages/m3e/tests/BuildShapeNegative.elm` (negative) fails to compile with:
  - Double-apply of optional-singular attr (Available/Used).
  - Missing required-multi slot on the root builder.
  - Missing required-multi slot on a nested container child (via the crossbar alias's extensible-row Filled pin).
  - Wrong kind child in a kinded slot (Radio into Select's option-only slot).
- [ ] `packages/m3e/tests/run-build-shape-tests.sh` exits 0.
- [ ] `pnpm run test` in `elm-cem/` passes (golden tests updated).
- [ ] Documentation entries on every exposed decl (elm make --docs requirement).
- [ ] `docs/superpowers/plans/2026-07-04-build-shape-emitter.md` marked superseded.
- [ ] The Task-9 minor finding (unused `slotAttrB`) has already been fixed as part of the current epic; verify no equivalent dead code in the new emission.

---

## 12. Deferred / follow-ups

- **Fused seed+insert setters** (e.g., `Select.option { value = "a", label = "A" }` combining Option's seed and Select's slot in one call). Discussed and set aside — the parenthesized-pipeline form is general enough and doesn't lose flexibility for children with optional attrs or slots. Fusion can land as a follow-up ergonomic layer if desired.
- **⑤-shape sample gallery in docs-app.** No docs-app example currently consumes ⑤. Add representative examples once the API is stable.
- **`M3e.Build` barrel module.** Deferred per the original spec's decision; user-facing imports remain per-component.
