# Design: Round-trip verification harness + kitchen-sink page + open-by-default code

**Date:** 2026-07-08
**Status:** Approved (brainstorming), pending implementation plan

Three independent pieces, bundled because they were raised together and share the
docs example pipeline. Part A is the substantial one; B and C are small.

---

## Part A — Bidirectional round-trip verification harness

### Motivation

The docs example pipeline already converts each raw `<m3e-*>` HTML example into
several typed Elm surfaces. If our converters/renderers are faithful, rendering a
converted example back to HTML should reproduce the original. Where it doesn't —
or where the conversion had to lean on an escape hatch — is a signal of a bug or a
modeling gap. This harness makes that signal measurable across the whole corpus.

### Role (decided)

**Report first, gate later.** Ship a diagnostic report over the corpus now; once
deviations are understood, promote the known-clean subset to a CI gate via a
committed baseline. Fuzzy cases stay advisory; only regressions gate.

### Scope (decided)

The full matrix: every corpus example × **all six surfaces** —
`M3e.Cem.Html` (bottom), `M3e.Cem` (middle), `M3e` (Standard/top), `M3e.Record`,
`M3e.Build`, and the flat barrel. Cells a surface did not convert are recorded as
such, not silently skipped. (~329 examples; ~1,500 non-empty cells.)

### Inputs (all already produced by the pipeline)

- **Raw HTML ground truth:** `config/examples.matraic.json`.
- **Converted Elm per surface:** `config/examples.rich.json` (top/mid/bottom),
  `config/examples.surfaces.json` (record/build), `config/examples.barrel.json`
  (barrel).

The harness *consumes* the pipeline; it does not re-derive conversions.

### Layer 1 — Convertibility + escape-hatch (static, no render)

Per cell:

