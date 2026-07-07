# Plan — B2: Auto-derived code folding

Spec: `docs/superpowers/specs/2026-07-07-b2-code-folding.md`
Branch: `docs/b2-code-folding` (off `main` @ `279a3e1`).

## Files
- NEW `docs/src/Doc/Fold.elm` — pure fold-tree computation + `<details>` assembly (with per-line
  highlight). Keeps `Doc.elm` lean.
- `docs/src/Doc.elm` — `code_` (~line 84): route through `Doc.Fold` instead of `toBlockHtml Nothing`.
- `docs/style.css` — chevron/ellipsis `<details>`/`<summary>` rules, `prefers-reduced-motion`.
- NEW `docs/src/Doc/Fold.test.*` OR extend the existing test harness — unit-test the fold-tree function.
  (Elm unit tests: check whether the docs project has `elm-test`/`elm-explorations/test` set up; if not,
  a small `node`-driven assertion via `elm make` of a test module, or a `docs/scripts/*.test.mjs` that
  shells the pure function is overkill — prefer `elm-test` if present, else a `Debug`-free example module
  compiled + a tiny runner. Decide based on what's already wired; do NOT add a heavy test dep.)

## Step 0 — Baseline
- `cd docs && npm run build:ci` at HEAD → confirm exit 0 (know the starting green state).
- Note the current code-block DOM: build + serve, screenshot one component page's code block (e.g.
  `/components/appbar`) so highlight fidelity can be compared after (R2).

## Step 1 — `Doc/Fold.elm`: fold-tree computation (pure, testable)
Design the core as pure functions, independent of Html, so they're unit-testable:

```
type alias Line = { indent : Int, text : String }        -- text is the line minus leading spaces? keep raw
-- Fold tree
type Node
  = Leaf String                       -- a plain code line (raw, with its indentation)
  | Fold { header : String            -- the header line
         , body : List Node           -- nested
         , collapsed : Bool }         -- default-collapsed (heuristic)
  | Siblings (List String)            -- Phase 2: a ≥3 run rendered as `…`
```
Algorithm (indentation folds):
- `String.lines` the (already whole-block-trimmed) code. Compute each line's leading-space count
  (`indent`). Blank lines belong to the current region (attach to the preceding header's body; don't
  start/end a fold on a blank line — use the next NON-blank line's indent to decide headers).
- A line L at indent `i` is a **fold header** iff the next non-blank line has indent `> i`. Its body =
  the maximal run of following lines until a non-blank line returns to indent `≤ i`. Recurse into the
  body. Non-headers are `Leaf`.
- **Heuristic collapse:** `collapsed = bodyLineCount > n` where `n = 6` (name it `defaultCollapseThreshold`,
  tune during Step 5).
- Keep it total: single-line input, all-same-indent, trailing dedent, deeper-then-shallower all produce
  sane trees (cover in tests).

## Step 2 — Per-line highlight + `<details>` assembly (in `Doc/Fold.elm`)
- `renderNode : Lang -> Node -> Html msg`.
- **Leaf line:** highlight the single line: `SyntaxHighlight.<lang> line |> Result.map toInlineHtml`,
  fall back to `text line` on `Err`. Wrap in a line-level element that preserves whitespace (e.g. a
  `<span class="cf-line">` inside a `<pre>`-styled container, OR keep the outer `<pre>` and emit lines as
  block children). Ensure leading indentation renders (the container must be `white-space: pre`).
- **Fold node:** `node "details" (openAttr collapsed) [ node "summary" [chevron + highlighted header] , body… ]`
  where `openAttr` adds the boolean `open` attribute unless `collapsed`. The `<summary>` must show the
  header line's code (highlighted) with a chevron affordance (CSS `summary::marker` replacement or a
  pseudo-element — see Step 4). Body lines are the nested rendered nodes.
- **Whitespace/layout:** the whole block stays inside one scroll container (`overflow-x-auto`, the
  existing `wrapperClass`). Ensure `<details>`/`<summary>`/lines are `display:block` with `white-space:pre`
  so indentation + long lines behave exactly like the old `<pre>`. Watch that nesting `<details>` doesn't
  add unwanted default margins (reset in CSS).
- `code_` in `Doc.elm`: replace the `Ok highlighted -> toBlockHtml Nothing` branch with a call to
  `Doc.Fold.view lang trimmed`. Keep the `wrapperClass` div wrapper and the `Err` whole-block fallback as
  a last resort (though per-line handles most).

