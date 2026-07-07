# Spec — C: Tab/panel sliding

**Date:** 2026-07-07
**Branch:** `docs/c-tab-sliding`
**Product intent (DECIDED — do not relitigate):** Material tabs should *slide* — clicking a tab slides
the prior panel out and the new one in, instead of instantly swapping DOM. Applies to **all tab UI in
the docs**; build a **reusable sliding-panel helper** and use it everywhere tabs appear.

## Current state (from investigation)

- The API-surface toggle is **stateful Elm** in `docs/app/Route/Components/Name_.elm`:
  `Model = { layers : Dict Int Layer }`, `Msg = SelectLayer Int Layer`, `update` inserts into the Dict,
  `route` uses `RouteBuilder.preRender |> buildWithLocalState`. So slide state is derivable from Elm.
- `exampleBlock` (~line 411) renders per example: title, live preview (`Doc.rawPreview` — untouched),
  the `<m3e-tabs>` strip (`layerTabs`), and **one** code panel (`codeFor layer ex` — only the selected
  surface is mounted).
- `codeFor` returns a `Doc.code_` (a `.overflow-x-auto` box → B2 fold tree). **No height management**;
  height is content-driven and now dynamic (folds open/close).
- Other tab UI: `docs/app/Route/Examples/Travel.elm` `categoryTabs` (~334) is a genuine second tab strip
  (`M3e.Tabs`, stateful `SetCategory`). Shared.elm `segmented` controls (scheme/contrast/density) are
  theme toggles, **not** panel tabs — out of scope. Travel nav rail/bar are navigation, not tab panels.
- Interop pattern: custom elements in `docs/js/*.js` imported by `docs/index.ts` (e.g. `raw-html.js`);
  one port (`storeScheme`). No View Transitions in use.
- CSS seam: `docs/style.css` (`@layer components`); `prefers-reduced-motion` already referenced (B2).
  Elm CANNOT set CSS custom properties (`--var`) but CAN set ordinary inline styles (`style "transform"`).

## Mechanism (design decision — mine to make; product is settled)

**A `translateX` track driven by Elm inline `transform`, with a small height-sync custom element.**

1. **Reusable helper** — a single Elm function (new small module `docs/src/Doc/Slider.elm`, or a helper
   beside `Doc.elm`) e.g.:
   ```
   slidingPanels :
       { activeIndex : Int }        -- 0-based position of the selected panel within `panels`
       -> List (Html msg)           -- ALL panels, in order (already rendered)
       -> Html msg
   ```
   It emits: a **viewport** (the height-sync custom element, `overflow-x/y` clipped) → a **track**
   (`display:flex`, each panel wrapped `flex:0 0 100%`, min-width 0 so inner `overflow-x-auto` still
   scrolls) with an Elm inline `style "transform" ("translateX(-" ++ toString (activeIndex*100) ++ "%)")`
   → the N panels. A CSS class carries the `transition: transform …` (gated by reduced-motion).
   Direction is automatic from the index delta — no explicit forward/back detection needed.

2. **Height-sync custom element** `docs/js/slide-panels.js` (~40 lines, no deps, mirrors `raw-html.js`
   registration in `index.ts`): observes the **active** panel (by an `active-index` attribute Elm sets)
   with a `ResizeObserver`, and sets the viewport's height to that panel's height with a CSS transition
   — so the container height follows the active surface (and follows fold open/close) with **no jump**
   and **no empty space** on short panels. On `active-index` change it re-targets the observed panel.
   Honors `prefers-reduced-motion` (sets height without transition when reduce). Feature-degradation:
   if the element/JS never upgrades, the viewport must still show the active panel correctly (fallback
   height `auto`; the transform still works via Elm).

