# Example Sourcing + Code Folding — Design (Stream B)

**Date:** 2026-07-07
**Status:** Approved (design), pending implementation plan
**Scope:** Fix the docs site's hollow/trimmed examples by sourcing complete markup, and
add auto-derived code folding so complete examples stay readable. Second of four streams
(A quick fixes ✅ merged → **B example sourcing + folding** → C tab/panel sliding → D app shell).

## Problem

The docs pipeline sources each example from matraic's **trimmed** `.example` `<pre>` snippet
(`docs/scripts/examples-gen/extract-matraic-examples.mjs:96-98` deliberately skips `.showcase`).
Consequences on the live site:

1. **Hollow live previews.** ~192 of matraic's example cards use "Content omitted for brevity"
   markers. Sourced literally, they render an empty shell — e.g. `/components/appbar` "Sizes"
   shows two *empty* app bars because the `<pre>` is `<m3e-app-bar size="medium"><!-- Content
   omitted for brevity --></m3e-app-bar>`.
2. **Fewer examples than matraic.** Trimmed snippets that don't compile are dropped by the
   converter's compile-gate. We publish fewer examples than the site we emulate.

The **complete** markup is present in every `.showcase` card (verified: all 310 use
`div[slot="content"]`). Matraic's trimmed `.example` is not garbage, though — it is an
**editorial oracle** for what counts as boilerplate, usable to drive folding defaults.

## Design overview

Two phases, each independently shippable:

- **B1 — Re-source from `.showcase`.** Complete markup → correct previews + complete code +
  fewer drops. High value, self-contained.
- **B2 — Auto-derived folding.** Native `<details>` regions so complete code stays readable.

Non-goal (both phases): the ~60 examples currently dropped for **API/converter** reasons
(`Html.script` "Native module support", `child`/`children` mismatches, unmapped attrs — see
`config/examples.skipped.txt`) are a separate, smaller thread. B does not attempt them.

---

## B1 — Re-source examples from `.showcase`

### Sourcing model

Rework `extractPage` in `extract-matraic-examples.mjs` (currently streams
`m3e-heading, p, m3e-card` in document order, tracking the running `title`/`description`):

- **Showcase-backed example:** for each `.showcase` card, extract the inner markup of its
  `div[slot="content"]` (the real component subtree, which may contain several top-level
  components — e.g. a button row). This becomes the example's `code`/`source` — **complete**,
  pretty-printed, ready for the converter and the live preview.
- **Example-only card:** a `.example` card in a heading section with **no** preceding
  `.showcase` in that section (install snippets, `<script>` native examples, CSS blocks) keeps
  its current behavior — source the `<pre>` (or record as `nonHtml` as today). This preserves
  coverage of pure-code cards.
- **Pairing (for B2):** within each heading section, associate the showcase(s) with the
  section's `.example` `<pre>`, in document order, and carry it on the extracted record as
  `brevitySource` (the raw trimmed snippet). B1 only *captures* it; B2 consumes it. This keeps
  B1's output a superset of what B2 needs with no second parse.

### Titling / keys

Reuse the existing per-heading disambiguation (`titleCounts` → `Title`, `Title (2)`). A section
with two showcases yields `Sizes` and `Sizes (2)`. Titles remain the anchor/key basis, so
downstream keying in `build-examples-data.mjs` is unchanged in shape.

### Downstream (unchanged mechanics, better inputs)

`examples-to-elm.mjs` converts the now-complete markup to Elm and compile-verifies (the gate
stays — it still drops genuinely unconvertible cases, now far fewer). `gen-record-build.mjs`,
`gen-barrel.mjs`, and `build-examples-data.mjs` are unchanged; they consume whatever the
converter emits. The live preview (`Doc.rawPreview`) now receives complete markup, so previews
stop being hollow with no `Doc.elm` change required for B1.

### B1 success criteria

- `/components/appbar` "Sizes" (and other brevity sections) render **complete** app bars, not
  empty shells — verified with playwright.
- Example count in `docs/data/examples.json` **increases** materially vs. current (brevity-drop
  recovery); `config/examples.skipped.txt` shrinks to essentially the API-gap cases only.
- All existing gates stay green (`build:ci`, `elm-format`, `check:nav`).

---

## B2 — Auto-derived folding (native `<details>`)

All folding is **automatically derived** — no per-example hand-managed fold config. Two fold
types with distinct affordances, plus a default-collapse policy.

