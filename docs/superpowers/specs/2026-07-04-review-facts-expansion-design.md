# Review Facts — expansion for the first-ship rules (epic #138)

Date: 2026-07-04
Status: Proposed — blocking gate is user review before implementation.
Ship: first — coordinated with generator (already shipped) and rules per the
[shipping coordination doc](2026-07-03-epic-138-shipping-coordination.md).
Governing ADR: [0012 (accepted)](../../adr/0012-codegen-aware-elm-review.md).

## 1. Purpose

Finalize the schema of `M3e.Review.Facts` — the generated data table that
codegen-aware elm-review rules consume — so the five first-ship rules (D1–D5)
have every fact they need. Replaces the PROVISIONAL `shapes` and `requiredAttrs`
fields shipped in Task 7 of the generator refactor with a stable, shape-agnostic
schema.

Facts is per-COMPONENT and shape-agnostic. A component's semantic requirements
(which slots are required, which enum tokens are valid, which attributes must
be present) do not change based on which API surface (③, ④, ⑤) the caller uses.
Rules are shape-aware; Facts is shape-invariant. That separation is what makes
the third-ship translator possible: a Shape3 → Shape4 rewrite reads the same
Facts as a Shape4 lint, applying different structural interpretations.

## 2. Scope

**In.**
- Extend the `Fact` record with `attrRewrites`, `slotRewrites`, `shapes`, and
  finalized `requiredAttrs`.
- Remove Task 7's PROVISIONAL fields (`shapes : List String`, `requiredAttrs :
  List String`) and replace with typed `shapes : List Shape` and the same
  component-level `requiredAttrs : List String` (now sourced from config, not a
  generator heuristic).
- Add an optional `requiredAttrs : [name…]` field per component in
  `config/slots.json`. Generator reads verbatim; no CEM-inspection heuristics.
- Update the generator (`elm-cem/codegen/Generate.elm`'s `generateReviewFacts`)
  to emit the new schema.
- Update `M3e.Review.Facts.Shape` to be a first-class type (not a string alias).

**Out.**
- Any rule logic. The rules spec (workstream D, still to draft) is where D1–D5
  land.
- Any translator infrastructure (third ship).
- Any per-shape divergence within Facts. If `aria-label` ever moves into a
  Shape4 required record, the rules interpret that difference; Facts stays
  component-level.
- Any generator heuristics for `requiredAttrs`. m3e-specific "icon-only
  interactive component needs aria-label" is a config author's decision,
  encoded per component in `config/slots.json`, not derived from the CEM.

## 3. Schema

```elm
module M3e.Review.Facts exposing (Fact, Shape(..), facts)

type Shape
    = Shape3
    | Shape4


type alias Fact =
    { component : String
    , module_ : String
    , enums : List ( String, List String )
    , requiredSlots : List String
    , multiSlots : List String
    , attrRewrites : List ( String, String )
    , slotRewrites : List ( String, String )
    , shapes : List Shape
    , requiredAttrs : List String
    }


