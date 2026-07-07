# Docs Quick Fixes — Design (Stream A)

**Date:** 2026-07-07
**Status:** Approved (design), pending implementation plan
**Scope:** The two broken-page bugs on the elm-m3e docs site. First of four streams
(A quick fixes → B example sourcing + folding → C tab/panel sliding → D app shell).

## Problem

Two visible defects on <https://elm-m3e.netlify.app>:

1. **Dead nav links / 404s.** `/components/search` (and ~9 more) hard-404. The drawer's
   component list is hand-curated and its slugs have drifted from the real page slugs.
2. **Tiny examples.** On `/components/progress` (and any full-width component) every
   example past the first renders collapsed to a sliver.

## Root causes (verified)

**Bug 1 — stale `componentList`.** `docs/app/Shared.elm:809` hand-maintains
`componentList : List (slug, label, category)`. Pages are pre-rendered from
`docs/data/reference.json` slugs (128 of them) via the `/components/:name` route.
The curated list's slugs no longer match, so links point at non-existent pages.
The curation itself is correct and worth keeping — `reference.json` includes internals
(`actionelementbase`, `breadcrumbitembutton`, `pseudocheckbox`, …) that must **not**
appear in nav. The fix is slug correctness, not replacing the curation.

Confirmed broken slugs: `search, navigationbar, navigationdrawer, navigationrail,
radiobutton, textfield, disclosure` (wrong slug) and `extendedfab, sidesheet, timepicker`
(no page exists at all).

**Bug 2 — forced flex in the live preview.** `docs/src/Doc.elm:64` wraps every preview
in `class "flex max-w-full flex-wrap items-center gap-3 py-2"`. In a flex **row**, each
child is sized to its content on the main axis. Components with no intrinsic width —
linear progress, sliders, dividers, text fields — collapse to min-content. Matraic's
`.showcase` (matraic `docs/main.css:128`) sets **no** flex; layout comes from each
component's own `display` (buttons are inline-flow and wrap; linear progress is block
and fills width). Our flex override is the sole cause.

## Design

### 1. Fix + future-proof the nav (`Shared.elm`)

Apply this remap (each target verified to exist in `reference.json` **and** to carry
examples in `examples.json`):

| Current (404) | → Target slug | Label            |
|---------------|---------------|------------------|
| `search`      | `searchbar`   | Search           |
| `navigationbar` | `navbar`    | Navigation Bar   |
| `navigationdrawer` | `drawercontainer` | Navigation Drawer |
| `navigationrail` | `navrail`  | Navigation Rail  |
| `radiobutton` | `radiogroup`  | Radio Button     |
| `textfield`   | `formfield`   | Text Field       |
| `disclosure`  | `expansionpanel` | Expansion Panel |

**Drop** (no page and no examples): `extendedfab` (a FAB variant, covered by `fab`),
`sidesheet`, `timepicker`.

**Add** (example-bearing pages currently absent from nav): `autocomplete`,
`contentpane` (Content Pane), `textareaautosize` (Textarea Autosize), `tree` (Tree) —
plus `expansionpanel` enters via the `disclosure` remap. Assign each a category
consistent with `componentCategories`.

### 2. Drift guard (new, bidirectional)

Add a check that runs in CI (and locally) so the list can never silently drift again:

- **Hard fail:** every `componentList` slug MUST exist in `reference.json`. A bad slug
  breaks the build instead of shipping a 404.
- **Warn:** every key in `examples.json` that is *not* in `componentList` is reported,
  so example-bearing pages missing from nav surface as a warning (a conscious
  include/exclude decision, not a silent gap).

Placement: prefer a small Node script under `docs/scripts/` invoked in `build:assets`
(the guard needs `reference.json` + `examples.json`, both JSON, so a JS check is
simplest and fails the build early). Reuse the existing slug-reading approach from
`build-examples-data.mjs`. If an elm-test seam is more natural to the repo's habits,
that is an acceptable alternative — decide during planning.

### 3. Preview layout parity (`Doc.elm:rawPreview`)

Replace the flex row with a plain block container so components use their own `display`
— matraic parity. Remove `flex flex-wrap items-center gap-3`; keep `max-w-full` and the
`py-2` breathing room. **Do not** introduce `overflow` (the existing comment documents
why: `overflow-x-auto` forces `overflow-y: auto` and the ~4px state-layer bleed then
trips a spurious scrollbar).

Implementation note: inline components (buttons/chips) will flow with default inline
whitespace rather than a fixed `gap`. If that reads too tight next to matraic, add
spacing via a child-targeting arbitrary variant on the wrapper (e.g. `[&>*]:m-1`) —
this preserves wrapping and full-width block children, unlike a flex row. Not required
for parity; a follow-up polish only if visually needed.

## Non-goals

- Example **content** (sourcing from `.showcase`, folding) — that is Stream B.
- Any redesign of the tab strip or app shell — Streams C and D.
- Creating new pages for the dropped components — out of scope; revisit if the
  underlying components gain docs.

## Verification

- Every drawer link resolves (no 404) — spot-check the 7 remapped + 4 added.
- The drift guard fails when fed a deliberately bad slug, passes on the fixed list.
- `/components/progress`: linear progress examples render full-width; circular
  indicators unchanged. Button/chip galleries on other pages still wrap in a row.
- `pnpm run build:ci` (or the repo's docs build) stays green; `elm-format` clean.
