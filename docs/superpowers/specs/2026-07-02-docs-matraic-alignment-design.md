# Docs site — matraic m3e alignment & verified example pipeline

**Date:** 2026-07-02
**Status:** Design approved, pending spec review → implementation plan

## Problem

The matraic m3e reference site (<https://matraic.github.io/m3e>) documents each
component as a narrative **Usage** page: a one-line intro, then repeating feature
sections (Variants, Shapes, Sizes, Icons, Disabling, Accessibility…), each showing a
**rendered gallery** followed by a **code snippet**, with the API reference deferred to
the Custom Elements Manifest at the end.

Our elm-pages docs site (`docs/`) currently renders only the generated **API reference**
(from `elm make --docs` → `docs/data/reference.json`); the per-component *live demos were
removed/deferred* for bundle weight (`docs/app/Route/Components/Name_.elm:6-8`). We want
to adopt matraic's documentation approach — narrative usage pages with live examples +
code — and get structurally/visually closer, **while keeping the standard Elm function
documentation** and **enhancing our CEM tooling to be more documentation-friendly**.

## Goals

1. Per-component **Usage** pages: feature-section galleries with a **live, theme-inheriting
   preview** paired with the **verbatim Elm code**, sourced from a verified pipeline.
2. **Categorized** component navigation (categories + alphabetical-within) and closer
   visual/structural alignment to matraic (shell, page idioms).
3. Keep the standard Elm reference (`reference.json`) alongside — enrich it, don't replace.
4. Enhance **elm-cem** with generic, documentation-friendly capabilities — **without**
   locking it to m3e conventions.

## Non-goals

- A "Frameworks" nav group (matraic's React/Vue/Angular guides) — N/A for Elm.
- Replacing Studies — they stay; they are our differentiator.
- iframe-based example isolation — previews render inline (theme inheritance).
- Hand-authored per-component demos — the converter feeds examples.

## Confirmed decisions

| Decision | Choice |
| --- | --- |
| Example source | Mix: mine JSON corpus → convert to Elm → verified doc-comment examples → render |
| Render mechanism | **Inline, injected** into the page (inherits `<m3e-theme>`); per-route code-split |
| Rollout | **Whole pipeline at once** (data-driven; converter robustness is the key risk) |
| Nav grouping | **Categories + alphabetical within**; category from CEM config doc metadata |
| Section taxonomy | **Auto-derive from CEM attributes + config override** (rename/order/curate) |
| Where examples live | **Library doc comments** (Approach A) — reuse `reference.json`, enrich registry docs |
| elm-cem scope | **Generic** — m3e specifics live in our config/scripts layer, never in elm-cem |
| Development style | **TDD** — a failing test precedes the implementation at every step |

## Architecture — three layers, strict dependency direction

Each layer depends only on the one above it. The rule: **elm-cem gains generic
capabilities; m3e-specific knowledge never leaks into it.**

### Layer 1 — `elm-cem` (generic, published standalone)

Manifest-agnostic, config-driven additions. elm-cem treats all of these as opaque data —
it never knows what an `<m3e-button>` is.

- **Example ingestion:** the generator accepts, via config, a per-view list of example
  records `{ title, code, section? }` where `code` is already-Elm source. It emits them
  into generated doc comments as structured fenced blocks (a shape both the compiler reads
  as prose and our extractor reads as data).
- **Doc metadata passthrough:** config attaches arbitrary opaque doc metadata to a
  component (e.g. `category`, and free-form keys); elm-cem emits it generically.
- **Section hinting:** an optional, data-driven rule — "given an attribute name, which
  section does an example exercising it belong to?" — supplied by config as a map, not
  code. Default: no grouping. elm-cem ships the mechanism; the mapping is the consumer's.

**Genericity guard:** a non-m3e fixture manifest (e.g. one of the existing
`elm-cem/cem-configs/{carbon,spectrum,ionic}` inputs) exercises these features in a test,
proving they work for any CEM.

### Layer 2 — elm-m3e generation config + scripts (m3e-specific)

- **HTML→Elm converter:** mines `m3e-docs/data/examples.json` (keyed by slug →
  `[{title, code, source, origin}]`), maps raw `<m3e-*>` markup → our `M3e.*` API using
  the CEM as the mapping oracle (tag→module, attribute→builder/setter, child-in-named-slot
  →slot function). Unmappable snippets are **skipped and logged**, never silently emitted
  as wrong Elm; the log is the coverage report.
- **Section deriver:** tags each converted example by its distinguishing attribute →
  section, via the data-driven map. CEM config can rename/reorder/reassign per component.
- **CEM config overrides:** categories (nav), section curation, per-component doc metadata.

These produce the generic example-records + metadata handed to elm-cem's Layer-1 hooks.

### Layer 3 — docs site (`docs/`)

- **Renderer-extractor** ("verify-examples-style but renders views"): pulls the fenced
  code blocks from the generated doc comments into compilable **view modules** under
  `docs/`. Compilation is the verification — a drifted example breaks the build.
- **Inline injection:** per-component route imports its extracted example modules
  (code-split per route), renders each as a `showcase` Card (live preview) + `example` Card
  (verbatim code), grouped under section headings.
- **Restyled pages + categorized nav + shell alignment** per `docs/M3E_DOCS_STRUCTURE.md`.

**Boundary test:** could someone point elm-cem at a Carbon/Spectrum manifest, supply their
own example corpus + category map via config, and get the same enrichment? If yes, correct.

## The verified example pipeline (stage by stage)

1. **Corpus → normalized examples** (L2): read `examples.json` (+ optionally
   `guidance.json`); output normalized per-component list, raw HTML.
2. **HTML → Elm** (L2, CEM-driven): parse each snippet, map to `M3e.*` API; skip+log
   unmappable snippets.
3. **Section tagging** (L2): derive section from distinguishing attribute; apply config
   overrides. Output records `{ title, code, section }`.
4. **Injection into doc comments** (elm-cem, generic): write records into
   `packages/m3e/src/M3e/*.elm` doc comments as structured fenced blocks.
5. **Two consumers:**
   - `elm make --docs` → `reference.json` (existing path) now carries examples → docs site
     **and** the published registry docs both get them.
   - Renderer-extractor → compilable view modules under `docs/`.
6. **Inline render** (L3): per-component route renders preview + code per example, grouped
   by section, code-split per route.

**Key property:** the rendered preview and the shown code come from the **same extracted
module** — they can never disagree. (Stronger than matraic, where gallery and snippet are
authored independently.)

## Pages, nav, visual alignment

Largely *applying* `docs/M3E_DOCS_STRUCTURE.md`, not inventing.

- **Component page** (`docs/app/Route/Components/Name_.elm`): `ContentPane` →
  `Heading(display,1)` name → intro tagline (from CEM `summary`/`description`) + `install`
  Card (`import` line) → **Usage sections** (per section: `Heading(headline,2)`, optional
  prose, then per example a `showcase` Card + `example` Card) → **API reference** (existing
  member list from `reference.json`, kept verbatim as the standard-Elm-docs tail).
- **Nav** (`docs/app/Shared.elm`): `componentList` (currently flat, hand-synced 53 pairs at
  `:697`) becomes **category-grouped** (category from CEM config doc metadata, alphabetical
  within), rendered as `NavMenu > NavMenuItem` groups. Final order: **Getting Started ·
  Styles · Components (categorized) · Studies · Reference**.
- **Visual closeness:** adopt the blueprint's shell (app-bar leading hamburger +
  `drawer-toggle`, version chip, npm/github/settings trailing, `drawer-container` with
  `nav-menu` in `start` + settings in `end` slot). Tailwind on Seam/Native elements only
  for pure layout; everything else a real component so the docs *are* the showcase.

## CEM config schema additions

Generic in elm-cem (opaque/data-driven); populated with m3e values in our Layer-2 config:

- `examples` — per-view list of `{ title, code, section? }` (converter output; hand-override
  allowed).
- `docMeta` — per-component opaque map; m3e uses `category` + free-form keys.
- `sections` — per-component `{ order: [..], labels: {attr → "Name"}, reassign: {title →
  section} }` to curate auto-derived grouping.
- `sectionHints` — global default `attr → sectionName` map (the data-driven rule).

None are m3e-named in elm-cem; any manifest consumer can fill them.

## Development approach — TDD at every step

Each step starts with a failing test, then the implementation makes it pass:

- **elm-cem capabilities:** unit tests + a **non-m3e fixture manifest** proving example
  ingestion, docMeta passthrough, and section hinting are generic (written first).
- **Converter:** **golden tests** (HTML snippet → expected Elm) across representative
  shapes — variant attribute, slotted child, link, toggle, nested composition — written
  before the converter.
- **Section deriver:** table tests mapping attribute → section, including config override
  precedence.
- **Renderer-extractor:** a regression test that deliberately drifts one example and
  asserts **compilation fails** (the "examples can't lie" guarantee).
- **Site:** `elm make --docs` stays green; a smoke build of the docs app renders examples.

## Rollout (whole pipeline at once, tree green at each step)

1. elm-cem generic capabilities (ingestion + docMeta + section hints) — genericity fixture
   test first.
2. L2 converter + section deriver + config across all components; commit coverage/skip log.
3. Regenerate `packages/m3e` doc comments; verify `elm make --docs` + `reference.json` green.
4. Renderer-extractor → view modules; wire per-route code-splitting.
5. Restyle component route + categorized nav + shell alignment.

## Risks & mitigations

- **Converter special-cases (highest risk):** unmappable snippets skipped + logged, never
  faked; coverage report shows exactly what's missing — degrades gracefully.
- **Bundle-weight regression** (why old demos were removed): per-route code-splitting;
  measure build time/bundle after step 4 before declaring done.
- **Fenced-block marker convention** must round-trip (readable Markdown ↔ machine-parseable):
  pinned early with a test.
- **elm-cem coupling:** guarded by the non-m3e fixture-manifest test.

## Open details (to pin during planning)

- Exact fenced-block marker convention (readable as Markdown, unambiguous for the extractor).
- Whether `guidance.json` prose feeds section intros in v1 or is deferred.

## Key files

- `docs/app/Route/Components/Name_.elm` — per-component page (restructure).
- `docs/app/Route/Reference.elm` — full API reference (kept).
- `docs/app/Shared.elm:697` — `componentList` → categorized nav.
- `docs/scripts/extract-reference.mjs` — `reference.json` generator (unchanged path, now
  carries examples).
- `docs/M3E_DOCS_STRUCTURE.md` — shell/page blueprint (apply).
- `elm-cem/codegen/Docs.elm`, `elm-cem/codegen/Generate.elm` — doc-comment generation
  (add generic example ingestion + docMeta + section hints).
- `m3e-docs/data/examples.json`, `guidance.json` — example corpus (mine).
- New: HTML→Elm converter, section deriver, renderer-extractor (Layer 2/3 scripts).
