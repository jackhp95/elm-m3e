# Review Rules — safety net for the first-ship top layer (epic #138)

Date: 2026-07-04
Status: Proposed — blocking gate is user review before implementation.
Ship: first — coordinated with generator (already shipped) and facts (already shipped)
per the [shipping coordination doc](2026-07-03-epic-138-shipping-coordination.md).
Governing ADR: [0012 (accepted)](../../adr/0012-codegen-aware-elm-review.md).

## 1. Purpose

Ship the codegen-aware elm-review rule set that turns `M3e.Review.Facts` into
runtime guarantees at the top layer. The rules cover the correctness gaps the
loose Shape3 (and, for a couple of gaps, Shape4) API deliberately leaves at the
type level — missing required attributes, missing required-singular slots,
duplicated singular setters, and shorthand → specific rewrites.

Facts is shape-agnostic; the rules are shape-aware. Each rule reads Facts and
walks the AST to enforce the corresponding guarantee at call sites, on the
codebase's chosen top surface.

## 2. Scope

**In.**
- Four new rule modules: `MissingRequiredAttribute`, `MissingRequiredSingularSlot`,
  `SingularAttribute`, `PreferSpecificSlot` (autofix).
- Two modifications to existing rules: `RequireSlot` (harden with dynamic
  content-list tracing) and `SingularSlot`/`ValidEnumValue` (retrofit for
  Shape4 call-site coverage via a shared helper).
- One new shared helper module: `review/src/Facts.elm`, exposing `callSite`
  (call → `{ noun, shape }` resolver), `find` (fact lookup), and `tracedList`
  (progressive list-content resolver used by every list-analyzing rule).
- Wiring in `review/src/CodegenReviewConfig.elm`.
- Full test suite in `review/tests/` — each rule gets a `Review.Test` suite
  covering both Shape3 and Shape4 call forms (per-component and barrel).

**Out.**
- The third-ship codegen-aware translator (ADR 0013): moving a call between
  any two of the five API surfaces. Rules assume a codebase converges to one
  canonical shape; the translator enforces the convergence and ships later.
- Any Facts schema extension. The facts spec is stable; rules read what's
  emitted today. Detection conventions for required attributes (aria-* →
  `M3e.Aria.<field>`, etc.) live in the rule code, not Facts.
- Bottom-layer (`M3e.Cem.Html.*`) call sites. Only the top layer's ③/④
  surfaces are enforced. Middle-layer sites (`M3e.Cem.<Comp>`) are also out —
  they're the escape hatch by design.
- Fully-general dynamic content evaluation. `tracedList` ships progressive
  tracing (see §5) and grows over time; it will never simulate `List.map` on
  runtime data.

## 3. Rule roster (seven rules — four new, three modified)

| Rule | Kind | Facts fields | Autofix |
|---|---|---|---|
| `MissingRequiredAttribute` | new | `requiredAttrs` + rule-internal conventions | no |
| `MissingRequiredSingularSlot` | new | `requiredSlots ∖ multiSlots` | no |
| `SingularAttribute` | new (sibling of `SingularSlot`) | AST-only (no multi-attrs today) | no |
| `PreferSpecificSlot` | new | `attrRewrites`, `slotRewrites` | **yes** |
| `RequireSlot` | modified — dynamic tracing + Shape4 coverage | `requiredSlots ∩ multiSlots` | no |
| `SingularSlot` | modified — Shape4 coverage via shared helper | `multiSlots` | no |
| `ValidEnumValue` | modified — Shape4 coverage via shared helper | `enums` | no |

Rules that ship elsewhere in `review/src/` and are unaffected by this spec:
`NoActionlessButton`, `NoProprietaryDsClasses`, `NoSeamOutsideAllowedModules`.

## 4. Shared helper — `review/src/Facts.elm`

A single new module centralizes the two things every rule needs.

### 4.1 Call-site resolution

```elm
type Shape
    = Shape3
    | Shape4


type alias CallSite =
    { noun : String
    , shape : Shape
    }


{-| Resolve a function-reference AST node to the top-layer component and shape
it names, if any. Handles all four forms:

- `M3e.Button.view` → `{ noun = "button", shape = Shape3 }`
- `M3e.Record.Button.view` → `{ noun = "button", shape = Shape4 }`
- `M3e.button` (barrel constructor) → `{ noun = "button", shape = Shape3 }`
- `M3e.Record.button` (Shape4 barrel) → `{ noun = "button", shape = Shape4 }`

Returns `Nothing` for non-top-layer references (`M3e.Cem.*`, `M3e.Cem.Html.*`,
`Html.*`, etc.) so rules stay scoped to the top layer.
-}
callSite : ModuleNameLookupTable -> Node Expression -> Maybe CallSite
```

