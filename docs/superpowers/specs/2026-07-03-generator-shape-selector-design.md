# Generator — shape selector + uniform ③ + pruned-empty ④ (epic #138 first ship)

Date: 2026-07-03
Status: Proposed — blocking gate is user review before implementation.
Ship: first — coordinated with facts and rules per the
[shipping coordination doc](2026-07-03-epic-138-shipping-coordination.md).
Governing ADR: [0013 (amended)](../../adr/0013-top-shape-matrix-and-translation.md).

## 0. Post-implementation correction (2026-07-04)

The spec text below repeatedly names "four required-bearing components (Button, IconButton, Fab, Chip today)". The actual `hasRecord` gate matches **21** components in the current `config/slots.json` — the four named plus 17 more: Option, RichTooltipAction, RichTooltip, Tooltip, AssistChip, FilterChip, InputChip, SuggestionChip, Heading, NavMenuItem, SearchBar, SearchView, Snackbar, SplitButton, Step, TocItem, TreeItem. Every "four" reads as "21". The emission rule is the same either way; only the documented count was off. The DoD in §11 verifies against the real emitted set, not a hard-coded list.

## 1. Purpose

Replace the implicit `hasRecord` fork at `Generate.elm:1973` with an explicit
shape selector, and uniformly emit shape ③ (`M3e.<Comp>`) and shape ④
(`M3e.Record.<Comp>`) across all components. ④ is pruned where the required
record would be empty. This is the generator half of the first ship; the
facts and rules pieces coordinate via the invariants in the coordination doc.

Three top shapes are **siblings**, not layered — each wraps the middle layer
directly and imports no other top shape. ⑤ in the second ship follows the
same pattern.

## 2. Scope

**In.**
- Emit shape ③ for every component. For required-bearing components, ③
  re-exposes the middle layer's simple action attributes (`onClick`, `href`,
  `target`, `rel`, `download`) as top-level attribute setters, and provides
  `child` / `children` for the default slot.
- Emit shape ④ for every component whose required record has ≥1 field
  (Button, IconButton, Fab, Chip today). Signature and body identical to
  today's shipped hybrid.
- Migrate today's `M3e.<Comp>.view` for the four required-bearing components
  from ④-style to ③-style (breaking change). Add new `M3e.Record.<Comp>.elm`
  files carrying today's hybrid signatures.
- Update the `M3e.elm` barrel: lowercase re-exports point at ③.
- Extract `generateTopModule` into per-shape emitters `generateShape3Module`
  and `generateShape4Module`, sharing the existing helpers.
- Emit per-component shape / arity metadata in a form the facts module
  (separate spec) consumes verbatim.
- Document the migration: elm-lsp-rust rename invocations for the four
  required-bearing components' call sites.

**Out.**
- Shape ⑤ (deferred to second ship).
- Facts-module implementation beyond the shape-metadata handoff (separate
  first-ship spec).
- Review rules (separate first-ship spec).
- Translator (third ship).
- Docs-app 2-D shape toggle (deferred).

## 3. What gets emitted per component

For an **optional-only** component (Card, ListItem, ~123 others):

- `M3e.<Comp>` — shape ③, single file. Same signature as today.
- `M3e.Cem.<Comp>` — shape ②, unchanged.
- `M3e.Cem.Html.<Comp>` — shape ①, unchanged.

For a **required-bearing** component (Button, IconButton, Fab, Chip):

- `M3e.<Comp>` — shape ③, **new file**. Signature
  `view : List Attr -> List Content -> Element`. Re-exposes the middle
  layer's action attrs at the top level; exposes `child` / `children` for
  the default slot. Missing-required is caught by the review rules in the
  parallel rules spec, not by the compiler.
- `M3e.Record.<Comp>` — shape ④, **new file**. Signature
  `view : {required} -> List Attr -> List Content -> Element`, identical to
  today's shipped `M3e.<Comp>.view`.
- `M3e.Cem.<Comp>` — unchanged.
- `M3e.Cem.Html.<Comp>` — unchanged.

The middle and bottom layers are untouched.

## 4. `shapesFor` — the shape selector

```elm
type Shape
    = Shape3
    | Shape4

shapesFor : Config -> Cem.Declaration -> Set Shape
```

Rule:
- `Shape3` is always in the set.
- `Shape4` is in the set iff the component has ≥1 field in its required
  record — the current `hasRecord` predicate at `Generate.elm:1973`.