### Fold type 1 — Indentation folds (chevron), renderer-derived

Computed entirely in `Doc.elm` from each rendered code block's **indentation**, so it applies
uniformly to every surface (all Elm layers + HTML) with **zero generator involvement**:

- A line whose following line is more deeply indented is a **fold header**. Its region spans
  subsequent lines until the indentation returns to ≤ the header's indent. Regions **nest**.
- Rendered as nested `<details>`: `<summary>` = the header line (with a chevron that flips
  open/closed); the deeper-indented body is the collapsible content.
- Default **open** (chevron affordance present), unless marked default-collapsed (below).

### Fold type 2 — Repeated-sibling folds (ellipsis), generator-marked

A run of ≥3 consecutive same-tag siblings (e.g. many list items) collapses into a single `…`
summary that toggles the remainder — **styled distinctly** from chevron folds. Detected at
generation from the DOM (exact sibling structure), emitted as a paired inline marker around the
run. Default **collapsed** to the `…` form.

### Default-collapsed policy — matraic-guided, with heuristic fallback

- **Matraic-guided (primary):** align each `.showcase` subtree against its paired `.example`
  `brevitySource`. Where matraic replaced a subtree's content with an omission comment (or
  truncated a sibling list), mark the corresponding node **default-collapsed**. Auto-derived
  from matraic's files; nothing hand-managed.
- **Heuristic fallback:** where a section has no paired example, or alignment is unreliable for
  a component, default-collapse any indentation fold whose body exceeds N lines (N ≈ 6, tuned
  during implementation). Same UI; no behavior gap.

### Marker mechanism (generator ↔ renderer contract)

Indentation folds need **no** markers. Sibling folds and default-collapse need two auto-derived
signals, emitted as inline sentinel markers **per surface** by the emitters that already build
each surface's code string (the recursive Elm converter in `to-elm.mjs`, and the raw-HTML
emitter). Proposed markers (exact tokens finalized in the plan; must be comment-safe in both Elm
and HTML and never collide with real code):

- `«collapse»` on a fold header line → that indentation fold starts closed.
- `«siblings…»` / `«/siblings»` bracketing a repeated-sibling run → render as the `…` fold.

`Doc.elm` responsibilities, in order: (1) extract + strip markers, recording their line
positions; (2) syntax-highlight the clean code; (3) compute indentation folds from the clean
text; (4) render nested `<details>` — chevron folds (open unless a `«collapse»` header),
sibling folds (the `…` form), preserving highlight output within each segment.

### Accessibility / UX (from modern-web-guidance `search-hidden-content`)

Native `<details>` is Baseline Widely available, keyboard-accessible, and its folded content
stays **find-in-page searchable** (Ctrl-F auto-opens a matching closed `<details>`) and
deep-linkable — no JS, no library, no CodeMirror. Chevron and ellipsis are the only two
affordances; folded regions must not use `display:none` beyond what `<details>` provides.

### B2 success criteria

- Every code block on a component page offers indentation folds (chevron); nested folds work;
  toggling is keyboard-accessible — verified with playwright.
- Repeated-sibling runs render as `…` and expand on toggle.
- Brevity sections (e.g. appbar "Sizes") open with the boilerplate **collapsed by default**,
  matching matraic's reading experience, while the complete code is one click away.
- Ctrl-F for a term inside a collapsed region reveals it (native behavior) — spot-verified.
- Folding is identical across all four+ surface tabs (no surface shows raw markers).

---

## Files (anticipated)

- **B1:** `docs/scripts/examples-gen/extract-matraic-examples.mjs` (sourcing rework);
  possibly a small helper for showcase-content extraction + section pairing.
- **B2:** `docs/scripts/examples-gen/to-elm.mjs` + raw-HTML emitter (marker emission),
  `docs/src/Doc.elm` (marker parsing + fold rendering), plus a focused fold-render module if
  `Doc.elm` grows unwieldy. Alignment logic lives beside the extractor (reuses `brevitySource`).

## Verification (both phases)

Playwright is the standard for every visual claim (hollow→complete previews, chevron/ellipsis
folds, default-collapse, find-in-page reveal). Serve `dist` and assert on rendered DOM
(bounding boxes, `<details>` open state, element counts) plus screenshots. `build:ci`,
`elm-format`, and `check:nav` stay green throughout.
