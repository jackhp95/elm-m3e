> **SUPERSEDED (2026-07-04)** — Replaced by `docs/superpowers/plans/2026-07-04-build-shape-crossbar.md`.
> The emitter Tasks 4–10 in this file were rewritten during the crossbar redesign;
> Tasks 1–3 survived. See `docs/superpowers/specs/2026-07-04-build-shape-crossbar-design.md`
> for design rationale.

# ⑤ Build shape emitter — `M3e.Build.*` (epic #138 second ship)

Date: 2026-07-04
Status: Proposed — blocking gate is user review before implementation.
Ship: second — the ⑤ shape. Standalone in coordination terms; no facts/rules
companion (per the [shipping coordination doc](2026-07-03-epic-138-shipping-coordination.md)).
Governing ADR: [0013 (amended)](../../adr/0013-top-shape-matrix-and-translation.md).
Prior art: [spike design](2026-07-03-build-shape-codegen-spike-design.md)
+ [spike result (PASS)](2026-07-03-build-shape-codegen-spike-result.md).

## 1. Purpose

Add the ⑤ Build shape emitter to `elm-cem`, producing per-component
`M3e.Build.<Comp>` modules and a single generator-emitted `M3e.Build.Internal`.
⑤ delivers compile-time enforcement of the safety guarantees that ③ and ④ push
to elm-review: duplicate-singular becomes a TYPE MISMATCH, and required-multi
slots become type-enforced via a `NotFilled → Filled` ratchet.

⑤ is purely additive. No consumer-facing coupling to the first ship's ③/④
generator, facts module, or review rules. Consumers who want the extra safety
opt in per call site by importing `M3e.Build.<Comp>` instead of `M3e.<Comp>`
or `M3e.Record.<Comp>`.

## 2. Scope