3. **Apply the helper** to:
   - **Primary:** the API-surface code toggle in `Name_.elm` — change `exampleBlock`/`codeFor` to render
     **all** `layersFor ex` panels (each its own `Doc.code_` surface) inside `slidingPanels` with
     `activeIndex` = the selected layer's position in `layersFor ex`. The `<m3e-tabs>` strip stays as-is
     (it has its own indicator animation); only the code panel below slides.
   - **Secondary (apply if low-risk):** `Travel.elm` `categoryTabs` panels, using the same helper. If the
     Travel content doesn't fit the panels-in-a-track shape cleanly, DEFER it with a note (the primary
     case is the required deliverable).

## Accessibility & correctness
- Panels stay in the DOM (native find-in-page still works on the active panel; B2 folds unaffected).
  Inactive (off-screen) panels get `aria-hidden="true"` and `inert` so AT/keyboard skip them; the active
  panel is not inert. Viewport `overflow` clips the off-screen panels.
- Keyboard: tab selection is already keyboard-driven via `<m3e-tabs>`; the slide is presentational.
- No `display:none` on panels (keep them measurable/searchable); off-screen via transform + clip only.

## Acceptance criteria
1. Clicking an API-surface tab **slides** the code panel (prior slides out, new slides in) rather than
   instant-swapping — verified with playwright (assert the track's `transform` changes and animates; e.g.
   sample `transform` mid-transition or assert the transition property is set and the translateX value
   maps to the selected index).
2. The code container height **follows the active surface with no jump** — switching from a short (M3e) to
   a tall (HTML) surface grows the container smoothly; switching back shrinks it. No large empty space
   under a short panel. Verify container height ≈ active panel height at rest (playwright bounding boxes).
3. **Reduced-motion:** `prefers-reduced-motion: reduce` disables the slide + height animation (content
   still changes instantly, correctly). Verify the media query exists and (playwright with reduced-motion
   emulation) the transform has no transition.
4. **All surfaces reachable & correct:** every tab still shows its correct code; the selected tab's code
   matches what `codeFor` produced before (no content regression). B2 folds still work inside each panel.
5. **Find-in-page** on the active panel still reveals text in a closed fold (B2 behavior intact).
6. The helper is **reused** for the primary case and (if shipped) Travel `categoryTabs` — one
   implementation, not two.
7. `cd docs && npm run build:ci` → exit 0 (`check-nav: OK`, `Success - Adapter script complete`);
   `elm-format --validate app src` → `[]`.
8. No perceptible perf regression from mounting all panels — spot-check a heavy page (e.g. `/components/list`
   or `/components/tabs`) still loads and interacts smoothly (note the DOM-cost tradeoff; see R2).

## Deviations / decisions logged
- **translateX track over View Transitions.** VT would keep a single panel mounted (less DOM), but wrapping
  Elm's own vdom patch in `document.startViewTransition` is fragile (Elm owns the render loop), and
  directional VT (`types` / `:active-view-transition-type`) only reached Baseline 2026-01-13. The
  translateX track is Elm-native (declarative from state), reliable, and needs JS only for height.
- **Mount all panels** (DOM-cost tradeoff, R2) — required for a slide (old+new both present). Panels are
  static highlighted HTML (cheap vs the live m3e previews already on the page).

## Risks
- **R1 — height-sync jank.** ResizeObserver height transitions can fight fold open/close animations.
  Mitigation: transition only `height`; keep it short; test opening a fold in the active panel mid-view.
  If height-sync proves janky, fall back to a fixed-but-generous viewport height with internal scroll and
  note it (still no cross-tab jump). Playwright must confirm no jump.
- **R2 — DOM cost** of ~5 panels × ~15 examples/page. Mitigation: panels are static; spot-check interaction
  smoothness (criterion 8). If a page is egregiously heavy, note it; do not prematurely add lazy-mount
  (breaks the slide).
- **R3 — off-screen panel focus/scroll traps.** `inert` + `aria-hidden` on inactive panels prevents tab
  focus landing off-screen. Verify keyboard tab order stays within the active panel.
- **R4 — regression to the per-example render** (the seam B1.5c/B2 also touched). Mitigation: confirm every
  tab shows the same code as before; playwright across pages/surfaces; build:ci green.