### 4.2 Fact lookup

```elm
type alias FactsIndex =
    Dict String Fact


{-| Index a list of facts by noun. Callers build the index once at rule init
and share it via `Context`. -}
buildIndex : List Fact -> FactsIndex


{-| Look up a fact by noun. -}
find : String -> FactsIndex -> Maybe Fact
```

### 4.3 Progressive list-content resolver

```elm
type alias TracedList =
    { known : List (Node Expression)
    , unresolved : Bool
    }


{-| Resolve a `List` expression to its statically-knowable elements, unwrapping
common concat and reference patterns. `.unresolved` is `True` iff any part of
the expression couldn't be traced (rules that care about presence stay silent
when `.unresolved` is `True` and no static element satisfies).
-}
tracedList : Context -> Node Expression -> TracedList
```

Tracing capability ships **progressively**. The implementer starts at the
Basic level, adds Medium and Ambitious cases until they can't extend further
against real code, then moves on:

- **Basic** (must ship):
  - Bare literal `[a, b, c]`.
  - Bare variable reference — trace to its `let` or module-level definition.
  - Two-literal concat: `[a] ++ [b]`.
- **Medium** (should ship):
  - Partial concat: `[a] ++ dynamic`, `dynamic ++ [a]` — capture the literal
    half, mark `unresolved = True`.
  - `List.append [a] [b]`, `List.concat [[a], [b]]` — treat as concat.
  - Pipeline chains: `attrs |> (::) firstAttr |> ...`.
- **Ambitious** (best effort):
  - Trace across module boundaries when the source is available.
  - Inspect `List.map (\x -> Setter args)` lambdas: if the lambda always
    produces one identifiable setter regardless of `x`, count it as present
    once — with `unresolved = True` because the count is unknown.
  - `case ... of` scrutinees where every branch produces a literal list.

Reference: `jfmengels/elm-review-common`'s `NoCognitiveComplexity` rule uses
similar AST traversal for branch-following; borrow its patterns for `case`,
`if`/`else`, and function-body inspection.

## 5. Rule details

### 5.1 `MissingRequiredAttribute` (D1)

**Fires:** any Shape3 or Shape4 call to a component whose `requiredAttrs` is
non-empty AND none of the attrs list satisfies the required attribute.

**Detection conventions (in the rule):**

For each `requiredAttrs` entry, the rule looks for a satisfier in the attrs
list (via `tracedList`) using these conventions:

- **`aria-*` attrs** — canonical satisfier is `M3e.Aria.<lowerCamel(name)>`.
  Example: `aria-label` → `M3e.Aria.label`. `aria-labelledby` →
  `M3e.Aria.labelledby`.
- **Other attrs** — canonical satisfier is the per-component setter
  `M3e.<Comp>.<camelCase(name)>`, e.g., a hypothetical `for` required-attr on
  `Autocomplete` would look for `M3e.Autocomplete.for`.
- **Universal escape hatch** — `M3e.Cem.Attr.attribute "<name>" ...` satisfies
  any required attr with a matching first argument. Rule detects the string
  literal.

**Shape4 specifics.** When called via `M3e.Record.<Comp>.view` (or its barrel
alias `M3e.Record.<comp>`), the required record MIGHT carry an attribute-shaped
field (e.g., an `ariaLabel : String` field satisfies `aria-label`). The rule
inspects the record literal's fields to check.

**Silence on unresolved attrs.** If `tracedList` returns `unresolved = True`
and no static element satisfies, the rule STAYS SILENT — non-verifiable code
is not the rule's problem to catch. Advisory posture.

**Error message.**
```
Component `<X>` requires attribute `<Y>` but this call doesn't provide it.

The Material 3 spec (and accessibility guidance) treats `<Y>` as required for
<X>. Add `M3e.Aria.label "..."` (or your codebase's equivalent) to the attrs
list, or move to the record form (`M3e.Record.<X>.view`) if `<Y>` lives in
its record.
```

### 5.2 `MissingRequiredSingularSlot` (D2)

**Fires:** Shape3 call whose content list doesn't include a required-singular
slot setter.