The set-valued form replaces the boolean `hasRecord`. In the second ship the
type gains `Shape5` and `shapesFor` gets a case for it; nothing structural
changes.

## 5. Action attributes on shape ③ for required-bearing components

Shape ③ re-exposes the **simple** action attrs (`onClick`, `href`, `target`,
`rel`, `download`) as aliases of the middle-layer setters, via the existing
`setter` helper at `Generate.elm:1720`. These are already exposed on the
middle layer; the generator just needs to include them in ③'s setter list
for required-bearing components (today ④'s emission suppresses them via
`suppressedAttrs` at L1703 because they go into the record).

Shape ③ does **not** re-expose the complex triggers (menu, dialog, fab-menu,
etc.). Those live in `M3e.Action` and inherently wrap the label in an outer
element; expressing them as a simple attribute is not possible. Users needing
menu-trigger, dialog-trigger, etc. use shape ④ or compose the trigger
element manually. This aligns with the top-shape gradient spec §4's action
asymmetry paragraph.

Default-slot content: ③ exposes `child` and `children` matching Card's
existing convention (see `packages/m3e/src/M3e/Card.elm:196-241`). For
Button ③, the label is placed via `M3e.Button.child (Kit.text "New")` and
enters the default slot as a `Content { r | default : Supported } msg`.

## 6. Generator code structure

`generateTopModule` (~440 lines at `Generate.elm:1622-2064`) splits into two
sibling emitters plus shared helpers:

```elm
generateTopModules : Config -> LibraryInfo -> Cem.Declaration -> List TopModule
generateTopModules config libraryInfo decl =
    let
        shared =
            { specs = ...
            , contentSlots = ...
            , requiredType = ...
            , build = ...
            , attrsWith = ...
            , reqStampedNodes = ...
            , smartAppend = ...
            }
    in
    shapesFor config decl
        |> Set.toList
        |> List.map (\shape ->
            case shape of
                Shape3 -> generateShape3Module config libraryInfo decl shared
                Shape4 -> generateShape4Module config libraryInfo decl shared
        )
```

`generateShape4Module` is essentially the current `hasRecord` branch of
`generateTopModule` extracted verbatim, with the module name changed to
`M3e.Record.<Comp>`. It retains the `Elm.Arg.var` workaround at
`Generate.elm:2002-2009` (the multi-field required record args must stay
unannotated to avoid the elm-codegen inference-loop bug).

`generateShape3Module` is the current non-`hasRecord` branch, extended with
action-attr re-exposure and `child` / `children` emission for
required-bearing components.

Shared helpers (`specs` at L1710, `contentSlots` at L1684, `requiredType` at
L1785, the body-assembly helpers `build` / `attrsWith` / `reqStampedNodes` /
`smartAppend` at L1858+) stay factored out and are consumed by both
emitters. The orchestrator (`generateFromManifest` at ~L440) updates to
consume `List TopModule` per component instead of one.

## 7. Barrel handling

Each top-layer namespace gets its own barrel with lowercase re-exports of
the components emitted into it. Symmetric across shapes, predictable for
users.

`M3e.elm` — updated. Same file that exists today, still re-exporting
lowercase `<comp> = M3e.<Comp>.view`. After the ship the entries for
required-bearing components point at ③ (was ④):
- `M3e.button = M3e.Button.view` — now ③'s view (was ④'s hybrid).
- `M3e.card = M3e.Card.view` — unchanged; Card is optional-only, so ③ was
  always what shipped through the barrel.

`M3e/Record.elm` — new. A barrel for the ④ namespace, emitted alongside
the per-component ④ modules. Re-exports lowercase for each
required-bearing component:
- `M3e.Record.button = M3e.Record.Button.view`
- `M3e.Record.iconButton = M3e.Record.IconButton.view`
- `M3e.Record.fab = M3e.Record.Fab.view`
- `M3e.Record.chip = M3e.Record.Chip.view`

Only components in ④'s emission set (`Shape4 ∈ shapesFor decl`) get
entries. Optional-only components have no ④ file, so no barrel entry.

`M3e/Build.elm` — deferred to the second ship. When ⑤ lands it emits a
sibling barrel: `M3e.Build.button = M3e.Build.Button.button`, etc.