**In.**
- New emitter `generateBuildModule` in `elm-cem/codegen/Generate.elm`; emits one `M3e.Build.<Comp>.elm` per component, for every component (128 today).
- New generator-emitted `M3e.Build.Internal.elm` exposing `Available`, `Used`, `NotFilled`, `Filled` marker types.
- Extend `Shape` type in `Generate.elm` and in the emitted `M3e.Review.Facts` to `Shape3 | Shape4 | Shape5`. Extend `shapesFor` to always include `Shape5`. Extend the emitted per-component `shapes` field in Facts accordingly.
- Extend the per-component facts config with a `codeShape5 : Maybe String` example alongside `codeShape4` (issue #143's mechanism).
- GoldenTest additions: assert on the emitted `X/Build/Foo.elm` and cover all four setter templates.
- One type-behavior test (`packages/m3e/tests/BuildShapeTest.elm`) proving the compile-time guarantees on a representative component.

**Out.**
- No barrel `M3e.Build.elm`. ⑤'s pipeline API is per-component-import shaped; a barrel adds noise and can't cleanly re-export the pipeline setters. Symmetric with the middle layer's barrel-lessness.
- No new elm-review rules. ⑤'s guarantees are type-level; the first-ship review net remains scoped to ③ and ④.
- No third-ship translator work. The translator is a separate ship; this spec only ensures ⑤ has the same underlying IR (`Element supported msg`) so translation between the five surfaces stays mechanical.
- No changes to config authoring beyond adding `codeShape5` examples. `config/slots.json` is untouched.

## 3. File layout

```
packages/m3e/src/M3e/Build/
  Internal.elm                       -- Available, Used, NotFilled, Filled
  <Component>.elm                    -- 128 per-component modules
```

Every component gets a Build module, including degenerate components with no
optional-singular fields (their `AttrCaps` / `SlotCaps` rows are empty). Uniform
emission — no gating.

## 4. `M3e.Build.Internal`

```elm
module M3e.Build.Internal exposing (Available, Used, NotFilled, Filled)

{-| Marker types for `M3e.Build.*` capability-row phantoms.

The `Available → Used` transition guards optional-singular setters: applying
a setter twice is a compile-time TYPE MISMATCH. The `NotFilled → Filled`
ratchet guards required-multi slots: `build` refuses to type-check when a
required-multi slot has zero applications.

@docs Available, Used, NotFilled, Filled

-}

type Available = Available
type Used = Used
type NotFilled = NotFilled
type Filled = Filled
```

Generator-emitted via `Elm.customType`. Fully opaque; consumers never construct
values of these types directly.

## 5. Per-component module shape

For a component `<Comp>` with lowercased noun `<comp>`:

```elm
module M3e.Build.<Comp> exposing
    ( Builder, AttrCaps, SlotCaps
    , <comp>
    , <optional-singular attr setters…>
    , <event setters (all consuming-singular)…>
    , <optional-singular slot setters…>
    , <optional-multi slot setters…>
    , <required-multi slot setters…>
    , build
    )
```

### 5.1 Opaque `Builder`

```elm
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)
```

`Fields msg` is a private record with:
- Fields for every required-singular field (from the ④ record shape).
- Fields for every optional attr / slot, typed `Maybe SomeValue` (attr) or `List (Content …)` / `Maybe (Content …)` (slot).

The consumer never sees the `Fields` payload. `attrCaps` and `slotCaps` are
phantom parameters carrying per-component capability rows.

### 5.2 `AttrCaps` / `SlotCaps` type aliases

Named row aliases keep `docs.json` clean (spike learning #2 — inlined records
explode signatures):

```elm
type alias AttrCaps =
    { variant : Available
    , disabled : Available
    , onClick : Available
    …
    }


type alias SlotCaps =
    { icon : Available
    , trailingIcon : Available
    , children : NotFilled       -- required-multi field: starts NotFilled
    …
    }
```

Field ordering follows the CEM-derived spec order (matches the ordering used
elsewhere in the generator). Empty rows (no optional fields) yield
`type alias AttrCaps = {}`.

### 5.3 Seed function

```elm
<comp> : <RequiredRecord> -> Builder AttrCaps SlotCaps msg
<comp> req =
    Builder
        { <required-singular fields inserted from req>
        , <optional fields set to `Nothing` or empty list defaults>
        }
```

The seed name is the component's lowercased noun (`button`, `card`, `iconButton`).
Body construction uses a generator-emitted `defaults : Fields msg` value plus
`Elm.updateRecord` — avoids listing every optional field in every seed body.

### 5.4 Setter templates

Four templates, generated based on cardinality × required flag:

**Optional-singular (attr, event, or slot):** `Available → Used` consuming.

```elm
variant : Value -> Builder { a | variant : Available } s msg
                -> Builder { a | variant : Used } s msg
variant value (Builder fields) =
    Builder { fields | variant = Just value }
```

Double-apply is a TYPE MISMATCH (`Used` doesn't unify with `Available`).

**Optional-multi:** pass-through, no phantom tracking.

```elm
media : Element … msg -> Builder a s msg -> Builder a s msg
media el (Builder fields) =
    Builder { fields | media = fields.media ++ [ el ] }
```

Row unchanged; apply any number of times.

**Required-multi:** `NotFilled → Filled` ratchet with an open input variable.

```elm
child : Element … msg -> Builder a { s | children : filled } msg
                     -> Builder a { s | children : Filled } msg
child el (Builder fields) =
    Builder { fields | children = fields.children ++ [ el ] }
```

Lowercase `filled` on the input row lets the setter accept both `NotFilled`
(first call) and `Filled` (subsequent calls). Output is always `Filled`. The
ratchet pattern is validated in `elm-cem/spikes/build-shape/ratchet-check/`.

**Required-singular:** no setter — the field lives in the seed's required
record (inherited from ④'s record shape). ⑤ is strictly stronger than ④ for
required-singular: same compile-time enforcement, plus dup-impossibility on
the optional siblings.

### 5.5 `build` terminal

```elm
build : Builder a { s | <required-multi rows required as Filled> } msg
        -> Element … msg
build (Builder fields) =
    <same view construction as Shape3/Shape4, wrapped in Element>
```

`build` places no constraint on optional-singular caps (they can be in any
state — `Available` if never set, `Used` if set once). It DOES constrain every
required-multi row to `Filled`.

Result type: `Element supported msg` where `supported` matches the phantom
kind rows Shape3/Shape4 return. Same eager point: the single `M3e.Node.toHtml`
at the app root.

## 6. Generator changes (`elm-cem/codegen/Generate.elm`)

### 6.1 Type extension

```elm
type Shape
    = Shape3
    | Shape4
    | Shape5
```

The doc comment updates to remove the "in the second ship it gains Shape5"
placeholder; the type is complete now.

### 6.2 `shapesFor` extension

```elm
shapesFor : Config -> LibraryInfo -> Cem.Declaration -> List Shape
shapesFor config libraryInfo decl =
    -- ... existing Shape3 + Shape4 logic ...
    let
        base = existing_result
    in
    base ++ [ Shape5 ]
```

Every component includes `Shape5`. No gating.

### 6.3 `generateTopModules` dispatch

The dispatch loop gets a `Shape5 -> generateBuildModule` case alongside `Shape3` and `Shape4`.

### 6.4 `generateBuildModule`

New function; consumes `SharedCtx` (from Task 3 of the shape-selector work).
Emits a `TopModule` with the module path `[lib, "Build", moduleName]` and file
contents matching §5.

Key sub-functions:
- `buildAttrCapsAlias : SharedCtx -> Elm.Declaration` — type alias for the attr capability row.
- `buildSlotCapsAlias : SharedCtx -> Elm.Declaration` — type alias for the slot capability row. Required-multi slots get `NotFilled` initial state; everything else gets `Available`.
- `buildSeedDecl : SharedCtx -> Elm.Declaration` — the seed function, using a private `defaults` binding to avoid re-listing every optional field.
- `buildSetterDecl : SharedCtx -> Attr.AttrSpec | SlotSpec -> Elm.Declaration` — chooses the right template (consuming, passthrough, ratchet) based on `slot.multi`, `slot.required`, and whether the value is a slot or attr.
- `buildTerminalDecl : SharedCtx -> Elm.Declaration` — the `build` function.

### 6.5 `M3e.Build.Internal` emission

Emit once from `generateFromManifest`, alongside the other runtime-ish
modules. Contents are fixed (see §4). Uses `Elm.customType "Available" [] []`
etc.

### 6.6 Facts extension

`generateReviewFacts` — extend `shapeName` and the emitted `type Shape` alias
to include `Shape5`. Every component's `shapes` field gains `Shape5`.

No other Facts field changes.

### 6.7 Barrel emission — untouched

`generateBarrelModule` continues to emit `M3e.elm` (Shape3 barrel) and
`M3e/Record.elm` (Shape4 barrel, gated on non-empty Shape4 set). No
`M3e/Build.elm` — per §2 scope.

## 7. Config extension (`codeShape5`)

`ExampleRecord` in `Generate.elm` gains `codeShape5 : Maybe String`, symmetric
with `codeShape4` (from issue #143). Config authors can supply a
Shape5-specific example (pipeline form); if absent, the docstring's example
section for `M3e.Build.<Comp>` falls back to the `codeShape4` value (Shape4's
record form is closest to Shape5's seed shape) or, failing that, the base
`code` (Shape3 form).

`config/examples.rich.json` and `config/examples.generated.json` need at
least one component populated with a `codeShape5` sample for the first cut
— Button is the natural choice.

## 8. Testing

### 8.1 GoldenTest additions

Extend the existing GoldenTest fixture (`elm-cem/tests/src/GoldenTest.elm`,
post issue #143's `x-foo` fixture) with assertions:

- `X/Build/Button.elm` present in the emitted set.
- `X/Build/Foo.elm` present (required-record component).
- `X/Build/Internal.elm` present.
- `X/Build/Button.elm` contains a `Builder`, `AttrCaps`, `SlotCaps`, seed, at
  least one consuming-singular setter, and `build` declaration.
- `X/Build/Foo.elm` contains a required-multi ratchet setter (unnamed slot).

Also update the module-structure test to include the new files.

### 8.2 Type-behavior test

A new `packages/m3e/tests/BuildShapeTest.elm` (or an equivalent inline probe)
that:

1. Positive: `Button.button {...} |> Button.variant ... |> Button.build`
   compiles.
2. Positive: multiple calls to a passthrough multi-setter compile.
3. Positive: multiple calls to a required-multi ratchet setter compile (both
   reach `Filled`).
4. Negative: `Button.button {...} |> Button.variant a |> Button.variant b`
   produces a TYPE MISMATCH between `Available` and `Used`.
5. Negative: a required-multi component seed piped directly to `build` (no
   ratchet call) produces a TYPE MISMATCH between `NotFilled` and `Filled`.

Negative cases can live in a separate file that is expected to fail
compilation; the test harness's `run.sh` model (from the spike) is a good
template — `elm make` on the positive file must succeed, `elm make` on the
negative file must fail with the expected error strings.

### 8.3 Compile check

After the regen, `packages/m3e/src/M3e.elm` must still compile. Expected
module count grows from 378 → 507 (+128 Build modules + 1 Internal).

`docs-app` compile unchanged (⑤ is opt-in; existing docs-app callers stay on
③/④).

`elm-cem` `pnpm run test` must stay green (baseline 116 → possibly +N with the
GoldenTest additions).

## 9. Cross-spec invariants respected

Per the [coordination doc](2026-07-03-epic-138-shipping-coordination.md) and
ADR 0013's amended matrix:

- **Purely additive.** No changes to first-ship generator, facts (schema),
  or rules. Consumer-facing coupling is nil.
- **All three top shapes return `Element supported msg`.** `build` returns
  `Element`, not `Html`. Single eager point (`M3e.Node.toHtml` at app root)
  unchanged.
- **No ⑤-specific facts fields in the first ship.** This is the second ship;
  Facts extends with `Shape5` in the enum but no new field type.
- **No elm-review rules.** ⑤'s guarantees are type-level; the first-ship
  review net stays scoped to ③ and ④.
- **Consuming-row pattern is spike-validated.** Ratchet pattern is validated
  in `elm-cem/spikes/build-shape/ratchet-check/` (this spec's prep phase).

## 10. Definition of done

- `elm-cem/codegen/Generate.elm` extended: `Shape5` variant, `shapesFor`
  always includes `Shape5`, `generateBuildModule` implemented, `Internal`
  emission, Facts `Shape` alias extended.
- `packages/m3e/src/M3e/Build/` contains 128 per-component modules +
  `Internal.elm`.
- `packages/m3e/src/M3e/Review/Facts.elm` regenerated: every component's
  `shapes` field includes `Shape5`.
- `packages/m3e/elm.json` `exposed-modules` synced (128 new entries for
  `M3e.Build.<Comp>` + `M3e.Build.Internal`).
- `packages/m3e/src/M3e.elm` compiles (507 modules).
- `docs/app` compiles.
- `elm-cem` tests green (116 baseline + GoldenTest additions).
- Positive type-behavior test compiles; negative type-behavior tests fail
  with the expected TYPE MISMATCH messages.
- No new elm-review errors (⑤ inert to the review net).
- `config/examples.generated.json` gains `codeShape5` on at least one
  component (Button) with a Shape5-style pipeline example; regenerated
  `M3e/Build/Button.elm` docstring shows that pipeline.

## 11. Open sub-questions

Resolved during implementation review, not blocking user approval:

- Exact `defaults`-record layout — depends on `Fields` payload shape.
  Implementer picks; must produce byte-identical output regardless of order.
- Whether `Builder`'s doc comment should call out that consumers should
  never construct one directly (it's opaque anyway; comment is belt-and-braces).
- Naming of the `build` function versus a possible collision with the app-root
  `M3e.Node.toHtml`. Gradient design §8 flagged this; no collision in practice
  (⑤'s `build` returns `Element`, `toHtml` takes `Node → Html`). No rename
  proposed; the concern was doc-style, not structural.