{-| GENERATED — per-component facts for the codegen-aware elm-review rules
(ADR 0012). Do not edit by hand; regenerate via `bin/elm-cem.js`.
-}
facts : List Fact
```

Every field is a plain data value the rule reads directly. No opaque values,
no computed fields. A rule reading Facts holds the full contract in one Elm
type.

## 4. Field semantics

### `component : String`

The barrel-lowercase noun (`"button"`, `"iconButton"`, `"splitButton"`). This
is the key rules use to identify a component from a barrel-form call like
`M3e.button [ … ]`.

### `module_ : String`

The component's Shape3 top-layer module (`"M3e.Button"`,
`"M3e.SplitButton"`). Rules use this to resolve a per-component call
(`M3e.Button.view […]`) to a component. Shape4 modules are derived by
convention: `"M3e.Record." ++ moduleTail` (e.g., `"M3e.Record.Button"`).

Kept identical to today's field; existing rules read it unchanged.

### `enums : List ( String, List String )`

Attribute-name → valid enum literal names. Drives `ValidEnumValue`.
Component-specific: Button's `variant` accepts one set of tokens, SplitButton's
`variant` accepts a different set. Kept identical to today.

### `requiredSlots : List String`

Kebab-case slot names the component treats as required. Drives `RequireSlot`
(hardened in D5) and `D2 missing-required-singular-slot`. Kept identical to
today.

### `multiSlots : List String`

Kebab-case slot names accepting multiple children. Drives `SingularSlot`.
Kept identical to today.

### `attrRewrites : List ( String, String )`

Exhaustive per-component list of `(barrelName, perComponentSetterName)`
tuples, covering every attribute AND event handler setter the component
exposes through both the `M3e.elm` barrel and its per-component `M3e.<Comp>`
module. (Both attribute setters and event handlers produce `Attr` values in
Elm and share the barrel re-export mechanism, so the rewrite treats them
uniformly.) For most cases the two names are identical (`("variant",
"variant")`, `("onClick", "onClick")`); for constructor-name collisions the
barrel suffixes (`("shapeAttr", "shape")`).

Drives `D4 PreferSpecificSlot` (attribute case): given a barrel call
`M3e.button [ M3e.variant filled ]`, the rule looks up `"variant"` in Button's
`attrRewrites`, finds `("variant", "variant")`, and rewrites to
`M3e.button [ M3e.Button.variant filled ]`.

### `slotRewrites : List ( String, String )`

Exhaustive per-component list of `(kebabSlotName, camelSetterName)` tuples for
every slot the component exposes. `("unnamed", "child")`, `("trailing-icon",
"trailingIcon")`.

Drives `D4 PreferSpecificSlot` (slot case): given
`M3e.Card.view [] [ M3e.Cem.Attr.slot "icon" x ]`, the rule looks up `"icon"`
in Card's `slotRewrites`, finds `("icon", "icon")`, and rewrites to
`M3e.Card.view [] [ M3e.Card.icon x ]`.

### `shapes : List Shape`

Which top-layer surfaces exist for this component. Always includes `Shape3`;
includes `Shape4` iff the component has a required record (`requiredSlots ≥ 1`
OR the config declares extras). Drives `D3 wrong-arity` — the rule resolves a
call's shape from its module path, checks `List.member shape f.shapes`, and
compares the argument count to the shape's known arity (`Shape3 → 2`,
`Shape4 → 3`).

Replaces Task 7's `shapes : List String` (with values `"Shape3"` / `"Shape4"`).

### `requiredAttrs : List String`

Component-level list of HTML attribute names the component treats as required
for correctness or accessibility (`["aria-label"]` for icon-only interactive
components in the m3e config). Empty for components with no attribute
requirements.

Drives `D1 missing-required-attribute`: a shape-aware rule checks whether the
caller passes each required attribute somewhere accessible (in the attribute
list on Shape3; in the attribute list or the required record on Shape4, once a
future config maps an attr into a record extra).

Replaces Task 7's `requiredAttrs : List String` (which was heuristic-derived
and always empty today). Now sourced purely from config.

## 5. Config source for `requiredAttrs`

Add a new optional field per component in `config/slots.json`:

```json
{
  "IconButton": {
    "required": { "action": "action:click,link,menuTrigger,..." },
    "requiredAttrs": ["aria-label"],
    "slots": { "unnamed": { "kinds": ["icon"], "required": true } }
  }
}
```

Generator reads the field verbatim, emits it into `Fact.requiredAttrs`. No
CEM inspection, no naming heuristics, no per-component special cases in codegen.
The m3e-specific decision "icon-only interactive components need aria-label"
lives entirely in this config file.

Components that omit the field emit `requiredAttrs = []`.

Config authoring is part of the first ship, not deferred. Identify each
component whose default slot's `kinds` list excludes `"text"` AND whose
config includes an `action` extra (i.e., interactive-without-a-text-slot);
add `"requiredAttrs": ["aria-label"]` to each. `IconButton` is the canonical
case. The DoD in §10 requires the resulting emitted facts to reflect this
authoring.

## 6. Rule → field mapping

| Rule | Fields |
|---|---|
| D1 missing-required-attribute | `requiredAttrs` |
| D2 missing-required-singular-slot | `requiredSlots` (existing) |
| D3 wrong-arity | `shapes` + rule's own knowledge of arity per Shape variant |
| D4 PreferSpecificSlot (attr case) | `attrRewrites` |
| D4 PreferSpecificSlot (slot case) | `slotRewrites` |
| D5 harden `RequireSlot` against non-literal content | no schema change (rule-side literal-detection tightening) |

Existing rules that don't change:

| Rule | Fields |
|---|---|
| `ValidEnumValue` | `component`, `enums` |
| `SingularSlot` | `requiredSlots`, `multiSlots` |
| `RequireSlot` (pre-D5) | `requiredSlots`, `multiSlots` |

None of these existing rules touch `.shapes`, `.requiredAttrs`, `.attrRewrites`,
or `.slotRewrites`. Migration for existing rule code is nil.

## 7. Generator changes

`elm-cem/codegen/Generate.elm::generateReviewFacts` (the string-emitter at
~line 620) is rewritten to emit the new schema. Specifically:

- Emit `type Shape = Shape3 | Shape4` above the `Fact` type alias.
- Compute `shapes` per component using the existing `shapesFor` helper (from
  the Task 1 refactor).
- Compute `attrRewrites` by iterating `SharedCtx.specs` and pairing each
  spec's barrel-alias name (from `constructorNameSet`-aware suffixing) with
  its per-component setter name.
- Compute `slotRewrites` by iterating `SharedCtx.slots` (all of them) and
  pairing each slot's `name` (kebab-case) with its `setterName` (camelCase,
  computed via `Naming.decapitalize` and any collision suffix from the
  Task 5 helpers).
- Read `requiredAttrs` from the config's new optional field (add decoding to
  `decodeConfigResult`).
- Preserve the module header comment (`GENERATED — per-component facts…`).
  Remove the PROVISIONAL block; the schema is stable now.

## 8. Cross-spec invariants respected

Per the [coordination doc](2026-07-03-epic-138-shipping-coordination.md), this
spec honors:

- **Every `requiredAttrs` fact the generator emits is a real per-component
  required attribute drawn from CEM + config.** ✓ Config-driven, per-component,
  no synthetic entries.
- **Every shorthand↔specific pair the generator emits comes from the same
  setter-name resolution the top-layer setters already use.** ✓ `attrRewrites`
  and `slotRewrites` are computed from the exact same `SharedCtx.specs` and
  `SharedCtx.slots` the emitters use to build the actual setters.
- **Per-component shape metadata reflects exactly what shapes actually take at
  that component.** ✓ `shapes : List Shape` is `shapesFor config libraryInfo
  component |> ...` — the same value the emitters use to decide which top
  modules to write.
- **The facts module cannot expose ⑤-specific fields in the first ship.** ✓
  `Shape` is `Shape3 | Shape4` only. Second-ship spec adds `Shape5` and any
  associated fields.

## 9. Migration story

The existing three rules that consume Facts (`ValidEnumValue`, `SingularSlot`,
`RequireSlot`) read only `component`, `enums`, `requiredSlots`, `multiSlots`.
These fields are unchanged. Zero migration for existing rule code.

The rule tests under `review/tests/` should compile without changes; they use
fixture Fact records constructed with today's fields, and the new fields are
additive.

New fields (`attrRewrites`, `slotRewrites`, `shapes`, `requiredAttrs`) are
consumed only by the rules that appear in the D1–D5 rules spec, which lands
alongside this Facts change.

Task 7's PROVISIONAL `shapes : List String` and `requiredAttrs : List String`
are structurally replaced. Consumers of Task 7's PROVISIONAL fields (there are
none in the repo — they were labelled provisional exactly to prevent
consumption) do not exist.

## 10. Definition of done

- `packages/m3e/src/M3e/Review/Facts.elm` exposes the new schema: `Fact`,
  `Shape(..)`, `facts`.
- `Fact` carries the 9 fields listed in §3.
- The PROVISIONAL header comment is removed.
- `config/slots.json` gains a `requiredAttrs` field on at least one component
  whose accessibility requires it (e.g., `IconButton`).
- `attrRewrites` and `slotRewrites` are exhaustive: for every attr/slot the
  top-layer component exposes, the list has an entry. Spot-check: Button's
  `attrRewrites` contains a pair for every attr `M3e.Button` exposes; the
  first element matches the barrel alias name; the second matches the
  per-component setter name.
- `packages/m3e/` compiles clean after regen.
- `elm-review --config review/` runs clean on the docs app (existing rules
  keep passing; no regressions from Facts schema change).
- The generator's ShapesForTest and any Facts-adjacent generator tests stay
  green.

## 11. Open sub-questions

Resolved during implementation review, not blocking approval:

- Whether `requiredAttrs` should include events (`onClick`) as well as pure
  attrs. Current answer: attrs only. If a component semantically requires
  an event handler (e.g., a Button with no `onClick` and no `href`), that's
  the existing `NoActionlessButton` rule's territory, which is hand-written
  and doesn't touch Facts.
- Whether to add a small helper (`M3e.Review.Facts.factFor : String -> Maybe Fact`
  or similar) to save every rule from writing the same `List.filter` on the
  facts list. Not blocking; can land as a small quality-of-life addition in
  the rules spec's implementation.
