# Spec — Usage examples: shared, persisted layer-tab selection

Date: 2026-08-13
Repo: `elm-m3e`
Status: approved design, not yet planned
Related: `docs/src/Doc/Usage.elm`

## Problem

Each Usage example on a component doc page (`Top`/`Record`/`Build`/`Raw` layer tabs,
rendered by `surfaceTabs`, `Doc/Usage.elm:258-270`) tracks its own selected surface
independently: `Model = { surfaces : Dict Int Surface }` keyed by the example's index
(`Doc/Usage.elm:55-56`). Switching one example's tab to e.g. `Build` does not affect
any other example on the page — visually inconsistent when a visitor wants to read a
whole page in one layer.

## Non-goals

- No change to `surfacesFor` (which tabs are *offered* per example, `Doc/Usage.elm:210-239`)
  — an example that doesn't have a `Top` form still won't offer a `Top` tab, even
  when `Top` is the page-wide selection.
- No per-example override affordance — once this ships, there is no way to pin one
  example to a different layer than the rest of the page.

### Fallback rule (resolved — was ambiguous in an earlier draft of this spec)

When the page-wide `activeSurface` isn't in a given example's `surfacesFor` list, that
example falls back to **its own existing per-example default** — i.e. exactly what
`defaultSurfaceFor` (`Doc/Usage.elm:248`, `surfacesFor ex |> List.head |> ...`)
computes today. This is a per-example, static fallback (first surface that example
itself offers), not a "closest surface to the global pick" ranking — there is no
ordering-distance concept to define, which is what made the earlier wording
ambiguous. Concretely: an example with only `Record`/`Raw` offered, on a page where
`activeSurface == Build`, shows `Record` (its own first-offered), not `Raw` or
anything computed relative to `Build`.

## Design

### State

Replace `Dict Int Surface` with one page-wide field, `activeSurface : Surface`,
defaulting to `Top`. Every `surfaceTabs` call site reads this single field instead of
`Dict.get index model.surfaces`. `SelectSurface` drops its `index` argument — it just
sets `activeSurface` and re-renders every example's tabs on the page.

### Persistence

New port pair in a new small module (or an addition to `Doc/Usage.elm` if the port
count stays low), following `Theme.Ports`' existing pattern
(`docs/app/Theme/Ports.elm`): `storeSurface : Encode.Value -> Cmd msg` /
`readSurface : (Decode.Value -> msg) -> Sub msg`, writing a single string under its
own localStorage key (kept separate from the theme blob — this is a docs-navigation
preference, not a visual theme setting, and coupling the two blobs would force every
theme-state consumer to also decode a field it doesn't own). Site-wide, not
page-scoped: navigating to a different component page keeps the same selected layer.

### Boot sequence

Same shape as `Theme.elm`'s `ThemeStateLoaded`: on boot, read the persisted surface if
present; fall back to `Top` on absence or decode failure.

## Testing

- Manual: on a component page with 2+ Usage examples, click a non-default tab on one
  example, confirm every other example's tabs update to match.
- Manual: reload the page, confirm the previously-selected layer persists.
- Manual: navigate to a different component page, confirm the layer selection
  carries over.
- Manual: on an example that doesn't offer the current `activeSurface`, confirm it
  falls back to its own first-offered surface per the rule above.
- Regression: `docs/tests-browser/usage.spec.ts` exercises today's per-example,
  index-keyed `SelectSurface` behavior — its selectors/assertions need updating for
  the page-wide model. Required plan work, not optional cleanup (same caveat the
  theme-drawer spec calls out for `settings-sheet.spec.ts`).