- **Converted?** — the surface's field is non-null. Degraded cells are recorded
  (with the pipeline's reason from `config/examples.skipped.txt` where available),
  never silently dropped.
- **How clean?** — scan the converted Elm for the two escape mechanisms:
  - `Seam.*` — the sanctioned type-hole (asElement/asAttribute/fromHtml/…).
  - `Native.*` — raw-HTML fallback (used where a typed component wasn't available).
  Record, per mechanism: **count** of call sites and the **character span of the
  arguments inside** them ("how much code is inside the escape hatch"). Zero = a
  fully-typed conversion. Text-wrapping helpers (`Kit.text`, a lone `Native.span`
  around text) are reported but flagged as benign so they don't dominate the score.

Layer 1 needs no rendering and is cheap; it can run standalone.

### Layer 2 — Round-trip render + semantic diff (SSR)

- **Render mechanism (decided): elm-pages SSR (static).** A *generated harness
  route* renders every converted cell via `M3e.Node.toHtml`, each wrapped with a
  `data-rt="<component>/<index>/<surface>"` marker. `elm-pages` pre-renders it to
  **static, pre-upgrade light-DOM HTML** — apples-to-apples with the raw corpus
  (which is also pre-upgrade), deterministic, no browser. Reuses the compile step
  the pipeline already runs.
- The orchestrator splits the pre-rendered HTML by marker to recover each cell's
  re-rendered HTML.
- **Semantic diff (decided): DOM-tree.** Parse both sides (re-rendered vs raw
  corpus) into DOM trees; canonicalize (sort attributes, collapse insignificant
  whitespace, normalize boolean-attribute forms, normalize quote style); compare
  structurally. A cell **matches**, or yields a **structured deviation**: added /
  removed / renamed attribute, changed value, changed text, changed element or
  nesting. Mechanical differences (attr order, whitespace) are normalized away and
  never reported.

Surfaces that render identically to raw HTML by construction (notably
`M3e.Cem.Html`) should round-trip near-perfectly; deviations there are high-signal.

### Output — the report

- **Machine:** `docs/data/roundtrip-report.json` — the full matrix. Each cell:
  `{ converted, escapeHatch: { seam, native, charsInside }, roundtrip: { matches, deviations: [...] } }`,
  plus per-surface aggregates (e.g. "M3e: 78% clean round-trip, 12% needed an
  escape hatch, 4 deviations").
- **Human:** a generated, ranked standalone dev artifact (`roundtrip-report.html`,
  **not deployed**) — **deviations first** (each with its structured HTML diff),
  then heavy-escape-hatch cells, then clean. It is a verification tool, not
  consumer docs; can be promoted to a docs route later if desired.

### How it runs

- New script `docs/scripts/verify-roundtrip.mjs`, exposed as `npm run
  verify:roundtrip`. **Separate from `build:assets`** — verification, not a build
  input, and the SSR pass is heavier.
- Supporting modules: `docs/scripts/roundtrip/dom-diff.mjs` (parse + canonicalize
  + semantic tree-diff, using an existing/lightweight HTML parser dependency) and
  the generated harness route module.

### Gate later

Commit `roundtrip-baseline.json` capturing today's known-clean cells. A CI step
fails only when a previously-clean cell **regresses** (a match becomes a
deviation, or an escape-hatch weight crosses its recorded level). The fuzzy long
tail stays advisory; real regressions gate. Promotion to CI is a follow-up, not
part of the initial ship.

### Risks / notes

- **SSR volume:** ~1,500 cell renders on one (or a few, split-per-surface) route
  is a heavy pre-render. Split by surface or component if the single route is
  unwieldy; it is an on-demand harness, so wall-clock is acceptable.
- **Per-surface imports differ** (M3e vs M3e.Cem vs M3e.Record …); the generated
  harness module(s) must import each surface correctly — mirror what the
  examples-gen compile step already sets up.
- **Escape-hatch definition** may need tuning (which `Native.*`/`Seam.*` usages are
  benign); start with count + char-span and iterate from the first report.

---

## Part B — Kitchen-sink "all components" page

A single route (`/components/all`) that stacks **every** component's Usage section —
heading + live previews + code tabs — in category order, so a reader scrolls one
page instead of navigating per component.

- **Reuses existing rendering:** `usageBlocks` / `exampleBlock` from
  `app/Route/Components/Name_.elm`; factor the shared rendering so both the
  per-component route and this page call it.
- Each component wrapped in an `id` anchor for deep-linking; a drawer link
  ("All components") added to the nav.
- **Performance:** SSR'd like every route, plus `content-visibility: auto` on each
  component block so the browser skips rendering off-screen sections until scrolled
  near (keeps a 329-example page snappy without dropping content).
- **Fallback if still heavy:** previews-only with a "full example →" link per
  component. Start with full parity (previews + code) since the goal is finding
  what you need without leaving the page.

---

## Part C — Code details open by default

The code fold (`<details class="cf-fold">`) currently renders **closed**. Flip it to
render with the `open` attribute so all code shows by default; folks click to
collapse. One-line change at the fold's render site (`docs/src/Doc/Fold.elm` or
wherever `cf-fold` `<details>` is emitted). No harness/test impact — the browser
specs assert code *presence* (`toBeAttached`), not visibility.

---

## Testing

- **Part A:** unit-test `dom-diff.mjs` against fixtures (identical, attr-reordered,
  whitespace-only, and genuinely-deviating pairs) to prove normalization vs real
  deviations. Smoke-run `verify:roundtrip` and eyeball the first report.
- **Part B:** `build:ci` green; a Playwright check that `/components/all` mounts and
  a spot of components render; verify at mobile + desktop.
- **Part C:** a Playwright assertion that a code `<details>` is `open` by default.

## Sequencing

C (trivial) → B (contained docs feature) → A (the harness), or A first if it's the
priority. A's Layer 1 (escape-hatch/convertibility report) can ship before Layer 2
(SSR round-trip) since it needs no rendering — a natural incremental split.