## Step 3 — Phase 2 (sibling `…`), attempt; defer if unreliable
- Extend the tree builder: within a body (or top level), detect a maximal run of **≥3 consecutive
  `Leaf` lines at equal indent whose "leading construct" matches**. Define leading construct
  conservatively: for Elm, the token sequence up to the first `[` or the `M3e.<name>` head; for
  HTML/Xml, the opening `<m3e-...` tag name. Normalize + compare; only group when all ≥3 share it.
- Render `Siblings lines` as a distinct `<details>` (default closed, NO `open`) whose `<summary>` is a
  `…` affordance (styled differently from the chevron — e.g. a horizontal ellipsis, different color/no
  chevron), body = the highlighted lines.
- **If false positives appear** on real examples (grep/spot-check menu/list/nav pages), DEFER: remove the
  Siblings path, keep Phase 1, and note the deferral in the impl report + a code comment. Do not ship a
  detector that mis-collapses distinct lines.

## Step 4 — CSS in `docs/style.css`
Add a block (near the `.elmsh*` rules) for the fold affordances:
- Reset nested `<details>`/`<summary>` margins/padding; keep `pre`-like `white-space:pre` and the mono
  font/line-height already used by code blocks.
- **Chevron:** remove the default disclosure triangle (`summary { list-style:none } summary::-webkit-details-marker{display:none}`) and add a rotating chevron via a `::before`/`::after` pseudo (a CSS triangle or a unicode ▸ that rotates to ▾ on `details[open] > summary`). Use `currentColor`/token colors.
- **Ellipsis summary:** a distinct class (e.g. `summary.cf-ellipsis`) showing `…`, no chevron, visually
  subdued.
- **Animation:** optional subtle open/close transition; wrap any transition in
  `@media (prefers-reduced-motion: no-preference) { … }` (or set `transition:none` under
  `prefers-reduced-motion: reduce`). No animation is also fine — but the media query must exist if any is
  added. **Never** apply `display:none` to folded content (breaks find-in-page) — rely on `<details>`.
- Ensure the summary is keyboard-focusable (native) and has a visible focus ring consistent with the
  site.

## Step 5 — Verify (the bar)
- Unit tests for `Doc/Fold.elm` fold-tree: pass (table of edge cases from R3).
- `docs/node_modules/.bin/elm-format --yes src/Doc/Fold.elm src/Doc.elm` then
  `elm-format --validate app src` → `[]`.
- `cd docs && npm run build:ci` → exit 0 (`check-nav: OK`, `Success - Adapter script complete`).
- Tune `defaultCollapseThreshold` so appbar "Sizes" (or a comparably long brevity block) loads collapsed
  while short examples stay open.
- **Playwright (build `dist`, serve, ~1600ms upgrade wait), assert on real DOM at desktop + mobile:**
  - On ≥2 component pages (e.g. `/components/appbar`, `/components/list` or `/components/tabs`) and across
    ≥2 surface tabs: `<details>` folds exist inside code blocks; at least one is **nested**.
  - Toggle: click a `<summary>` → its `<details>` `open` flips; Enter key on a focused summary toggles.
  - A long/boilerplate fold is `open`-absent at load (collapsed); a short one is open.
  - **Find-in-page reveal:** put a unique token that lives inside a collapsed fold; use Playwright's
    `page.keyboard` find or evaluate `window.find(token)` (or set the closed `<details>` and call the
    native find) to confirm the browser opens the closed `<details>` — OR assert the native behavior by
    checking the token's `<details>` ancestor becomes `open` after a find. (If `window.find` is
    unavailable in headless, assert the searchable-DOM property: the text node exists in the DOM while the
    `<details>` is closed and NOT `display:none` — that is the property that makes native find work.)
  - Highlight fidelity: token spans (`.elmsh1`…) still present; screenshot vs Step 0 baseline.
  - No literal `«…»`/marker text visible in any surface (there shouldn't be — renderer-derived).
- Screenshots to the session scratchpad, not the repo.

## Step 6 — Do NOT commit; leave dirty for review.

## Deliverable for review
1. Diffs: `Doc/Fold.elm` (new), `Doc.elm` `code_`, `style.css`, tests.
2. The fold-tree algorithm + the unit-test table (inputs → expected tree) with passing output.
3. Whether Phase 2 (siblings) shipped or was deferred, with the reason + evidence (false-positive check).
4. `defaultCollapseThreshold` final value + the brevity example proven collapsed.
5. Playwright transcript + screenshots proving criteria 1–7 at desktop + mobile.
6. `build:ci` exit 0 + `elm-format --validate` `[]`.
7. Confirmation the live preview (`rawPreview`) is untouched and highlight fidelity holds.
