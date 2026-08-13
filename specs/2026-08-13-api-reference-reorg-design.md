# Spec — API reference section: 4-layer tabs + shared Types block

Date: 2026-08-13
Repo: `elm-m3e`
Status: approved design, not yet planned
Related: `docs/app/Route/Components/Name_.elm`, `docs/scripts/extract-reference.mjs`,
`docs/src/Doc/Usage.elm` (tab widget + Surface concept reused)

## Problem

Each component doc page's "API" section (`Route/Components/Name_.elm:216-260`)
documents exactly one module — `M3e.Component.X` — grouped into
Constructor/Attributes/Slots/Events/Other buckets (`apiGroups`, lines 234-241), with
type aliases folded into the Constructor bucket. `extract-reference.mjs` only ever
extracts `M3e.Component.*` members (confirmed: no code path reads `M3e.elm` the
barrel, `M3e.Build.*`, or the underlying custom element's own attributes). A visitor
working in the `Build` layer, or wanting the raw HTML contract, has no reference page
for it today — only the Usage section's live examples happen to show snippets in
those forms, with no structured member list.

## Non-goals

- No change to how Usage examples work (covered by the separate
  `2026-08-13-usage-tab-sync-design.md` spec) beyond sharing the tab-selection widget
  where practical.
- No new documentation route/page — this stays inside the existing component page's
  API section.
- No literal-Elm-return-type grouping (confirmed: current semantic buckets — attr /
  slot / event / other — are kept as-is; only the layer tabbing and the Types
  extraction are new).

## Design

### Four tabs, one per real layer

The API section gains the same 4-surface concept `Doc.Usage.Surface` already models
(`Top | Record | Build | Raw`), labeled for this context as `M3e | Components |
Builder | Raw`. Reuse `Doc.Usage`'s tab-rendering widget (`surfaceTabs`) rather than
building a second one — factor the widget itself out to a shared spot both `Doc.Usage`
and `Route/Components/Name_.elm` can import, if it isn't already import-safe as-is.
Selecting a tab here uses the SAME shared/persisted `activeSurface` state introduced
by the tab-sync spec — an API-section tab click updates the same page-wide (and
site-wide-persisted) surface as a Usage-example tab click, and vice versa. This is
the direct realization of "changing to an API tab changes ALL tabs."

### Extraction gains 3 more sources per component

`extract-reference.mjs` currently walks only `src/M3e/Component/<Name>.elm`. It needs
three more member sources, keyed to the same component:

- **`M3e` tab** — the barrel's per-component slice of `src/M3e.elm` (the handful of
  top-level functions/re-exports for that component, e.g. `M3e.button`,
  `M3e.variant`, etc. re-exported or thinly wrapping the Component layer).
- **`Builder` tab** — `src/M3e/Build/<Name>.elm`'s members (the builder-pipe API:
  `build`, `toElement`, and its pipe-stage setters).
- **`Raw` tab** — the underlying `<m3e-*>` custom element's own attribute/property/
  event contract, sourced from `@m3e/web`'s custom-elements-manifest (exact vendored
  path TBD at implementation time — no existing code path in this repo reads the CEM
  manifest today, this is new plumbing, not a rename of something existing).

Each tab's member list keeps the existing `roleOf` classification
(`extract-reference.mjs:300-313`) and existing `apiGroups` semantic buckets
(Attributes/Slots/Events/Other) — those classifiers were written against
`M3e.Component.*` signatures; the `M3e` and `Builder` layers will need the same
classifier applied to their own (structurally similar) signatures, and the `Raw`
layer's CEM-sourced attributes get a simpler mapping (CEM attribute → `attr`, CEM
event → `event`, CEM slot → `slot`) since there's no Elm signature to pattern-match.

### Types pulled out, shared across tabs

Type aliases currently folded into the "Constructor" bucket (`Is`, `Attrs`,
`Content`, `IconSlot`, `SelectedSlot`, ..., `Shape`, `Size`, `Type`, `Variant`, ...)
move to a new **always-visible section** rendered above the 4 tabs, not inside any of
them — because the same types are shared across the `M3e` and `Components` layers (the
barrel re-exports the Component layer's type aliases verbatim; they aren't
layer-specific). The Constructor bucket keeps only the ctor function itself
(`button`/`required` per the naming-convention spec) once types move out.

`Raw`-layer "types" (if the CEM manifest expresses attribute value enums) can either
feed the same shared Types block (if they line up 1:1 with the Elm `Value`-typed
aliases) or get their own small subsection within the Raw tab — implementation-time
call once the CEM manifest's actual shape is inspected.

### Page layout, top to bottom

1. Title, summary, install snippet (unchanged).
2. **Types** section (new, shared, un-tabbed).
3. Tab strip: `M3e | Components | Builder | Raw`.
4. Selected tab's semantic-bucket groups (Constructor/Attributes/Slots/Events/Other,
   minus Constructor's former type aliases).
5. Usage section (unchanged, below API — existing page order).

## Testing

- Spot-check 3-4 components spanning different shapes (a component with slots, one
  with events, one with no Builder module if any exist, one simple attrs-only
  component) render all 4 tabs with correct, non-empty member lists where expected.
- Confirm clicking a tab in the API section moves Usage examples' tabs on the same
  page to match, and the reverse.
- Confirm the Types block shows once per page (not duplicated per tab) and contains
  exactly the type aliases that used to live in the Constructor bucket.
