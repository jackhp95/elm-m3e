# Spec — B2: Auto-derived code folding (native `<details>`)

**Date:** 2026-07-07
**Branch:** `docs/b2-code-folding`
**Design source:** `docs/superpowers/specs/2026-07-07-example-sourcing-and-folding-design.md` § B2 (this spec
refines the *implementation mechanism* after investigating the render path; product intent unchanged).

## Goal

Every code block on a component page renders with **auto-derived** folding so complete examples stay
readable: nested chevron folds computed from indentation, a distinct `…` fold for repeated siblings,
and boilerplate collapsed by default. Native `<details>` only — no CodeMirror, no JS library, no
generator hand-config. Folded content stays find-in-page searchable and keyboard-accessible.

## Render-path facts (from investigation — these drive the mechanism)

- `docs/src/Doc.elm` `code_ : Lang -> String -> Element {s|html} msg` (~line 84) takes a **raw code
  string** and highlights it in Elm via `pablohirafuji/elm-syntax-highlight@3.7.1`.
- Today it calls `SyntaxHighlight.toBlockHtml Nothing` → a **flat, non-line-structured** `<pre><code>`
  span stream; line boundaries are literal `\n` text only. **You cannot wrap line ranges in that.**
- `HCode` is **opaque**; `Line`/`Fragment` are not re-exported. So we cannot unwrap the block to fold
  its lines. **Chosen mechanism:** compute the fold tree from the raw string (`String.lines` +
  indentation), highlight **per line** with `SyntaxHighlight.<lang> line |> toInlineHtml` (keeps the
  `.elmshN` token classes), and assemble nested `<details>` in Elm.
- Indentation is preserved verbatim in `data/examples.json`; the only normalization is a whole-block
  `String.trim` in `code_`. Interior indentation is intact → fold computation is reliable.
- The live preview (`rawPreview`/`showcase`) is fully decoupled from `code_` — **do not touch it.**
- Styling: inline Tailwind classes + a hand-written global `docs/style.css` (`.elmsh*` token colors
  live there). New `<details>`/`summary` rules go in `style.css`. **Elm cannot set CSS variables** →
  any per-instance value must be a Tailwind `[--var:val]` arbitrary class (memory
  `docs-mobile-polish-and-surfaces`).
- No existing `<details>`/accordion code — greenfield. `node "details"`/`node "summary"` is idiomatic
  here (Doc.elm already uses `node "raw-html"`).

## Scope — phased

### Phase 1 (REQUIRED — the robust renderer core)
1. **Indentation chevron folds**, computed in a new `docs/src/Doc/Fold.elm`, rendered by `code_`:
   - A line whose next non-blank line is more deeply indented is a **fold header**; its region spans
     following lines until indentation returns to ≤ the header indent. Regions **nest**.
   - Rendered as nested `<details>`: `<summary>` = the (highlighted) header line + a CSS chevron that
     flips open/closed; the deeper body is the collapsible content. Default **open**.
   - Non-header lines render as plain highlighted lines (line div).
   - Applies uniformly to **every** `Lang`/surface (Elm layers + HTML/Xml/Json/Shell). No generator work.
2. **Heuristic default-collapse:** a fold whose body exceeds **N lines** (N≈6, tuned so brevity/boilerplate
   sections like appbar "Sizes" open collapsed) renders **without** `open` (starts closed). This is the
   design's sanctioned "no behavior gap" fallback for matraic-guided collapse.
3. **Native-`<details>` UX:** folded content stays find-in-page searchable + deep-linkable (native,
   Baseline Widely available — no fallback needed per `modern-web-guidance` `search-hidden-content`).
   Keyboard-toggle works natively. **No `display:none`** beyond what `<details>` provides. Any fold
   open/close animation must honor `prefers-reduced-motion: reduce` (no animation when set).
4. **Highlight fidelity & graceful fallback:** per-line highlight must keep the current token colors;
   if `SyntaxHighlight.<lang>` errors on a line, fall back to plain `text` for that line (never crash,
   never show a raw block). Horizontal overflow scroll (`overflow-x-auto`) preserved.