**Applies to Shape3 only.** Shape4's required record enforces required-singular
at compile time. Rule short-circuits on Shape4 calls.

**Detection.** For each singular-required slot (name in `requiredSlots` but
NOT in `multiSlots`), the setter name comes from `slotRewrites` — look for a
call to `M3e.<Comp>.<setterName>` in the traced content list.

**Silence on unresolved content.** Same posture as D1.

**Error message.**
```
Component `<X>` requires content slot `<Y>` but the content list doesn't fill it.

Add `M3e.<X>.<setter> <value>` to the content list, or use the record form
`M3e.Record.<X>.view` which enforces this at the type level.
```

### 5.3 `SingularAttribute` (D3 new)

**Fires:** attrs list contains 2+ calls to the same attribute setter.

**Applies to any shape.** Both Shape3 and Shape4 calls have a `List Attr`
argument; the check is identical.

**Detection.** In the traced attrs list, group calls by setter identity (module
+ name resolved via `ModuleNameLookupTable`). Flag any setter that appears >1
times, once per repeat.

**No multi-attribute concept today.** If a future config declares a multi-attr,
the rule extends to skip it — but no such data exists in the current Facts
schema.

**Sibling of `SingularSlot`.** Mirror naming; mirror mechanics (SingularSlot
already flags duplicates in the content list).

**Error message.**
```
Attribute `<Y>` is set more than once on this call.

HTML allows only one value per attribute; the browser will silently keep one
and discard the others. Merge or delete the extras.
```

### 5.4 `PreferSpecificSlot` (D4 — autofix)

**Fires (attr case):** attrs list contains `M3e.<barrelName>` where the target
component's `attrRewrites` maps `barrelName → perCompName`. Autofix rewrites
`M3e.<barrelName>` → `M3e.<Comp>.<perCompName>`.

**Fires (slot case):** content list contains
`M3e.Cem.Attr.slot "<slotName>" body` where the component's `slotRewrites`
maps `slotName → setterName`. Autofix rewrites the entire subexpression to
`M3e.<Comp>.<setterName> body`.

**Autofix rules:**
- Only rewrite when the rewrite is unambiguous — a single-target rewrite from
  a single setter.
- Preserve the argument sub-expressions verbatim.
- Rewrite the module qualifier via `Review.Fix.replaceRangeBy`. Elm's import
  resolution: if `M3e.<Comp>` isn't imported yet, add the import (via
  `Review.Fix` + import-insertion — see the `elm-review` cookbook).
- On the slot case, the fix drops the `M3e.Cem.Attr.slot "<slotName>"`
  wrapper and swaps in the per-component setter.

**Silence on unresolved lists.** Same posture — an unresolved list means we
can't safely rewrite what we can't fully see.

**Error message.**
```
`<barrel-shorthand>` can be replaced with the per-component setter
`M3e.<Comp>.<specific>` for tighter type safety.
```
(Autofix applies.)

### 5.5 `RequireSlot` (D5 — hardened)

**Existing rule.** Flags required-multi slots absent from the content list.

**Hardening.** Adopt `tracedList` in place of the current inline "is this a
`ListExpr`?" check. Once `tracedList` runs, the rule's checks operate on
`.known` and consult `.unresolved` for silence policy.

**Coverage improvement.** The current rule stays silent on `myContent` (bare
variable), `[literal] ++ dynamic`, `List.map (\x -> x) items` — all
false-negatives. Post-harden:
- Bare variables resolve.
- `[literal] ++ dynamic` sees the literal half.
- `List.map` cases surfaced by the progressive resolver.

**No message change.** Same advisory error text as today. What changes is
WHICH call sites it fires on.

### 5.6 Retrofit of `SingularSlot` and `ValidEnumValue`

Replace each rule's inline `constructorNoun` helper with `Facts.callSite`.
Effect: both rules now cover Shape4 call sites (previously they silently
ignored `M3e.Record.<Comp>.view` calls). No other behavior change.

Both rules also adopt `Facts.tracedList` for their list-analyzing steps,
gaining the same dynamic tracing improvements as D5.

## 6. File structure

