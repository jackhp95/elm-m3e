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

Three phases, each independently shippable:

- **B1 — Re-source from `.showcase`.** Complete markup → correct previews + complete code.
  High value, self-contained. **DONE** (branch `docs/example-sourcing`) — but it revealed that
  complete markup *exposes* converter/library gaps the hollow shells were masking (net example
  count went 265→250, skips 60→97). Hence B1.5.
- **B1.5 — Recover + exceed the example count (converter coverage).** Close the three
  independent causes that drop examples, so we ship *more* examples than before — the actual
  "more examples than matraic" goal. See the dedicated section below.
- **B2 — Auto-derived folding.** Native `<details>` regions so complete code stays readable.

B1's earlier "non-goal" (the API/converter drops) is now **B1.5's whole point** — it turned out
to be the dominant lever for example count, not a small side thread.

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

### B1 outcome (as implemented)

- `/components/appbar` "Sizes" (and other brevity sections) render **complete** app bars, not
  empty shells — verified with playwright. ✅ Correctness win.
- **Count regressed**, not improved: `data/examples.json` went 265→250, `examples.skipped.txt`
  60→97. Complete markup *exposes* converter/library gaps the hollow shells masked (an empty
  `<m3e-app-bar>` compiled trivially; its complete form hits real gaps). Zero brevity/hollow
  skips remain — the new skips are all genuine coverage gaps. This is why B1 is **not merged
  standalone**: it is bundled with B1.5, which recovers and exceeds the old count.
- Gates green (`build:ci`, `elm-format`, `check:nav`). ✅

---

## B1.5 — Converter coverage (recover + exceed the count)

The 97 drops have **three independent root causes** (not one). All are currently fatal because
of a single meta-cause, so the fix is layered: a safety net that recovers everything, plus
targeted fixes that restore full-fidelity output.

### Meta-cause: the all-or-nothing layer invariant

`examples-to-elm.mjs:222-224` enforces that an example ships **only if top (M3e) AND mid
(M3e.Cem) AND bottom (M3e.Cem.Html) all compile** — "so the layer toggle is never partial."
This is the opposite of the library's own layered/escape-hatch philosophy (lower layers exist
as fallbacks for what the strict top can't express). A single strict-top failure discards the
whole example even though the permissive layers + HTML compile fine.

**Fix (the safety net) — graceful degradation.** Ship an example if **≥1 surface compiles**;
record per-example which surfaces are valid. The renderer (`app/Route/Components/Name_.elm`,
`layersFor`/`layerTabs`) shows only the valid surface tabs. This alone recovers **all 97**
(they all compile at HTML/bottom), honoring the layer design. Trade-off vs. the prior uniformity
choice: genuine-gap examples show a *partial* toggle (e.g. HTML + bottom, no strict M3e tab) —
accepted, because showing an example at 2-3 layers beats dropping it. The targeted fixes below
then restore most examples to full 4-tab parity, so partial toggles are the rare residue.

### Cause 1 — converter child-routing bug (most of the ~55 arg-type failures)

`to-elm.mjs` (elementToElm) lumps ALL slot-less children into one `M3e.<Mod>.children [...]`.
That only type-checks when `children`'s phantom row is a UNION over every child kind (true for
Menu/NavMenu/FabMenu — those already work). It breaks for composites that route children to
DIFFERENT helpers. **Fix — route slot-less children per-tag** using the routing table (see the
`docs-composite-routing-table` memory / the M3e module signatures):

- Tabs: `m3e-tab`→`children`, `m3e-tab-panel`→`Tabs.panel` (single-Content named slot).
- Stepper: `m3e-step`→`Stepper.step`, `m3e-step-panel`→`Stepper.panel` (no `children`).
- SplitButton: `slot=leading-button`→`leadingButton`, `slot=trailing-button`→`trailingButton`.
- Tree/NavMenuItem/Step/RichTooltip/Option/Select: route named-slot children (icons, labels,
  badges, actions, subhead, arrow/value) to their slot helpers; nested items/default text to
  `children`/`child`.

### Cause 2 — Elm-library version skew

Docs render with **@m3e/web 2.5.13** (matraic source = matraic-m3e @ c9c781a). The generated
Elm library `packages/m3e` (v1.0.0) is behind: web components that exist in 2.5.13 have no Elm
binding — confirmed for `m3e-stepper-next` and `m3e-fab-menu-item` (real custom elements in
2.5.13, but no `StepperNext.elm` / `FabMenuItem.elm`). **Fix — regenerate `packages/m3e` from
2.5.13's CEM via elm-cem.** This adds the missing bindings; the converter (Cause 1 fix) can then
route those tags. Regen may ripple into the reference/docs — verify the whole build after.

### Cause 3 — genuine API gaps (no path even in the current lib)

`m3e-optgroup` inside `m3e-select` (no `Select.optgroup` helper), Menu submenus (`submenu` is an
Attr Bool + a separate `<m3e-menu>` via MenuTrigger, no nested-child path). **Not fixed in B1.5**
— the graceful-degradation safety net ships these at HTML/bottom; real support is deferred
library-design work.

### Cheap buckets

- **`<script>` "Native module support" (17):** every one is a bare
  `<script type="module" src="…/dist/X.js">` — meaningless as Elm. **Filter at extraction.**
- **Misc attrs (~6):** `m3e-toc-ignore`, `hidden`, `autofocus` — add to droppable-attr list or
  map to setters.

### B1.5 decomposition + sequence

- **B1.5a — Graceful degradation** (the safety net). Highest leverage, smallest change;
  immediately recovers all 97 and makes every later fix incremental (upgrade a tab, not
  all-or-nothing). Do first.
- **B1.5b — Library regen** from @m3e/web 2.5.13's CEM (Cause 2). Adds StepperNext/FabMenuItem.
- **B1.5c — Converter routing fix** (Cause 1) + cheap buckets (script filter, attrs), now
  including the regen'd tags.
- Cause 3 (genuine gaps) is covered by 1.5a and deferred otherwise.

### B1.5 success criteria

- `data/examples.json` total example count **exceeds** the pre-B1 baseline (265) — verified.
- No example that compiles at any layer is dropped; `examples.skipped.txt` contains only the
  genuine-gap residue (optgroup-in-select, menu submenus), each also visibly shipping at
  HTML/bottom on its component page — verified with playwright.
- Composite pages (Tabs, Stepper, SplitButton, Tree, Select) show full 4-tab parity where the
  routing fix + regen apply — spot-verified with playwright.
- All gates green; `packages/m3e` regen doesn't break the reference or the docs build.

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
