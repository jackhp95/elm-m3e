# Plan — C: Tab/panel sliding

Spec: `docs/superpowers/specs/2026-07-07-c-tab-sliding.md`
Branch: `docs/c-tab-sliding` (off `main` @ `7e75e0f`).

## Files
- NEW `docs/src/Doc/Slider.elm` — the reusable `slidingPanels` helper (viewport+track+panels).
- NEW `docs/js/slide-panels.js` — height-sync custom element `<slide-panels>` (ResizeObserver).
- `docs/index.ts` — import/register `slide-panels.js` (mirror the `raw-html.js` import at index.ts:5-7).
- `docs/app/Route/Components/Name_.elm` — `exampleBlock`/`codeFor`: render ALL `layersFor ex` panels
  through `slidingPanels`; compute `activeIndex` = selected layer's position in `layersFor ex`.
- `docs/app/Route/Examples/Travel.elm` — apply `slidingPanels` to `categoryTabs` panels IF low-risk.
- `docs/style.css` — track transition + reduced-motion; viewport clip.

## Step 0 — Baseline
- `cd docs && npm run build:ci` → exit 0 at HEAD. Build+serve, screenshot a component page's API toggle
  (e.g. `/components/appbar`) switching M3e↔HTML so the "slides now, jumped before" claim has a before.

## Step 1 — `Doc/Slider.elm`
```
module Doc.Slider exposing (slidingPanels)
slidingPanels : Int -> List (Html msg) -> Html msg   -- (activeIndex, panels)
```
- Emit `node "slide-panels" [ attribute "active-index" (String.fromInt activeIndex), class "sp-viewport" ]
    [ div [ class "sp-track", style "transform" ("translateX(-" ++ String.fromInt (activeIndex * 100) ++ "%)") ]
        (List.indexedMap (\i p -> div [ classList [("sp-panel",True)], attribute "aria-hidden" (bool (i/=activeIndex)), inertWhen (i/=activeIndex) ] [ p ]) panels) ]`
  - `inert` has no stdlib Html helper — use `Html.Attributes.attribute "inert" ""` present only when
    inactive (build the attribute list conditionally; don't emit `inert=""` on the active one).
  - Keep the helper generic (no Layer knowledge) so Travel can reuse it.
- Guard: if `panels` is empty or length 1, render the single panel plainly (no track) — avoid a
  degenerate slider.

## Step 2 — `docs/js/slide-panels.js` (height-sync custom element)
- `class SlidePanels extends HTMLElement`:
  - `connectedCallback`: cache the track (`.sp-track`) and panels; create a `ResizeObserver` that, on
    active-panel resize, sets `this.style.height = activePanel.offsetHeight + "px"`. Observe the active
    panel. Set initial height (next frame, after children lay out — use `requestAnimationFrame`).
  - `static get observedAttributes() { return ["active-index"]; }` /
    `attributeChangedCallback`: re-point the ResizeObserver to the new active panel and update height.
  - `prefers-reduced-motion`: read `matchMedia("(prefers-reduced-motion: reduce)")`; when reduce, set
    height without relying on CSS transition (CSS handles the transform; JS sets height directly — the
    CSS media query zeroes the transition, so no extra JS branch strictly needed, but set height
    immediately either way).
  - Defensive: no-op if no panels; disconnect the observer in `disconnectedCallback`.
- Register: `customElements.define("slide-panels", SlidePanels)` (guard against double-define).
- Import in `docs/index.ts` beside the other `../js/*.js` side-effect imports.

## Step 3 — Wire the primary case (`Name_.elm`)
- In `exampleBlock` (~411), replace the single `codeFor layer ex` with:
  `Doc.Slider.slidingPanels activeIndex (List.map (\l -> codeFor l ex) (layersFor ex))`
  where `activeIndex = layersFor ex |> List.map Tuple.second? ` — NOTE `layersFor` returns
  `List (String, Layer)` (label,layer). Compute `activeIndex` = index of the selected `layer` within
  `layersFor ex` (the layers in order). If the selected layer isn't present (shouldn't happen — it comes
  from `defaultLayerFor`/click), clamp to 0.
  - `codeFor` currently takes `Layer -> UsageExample -> Element`. Reuse it per layer to render each panel.
  - The `<m3e-tabs>` strip (`layerTabs`) stays exactly as-is above the slider.