```
review/src/
  Facts.elm                              -- NEW: shared helper
  MissingRequiredAttribute.elm           -- NEW
  MissingRequiredSingularSlot.elm        -- NEW
  SingularAttribute.elm                  -- NEW
  PreferSpecificSlot.elm                 -- NEW (with autofix)
  RequireSlot.elm                        -- MODIFIED: tracing + shared helper
  SingularSlot.elm                       -- MODIFIED: shared helper + tracing
  ValidEnumValue.elm                     -- MODIFIED: shared helper
  CodegenReviewConfig.elm                -- MODIFIED: wire all seven rules

review/tests/
  FactsTest.elm                          -- NEW: covers callSite, tracedList
  MissingRequiredAttributeTest.elm       -- NEW
  MissingRequiredSingularSlotTest.elm    -- NEW
  SingularAttributeTest.elm              -- NEW
  PreferSpecificSlotTest.elm             -- NEW (autofix cases + non-fix cases)
  RequireSlotTest.elm                    -- EXTENDED: dynamic-content cases
  SingularSlotTest.elm                   -- EXTENDED: Shape4 + dynamic cases
  ValidEnumValueTest.elm                 -- EXTENDED: Shape4 cases
```

## 7. Cross-spec invariants respected

Per the [coordination doc](2026-07-03-epic-138-shipping-coordination.md):

- Every `requiredAttrs` fact is drawn from CEM + config. **✓** — the rule
  reads Facts verbatim; the detection conventions live in the rule, not in a
  synthesized fact.
- Every shorthand ↔ specific pair the generator emits comes from the same
  setter-name resolution the top-layer setters already use. **✓** —
  `PreferSpecificSlot`'s rewrite target is exactly what `attrRewrites` /
  `slotRewrites` names. The Task 1-3 review of the facts spec confirmed
  byte-identity between rewrite targets and emitted setters.
- Per-component shape metadata reflects exactly what shapes actually take at
  that component. **✓** — `Facts.callSite` reads `shapes` and matches its
  return against the caller's module path. A mismatch (e.g., a Shape4 call
  to a `shapes = [ Shape3 ]` component) would be flagged as a Facts
  invariant violation.
- No ⑤-specific fields consumed. **✓** — `Facts.Shape` is `Shape3 | Shape4`
  only; `callSite` returns `Nothing` for any module path outside those.

## 8. Migration story

Existing users of `ValidEnumValue`, `SingularSlot`, `RequireSlot` — the three
rules that already ship via `CodegenReviewConfig` — see:

- No breaking API change: the `rule : List Fact -> Rule` signature is
  preserved.
- New reports on Shape4 call sites (previously silently ignored).
- New reports on previously-dynamic content lists in the case of `RequireSlot`
  and `SingularSlot`.

Config authors who want to preserve the old (Shape3-only, literal-only)
behavior can pin an older version of the rules module — but the coordination
doc treats this as intentional strengthening; downgrade support is not
provided.

## 9. Definition of done

- Seven rules ship in `review/src/` (four new, three modified).
- `Facts.elm` shared helper exposes `callSite`, `find`, `buildIndex`,
  `tracedList` with the signatures in §4.
- `tracedList` covers at minimum Basic + Medium levels. Ambitious cases land
  as far as the implementer can push against real docs-app code before
  moving to the next task.
- Each rule has a `Review.Test` suite in `review/tests/`. New tests cover:
  - Positive case (rule fires when expected).
  - Negative case (rule stays silent when the requirement is satisfied).
  - Shape3 and Shape4 call forms (per-component AND barrel).
  - Unresolved content — verify silence.
- `elm-review --config review/ docs/app` completes cleanly OR reports only
  the new errors that reflect real issues (documented as the intended
  behavior, not regressions).
- `elm-cem` regen + full package build stays green.
- `CodegenReviewConfig.elm` wires the seven rules against
  `M3e.Review.Facts.facts`.
- `PreferSpecificSlot`'s autofix produces code that compiles (verified in
  test suite via `Review.Test.expectedFix`).

## 10. Open sub-questions

Resolved during implementation review, not blocking approval:

- Exact naming of the shared helper's exposed types (`Facts.CallSite` vs
  `Facts.Site` vs …). Implementer picks; the module is small.
- Whether `Facts.tracedList` should return a `Result String TracedList`
  (with an error message for the unresolved case) or a plain `TracedList`.
  The design here uses `TracedList` with an `unresolved : Bool` flag;
  simpler for callers.
- How to author the `M3e.Aria.<field>` mapping for D1. Simplest today:
  hardcode the three known aria fields (`label`, `labelledby`, `describedby`)
  in the rule. If a fourth aria helper ever lands, one line changes.