Barrel emission in the generator: a single pass at the top of
`generateFromManifest` (~L440) groups components by which shapes they emit,
then produces one barrel per namespace with the corresponding lowercase
entries. Existing `M3e.elm` barrel emission at `Generate.elm:2268` is
generalized from "one barrel, all components" to "one barrel per
namespace, filtered by `shapesFor`."

The middle layer stays barrel-less as today (no `M3e.Cem.elm`). Sub-namespace
barrels are a top-layer decision, not a general library convention.

## 8. Shape / arity metadata for facts

The generator emits per-component metadata the facts module consumes:

- Which shapes exist per component (`Set Shape`).
- Arity per shape (③ is 2 args, ④ is 3 args; ⑤ is added in the second
  ship's schema).
- Attr-vs-slot classification of every parameter position (drives the
  wrong-arity rule and the translator).

The threading is via the generator's existing `viewTypeByNoun` map (L469),
extended from `Dict String ViewType` to a richer `Dict String
PerComponentShapes` structure. The exact schema is settled by the facts
spec; the invariant is that whatever the generator emits, the facts module
consumes verbatim — no schema divergence.

## 9. Migration plan

Four required-bearing components have breaking API changes:

- `M3e.Button.view` — was ④ hybrid, becomes ③.
- `M3e.IconButton.view`, `M3e.Fab.view`, `M3e.Chip.view` — same.
- Barrel entries `M3e.button`, `M3e.iconButton`, `M3e.fab`, `M3e.chip` — same
  as their respective `M3e.<Comp>.view` above.

Post-regen migration steps, executed once:

1. Regenerate `packages/m3e/src/` from the updated generator.
2. Compile the docs app + any hand-written callers. Every call to
   `M3e.<Comp>.view {content, action} [attrs] [content]` for the four
   components errors with "expected 2 args, got 3."
3. For each call site: rewrite `M3e.<Comp>.view` → `M3e.Record.<Comp>.view`
   (module rename only; args stay identical). Automate via
   `mcp__plugin_elm-lsp-rust_elr__elm_rename_function` — call sites are
   bounded (docs app + any examples).
4. For barrel calls: rewrite `M3e.button {content, action}` →
   `M3e.Record.button {content, action}` (the new `M3e.Record.elm` barrel
   surfaces the ④ shortcut). Automate via elm-lsp-rust as above.
5. `elm-format` the touched files.
6. Verify `pnpm run check` passes (the docs-consumer gate; see #128).

## 10. Cross-spec invariants respected

Per the [coordination doc](2026-07-03-epic-138-shipping-coordination.md),
this spec's design honors:

- Shape / arity metadata schema — the generator emits, the facts module
  consumes verbatim. Any schema change must land in both specs.
- `requiredAttrs` field — the generator emits per-component from CEM +
  config, matching what the missing-required-attribute rule needs.
- Shorthand ↔ specific pairs — no new emission here; the pairs come from
  the existing setter-name resolution and the facts spec captures them.
- No ⑤-specific fields emitted in the first ship.

## 11. Definition of done

- `Generate.elm` refactored to use `shapesFor` selector + per-shape
  emitters.
- Every component has an `M3e.<Comp>.elm` (③). The four required-bearing
  components have re-exposed action-attrs (`onClick`, `href`, `target`,
  `rel`, `download`) and a `child` / `children` slot pair for the default
  slot.
- Every required-bearing component has a new `M3e.Record.<Comp>.elm` (④)
  carrying today's hybrid signature and body.
- `M3e.elm` barrel lowercase entries updated to point at ③.
- `M3e/Record.elm` barrel emitted with lowercase entries for the four
  required-bearing components (`button`, `iconButton`, `fab`, `chip`).
- Migration executed in the docs app + any repo callers; `pnpm run check`
  passes.
- Shape / arity metadata emitted matches the facts spec's consumed schema.
- Spot-check: Card's regenerated ③ is byte-identical to today's shipped
  `M3e.Card`; Button's regenerated ④ is byte-identical to today's shipped
  `M3e.Button` at the signature level (module rename aside).

## 12. Open sub-questions (design-doc detail)

Resolved during implementation review, not blocking user approval:

- Exact naming for the shape-metadata field name in the facts module — the
  facts spec settles it; this spec adjusts if the name changes.
- Whether ⑤ pruning for zero-optional-singular components is a config
  option or hard-coded — the ⑤ spec settles it in the second ship.
- Final docstring wording for the two shape modules — the placeholder text
  in §5 is close; refine during implementation review.