### Phase 2 (SHIP IF ROBUST, else defer with a note)
5. **Repeated-sibling `…` folds**, also **renderer-derived** (deviation from the design's generator-marker
   mechanism — see below): detect a run of **≥3 consecutive lines at the same indentation whose
   normalized leading construct is identical** (e.g. `M3e.menuItem …` repeated, or `<m3e-menu-item …`
   repeated). Collapse the run into a single `…` summary (styled **distinctly** from the chevron),
   default **collapsed**, expanding to the full run on toggle. **Conservative detector:** only fold when
   the leading construct genuinely matches to avoid false positives; if a reliable detector can't be
   built without misfires, DEFER Phase 2 and document it (Phase 1 still ships).

### Deferred (documented, not built this stream)
- **Matraic-guided default-collapse via `brevitySource` alignment.** The design's primary policy; but it
  explicitly provides the Phase-1 heuristic as an equivalent-UX fallback with "no behavior gap." Deferred
  as a future refinement; the heuristic satisfies the observable criterion (boilerplate collapsed by
  default). `brevitySource` stays captured on every example (do not strip it) so this can be added later.

## Deviations from the § B2 design (justified)
- **Sibling folds renderer-derived, not generator-marked.** The design proposed inline `«siblings…»`
  markers emitted per-surface by both the Elm converter and the raw-HTML emitter. That adds a fragile
  generator↔renderer marker contract across two emitters (comment-safe, collision-free, stripped
  pre-highlight) touching the pipeline just changed in B1.5c. A renderer-derived detector is **more
  uniform** (zero generator, identical across all surfaces — the same property the design praises
  indentation folds for) and lower-risk. Outcome is identical (≥3 siblings → `…`). Aligns with the
  standing preference (uniformity, "it just works").
- **Matraic-alignment deferred** in favor of the heuristic (design-sanctioned; see Deferred).

## Acceptance criteria
1. Every code block on a component page offers indentation chevron folds; **nested** folds work; toggling
   is keyboard-accessible — **verified with playwright** (assert `<details>` present + nested, `open`
   toggles on click/Enter).
2. Highlighting is visually intact vs. before (token colors present; a spot-checked block matches) and
   horizontal scroll still works on a long line.
3. Boilerplate-heavy sections open with the long fold **collapsed by default** (`<details>` without
   `open`); a specific brevity example (e.g. appbar "Sizes") is verified collapsed at load.
4. **Find-in-page** for a term inside a collapsed region reveals it (native `<details>` behavior) —
   spot-verified with playwright (search term in closed fold → its `<details>` becomes `open`).
5. Folding is **identical across all surface tabs** and **no raw markers** appear in any surface.
6. If Phase 2 shipped: repeated-sibling runs render as `…`, styled distinctly, and expand on toggle
   (playwright). If deferred: documented, with Phase 1 intact.
7. `prefers-reduced-motion: reduce` disables fold animation (spot-verify the CSS media query exists).
8. `cd docs && npm run build:ci` → exit 0 (`check-nav: OK`, `Success - Adapter script complete`);
   `docs/node_modules/.bin/elm-format --validate app src` → `[]` after any `.elm` edit.

## Risks
- **R1 — per-line highlight loses multi-line context** (block comments `{- -}`, multi-line strings).
  Example code is short view expressions where this is rare/absent. Mitigation: spot-check a few Elm +
  HTML blocks render correctly; the per-line fallback to plain `text` prevents crashes. If a real
  multi-line construct appears and breaks, note it (acceptable minor glitch, or special-case).
- **R2 — DOM change to EVERY code block.** `code_` output shape changes site-wide. Mitigation: playwright
  across several component pages + surfaces (not just one); confirm no layout/scroll regressions.
- **R3 — fold algorithm edge cases:** blank lines inside a body, trailing dedent, a header whose body is
  1 line, deeply nested indents. Mitigation: unit-test `Doc/Fold.elm`'s fold-tree computation with a
  table of inputs (pure function → easy to test); assert nesting + region boundaries.
- **R4 — Phase-2 false positives.** A conservative detector; defer if unreliable (see Phase 2).