- Ensure the `Element {s|html}` vs `Html msg` seam is respected — `codeFor` returns whatever `Doc.code_`
  returns (an `Element`); `slidingPanels` must accept those. Match the existing types (the helper may need
  to be `List (Element r msg) -> Element r msg` using the project's `Seam`/`Layout` wrappers rather than
  bare `Html`). READ how `exampleBlock` composes `Element`s and mirror it; use `Seam.fromHtml`/`Layout.div`
  as the codebase does (Doc.elm uses `Seam.fromHtml`). Keep types honest; run `elm make` early.

## Step 4 — CSS (`docs/style.css`)
- `.sp-viewport { display:block; overflow:hidden; transition: height .3s ease; }` (height animated here;
  JS sets the px value). `.sp-track { display:flex; transition: transform .3s ease; will-change: transform; }`
  `.sp-panel { flex:0 0 100%; min-width:0; }` (min-width:0 so the inner `.overflow-x-auto` scrolls).
- `@media (prefers-reduced-motion: reduce) { .sp-viewport, .sp-track { transition: none; } }`.
- Ensure the panel's existing `.overflow-x-auto` code box still scrolls horizontally inside `flex:0 0 100%`.
- No `display:none` anywhere on panels.

## Step 5 — Travel `categoryTabs` (secondary; apply or defer)
- Inspect `Travel.elm` `categoryTabs`/the category panels. If the category content is a set of panels
  selected by `SetCategory`, wrap them in `slidingPanels` with the active category index. If the shape
  doesn't map cleanly (e.g. it's a filtered grid, not discrete panels), DEFER with a one-line note in the
  report + spec. Do not force it.

## Step 6 — Verify (the bar)
- `elm-format --yes` the new/edited `.elm`, then `elm-format --validate app src` → `[]`.
- `cd docs && npm run build:ci` → exit 0 (`check-nav: OK`, `Success - Adapter script complete`).
- **Playwright (build dist, serve :1239, ~1600ms upgrade), desktop + mobile:**
  - On `/components/appbar` (and one more, e.g. `/components/list`): read the `.sp-track` `transform`
    before/after clicking a different tab → translateX index changes; assert `transition-property`
    includes `transform` (slide is animated). Optionally sample transform mid-animation to prove motion.
  - Height follows active: measure `.sp-viewport` height on M3e vs HTML tab → differs and ≈ the active
    panel's content height (no giant empty space on the short one; no clip on the tall one).
  - Selected tab shows the correct code (compare a token unique to HTML surface appears only when HTML is
    active in the visible panel).
  - B2 folds still work inside the active panel; find-in-page property intact (token in closed fold, no
    display:none ancestor).
  - Reduced-motion: new context with `reducedMotion: "reduce"` → `.sp-track` computed
    `transition-duration` is `0s`/none; switching tabs still changes content.
  - Perf smell: page loads and tab-switch feels instant (note counts; not a hard metric).
  - Screenshots to scratchpad. Kill server after.

## Step 7 — Do NOT commit; leave dirty for review.

## Deliverable for review
1. Diffs: `Doc/Slider.elm` (new), `slide-panels.js` (new), `index.ts`, `Name_.elm`, `style.css`, Travel
   (or a note deferring it).
2. Confirmation all panels mount and the active index maps correctly (how `activeIndex` is computed).
3. Playwright transcript + screenshots proving criteria 1–8 at desktop + mobile (slide animates, height
   follows, reduced-motion disables, correct code per tab, folds+find-in-page intact).
4. `build:ci` exit 0 + `elm-format --validate` `[]`.
5. Whether Travel `categoryTabs` was wired or deferred, with reason.
6. Note on DOM-cost/perf (criterion 8) and any height-sync jank (R1) with how it was resolved.
