# Spec D — Favicon from the real Material `palette` glyph

Date: 2026-08-05
Repo: `elm-m3e`
Status: approved design, not yet planned
Depends on: Spec C (`specs/2026-08-05-icon-registry-seam-design.md`) for the icon pipeline

## Problem

`docs/public/favicon.svg` claims to be the Material palette glyph:

```html
<!-- Material "palette" glyph, white, centered -->
<g transform="translate(11 11) scale(1.08)">
  <path fill="#FFFFFF" d="M12 3c-4.97 0-9 4.03-9 9s4.03 9 9 9c.83 0…"/>
</g>
```

It is a hand-copied path on a `0 0 24 24` grid — the legacy *Material Icons* palette, not
the *Material Symbols* glyph the app bar actually renders. The app bar uses
`M3e.Icon.name "palette"` (`docs/app/Shared.elm:396`), which resolves through Material
Symbols. So the tab icon and the in-app icon are two different drawings of the same idea,
and neither is derived from a source that can be re-checked.

## Design

Generate the glyph from `material-symbols:palette` through Spec C's pipeline rather than
hand-copying it. Add the id to `config/icons.json`, and have the icons build step emit
`docs/public/favicon.svg` as a second output alongside the `registerIcon` module — one
source of truth for "the palette glyph", consumed both by the app bar and by the tab icon.

Keep the existing brand plate: the 46×46 rounded rect with the `#8A6FE0 → #5B3F9E`
gradient, `viewBox="0 0 48 48"`, `role="img"`, `aria-label="elm-m3e"`. Only the glyph path
and its transform change.

### The transform must be recomputed, not reused

Material Symbols paths live on a **`0 -960 960 960`** viewBox — origin at the *baseline*,
with negative Y. The current `translate(11 11) scale(1.08)` assumes a `0 0 24 24` path.
Reusing it would place the glyph off-canvas entirely.

For a 960-unit glyph centred in a 48-unit plate at 26 units of glyph box:

- `scale = 26 / 960 = 0.0270833…`
- after scaling, the glyph spans `x ∈ [0, 26]` and `y ∈ [-26, 0]`
- to place it at `[11, 37]` on both axes: `translate(11 37)`, since `11 + 26 = 37`

so the wrapper is `transform="translate(11 37) scale(0.0270833)"`. SVG applies the rightmost
transform first, so a point `(x, y)` maps to `(0.0270833x + 11, 0.0270833y + 37)`, sending
`y ∈ [-960, 0]` to `[11, 37]`.

The generator must compute this from the icon's **declared viewBox** rather than hard-code
it, so an icon on a different grid still lands correctly. Verify visually at 16px — a wrong
transform still produces valid SVG.

## Second finding: `favicon.ico` is the Open Graph image

Unrelated to the glyph, and found while checking whether the `.ico` was still referenced:
**14 route modules** in `docs/app/` pass `favicon.ico` as their social-card `image`, e.g.

```elm
image = { url = [ "favicon.ico" ] |> UrlPath.join |> Pages.Url.fromPath, alt = "elm-m3e", … }
```

That file is a **32×32 PNG** (despite the `.ico` extension) and 450 bytes. As an Open Graph
image this fails in two ways: it is far below the ~1200×630 that scrapers expect, and most
scrapers will not render an `.ico` at all. Every shared link across the docs site therefore
has a broken or blank card.

This is a real bug but it is **not** the favicon change, and fixing it properly means
producing a genuine social card — which is a design question (what does the card look like?)
rather than a codegen one. It is recorded here so it is not lost, and should become its own
spec. Do **not** delete `favicon.ico` as part of this change; 14 modules still point at it,
and a broken card is better than a 404.

Scope of this spec is `favicon.svg` only. `Site.elm:30` already registers only
`favicon.svg`, so no head-tag change is needed.

## Verification

- `docs/public/favicon.svg` is generated, not hand-edited; drift check green.
- The generated path is byte-identical to `material-symbols:palette`'s path data, asserted
  in the generator test.
- Rendered at 16×16 and 32×32 the glyph is centred within the plate with no clipping and no
  off-canvas placement — checked as an image, since a wrong transform still produces valid
  SVG.
- Tab icon and app-bar icon are visibly the same drawing.
- `npm run build:site` green; `favicon.svg` present in `docs/dist`.
