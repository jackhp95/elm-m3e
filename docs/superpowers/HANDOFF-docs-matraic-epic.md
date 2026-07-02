# HANDOFF — Matraic-Aligned Docs Epic (3-plan)

**Date:** 2026-07-02 · **Status:** ✅ **EPIC COMPLETE — Plans 1, 2 & 3 all LANDED & pushed.** Nothing outstanding except small follow-ups (below). Everything below §3 is historical, kept for reference.

> **UPDATE 2026-07-02 (increment 3 — DONE):** Phase A1 (the last deferred piece) is complete. The converter now emits + compile-verifies all three Elm layers (`toElmCem` → `M3e.Cem.*` middle, `M3e.Cem.Html.*` bottom) with **43/43/43 parity** under an all-or-nothing invariant, so the docs-site API toggle offers all four layers **Top / Middle / Bottom / HTML** and is never partial. Key realization (the user's, verified): the layers are nested-permissive supersets (`HTML⊇Cem.Html⊇Cem⊇M3e`), so if a composition compiles at strict top it's representable at every layer below — a mid/bottom non-compile is a converter bug, not a "layer unavailable" state. The one real bug: a slotted PLAIN-html child carries its slot as a raw `Html.Attributes.attribute "slot"` even at middle (`M3e.Cem.Attr.slot` only fits an m3e element's typed attr list). Constructor = decapitalize(module), NOT camel. Gates: 50 converter unit tests + 126 Chromium tests + full elm-pages build + elm-review, all green. Remaining follow-ups (non-blocking): 17 `List.map [singleton]` Simplify findings in `elm-cem/codegen/Generate.elm`; 2 corpus families (Chips/Search) have no route slug (warned, not shipped); coverage 43/106 examples / 27/53 components (levers in `config/examples.skipped.txt`).

This is a comprehensive pickup doc. It assumes zero memory of the session. Read this, then the spec/plans it points to.

---

## 0. Mission (what we're building)

Make the elm-pages docs site (`docs/`) document components the way **matraic's m3e site** (<https://matraic.github.io/m3e>) does — narrative per-component **Usage** pages with live, theme-inheriting previews + code, categorized nav — while keeping the standard Elm API reference and enhancing the (standalone, generic) `elm-cem` generator.

**Design spec (READ FIRST):** `docs/superpowers/specs/2026-07-02-docs-matraic-alignment-design.md`
**Memory:** `~/.claude/projects/-Users-jack-Documents-code-elm-m3e/memory/docs-matraic-alignment-epic.md` (+ `MEMORY.md` index)

The pipeline: mine `m3e-docs/data/examples.json` (raw `<m3e-*>` HTML) → **deterministic converter** → typed `M3e.*` Elm (compile-verified) → into `packages/m3e` doc comments (via generic elm-cem `examples`/`docMeta` config) AND into a docs data file → docs site renders Usage pages.

---

## 1. Repo topology (CRITICAL — three separate git repos)

| Path | Repo | Commit from |
| --- | --- | --- |
| `/Users/jack/Documents/code/elm-m3e` | **elm-m3e** (outer, `github.com/jackhp95/elm-m3e`) | tracks `docs/`, `config/`, `packages/`, `js/`, `review/` |
| `/Users/jack/Documents/code/elm-m3e/elm-cem` | **elm-cem** (nested, own repo, `jackhp95/elm-cem`) | `cd elm-cem && git ...` |
| `/Users/jack/Documents/code/elm-m3e/m3e-docs` | **m3e-docs** (nested, own repo, `jackhp95/m3e-docs`) | `cd m3e-docs && git ...` |

- `elm-cem/` and `m3e-docs/` appear as UNTRACKED dirs to the outer repo — commit their contents from INSIDE them.
- `config/` (incl. `examples.generated.json`, `categories.json`) and `js/` (repo root) → **outer** repo.
- `docs/data/reference.json` is **gitignored** (regenerated on build). `docs/dist/` gitignored.
- All three repos: branch `main`, everything pushed as of this handoff.

**Current HEADs (all pushed):** elm-m3e `<wip Plan3 B1>` (see §4), elm-cem `baf9d54`, m3e-docs `63e86df`.

---

## 2. What's DONE (landed + pushed)

### Plan 1 — generic elm-cem doc capabilities (LANDED)
`elm-cem` gained manifest-agnostic `examples` + `docMeta` config → emitted into generated top-module doc comments as markers:
- `<!-- elm-cem:example title="..." -->` + fenced ```elm block, grouped under `## Examples`/`### <Section>`.
- `<!-- elm-cem:docmeta key=value; ... -->`.
Config surface: `Config`/`decodeConfig` in `elm-cem/codegen/Generate.elm`; emitters `Docs.examplesSection`/`Docs.docMetaMarker` in `elm-cem/codegen/Docs.elm`. Guarded by a non-m3e `wc-button` fixture. Plan doc: `docs/superpowers/plans/2026-07-02-elm-cem-doc-capabilities.md`. Suite: 101 green.

### Plan 2 — deterministic HTML→M3e converter (LANDED + coverage pass)
`m3e-docs/scripts/`: `examples-to-elm.mjs` (orchestrator) + `lib/{naming,oracle,to-elm,sections}.mjs` + `verify-examples.mjs` (compile-harness). Converts raw HTML → typed **top-layer** `M3e.*`, targeting the real API via the CEM+`config/slots.json` oracle. **Every emitted example is compiled against the real `M3e.*` API**; failures are dropped + logged (`config/examples.skipped.txt` — NO silent caps).
- **Result: 43 compile-verified examples across 27 components.** Both gates green (`elm make --docs` + elm-review).
- Config plumbing: `elm-cem/bin/elm-cem.js` now accepts **multiple `--config-from`** (deep-merged) → keeps hand-owned `config/slots.json` separate from generated `config/examples.generated.json`.
- Also fixed a generator Simplify bug (`List.append []` → cleared 48 findings; **17 `List.map [singleton]` remain** — a second `Generate.elm` template spot, non-blocking, in the required-record view emission).
- Plan doc: `docs/superpowers/plans/2026-07-02-examples-converter.md`.

**Key converter facts learned (per-component nuance the golden tests caught):**
- Some `view`s are 2-arg (`Button`); many are **required-record** (`view { ariaLabel = ... } [attrs] [content]` — Checkbox, IconButton) sourced from `config/slots.json`'s `required`.
- IconButton/Heading/Chip have **no `child` helper** — their required single default slot folds into a record `content` field.
- Slot helper `+Slot` bump on attr collision (Button `selected` → `selectedSlot`).
- Enum value → `M3e.Value.<camel(value)>`. Naming rules ported to JS in `m3e-docs/scripts/lib/naming.mjs` (faithful to `elm-cem/codegen/Naming.elm`).

**Coverage levers (in skip log, deferred):** drop `id`/`class`/`style` on m3e tags (done, +some); required-record `label` from slotted child (done for Tree); remaining ~63 skips = slot element-kind mismatches (~31), missing helpers like `Stepper.children` (~12), honest `missing required ariaLabel` (~10).

---

## 3. Plan 3 — docs site rendering (WRITTEN + B1 VALIDATED, rest TODO)

Plan doc: `docs/superpowers/plans/2026-07-02-docs-rendering.md`. **Read it** — this section is the delta/state.

### Confirmed design decisions (from the user)
- **Live preview = raw-HTML upgrade** (NOT compiled Elm modules / static routes). The dynamic `Route/Components/Name_.elm` STAYS.
- **API-layer toggle = ALL 4 layers** (M3e top / M3e.Cem middle / M3e.Cem.Html bottom / raw HTML), modeled on the scheme toggle.

### ✅ B1 DONE & VALIDATED (the linchpin) — see §4 for the commit
Proved the raw-HTML preview works end-to-end via a throwaway route + Playwright (button upgraded, shadow root, theme-inherited, no errors).
**CRITICAL FINDING:** `Html.Attributes.property "innerHTML"` **silently fails under elm-pages hydration** (renders an empty div). The fix (implemented) is a **`<raw-html content="...">` custom element** (`js/raw-html.js`, imported in `docs/index.ts`) that sets its own `innerHTML` in `connectedCallback`. `Doc.rawPreview` renders `<raw-html>`. DO NOT revert to the property approach.

### ⏳ REMAINING Plan 3 work (recommended order)
The **first green, shippable increment** (defers the risky mid/bottom converter):
1. **Phase A2/A3 (top+html data only):** extend `m3e-docs/scripts/examples-to-elm.mjs` to also carry the original raw `html` per example → write `config/examples.rich.json`; new `docs/scripts/build-examples-data.mjs` emits `docs/data/examples.json` = `{ "<slug>": { category, examples:[{title,section,html,top}] } }` (category from `config/categories.json`; wire into `docs/package.json` `build:assets`).
2. **B3 — Usage sections in `Name_.elm`:** read `docs/data/examples.json`; between the overview `<p>` (`:128`) and the `"API"` heading (`:129`) render per-section: `Heading(headline,2)` + per example `Doc.showcase (Doc.rawPreview ex.html)` paired with `Doc.code_ Doc.Elm ex.top`. Change `view app _` → `view app sharedModel` (currently discards Shared). **This consumes `Doc.elm` and turns the elm-review gate GREEN.**
3. **B4 — categorized nav** in `Shared.elm` (`navMenu` `:660`, `componentList` `:697`): group by category (from `config/categories.json`, mirrored as a literal or a Shared BackendTask). Order: Getting Started · Styles · Components (categorized) · Studies · Reference.
4. **B2 — API-layer toggle:** add `apiLayer : ApiLayer` to `Shared.Model` (`:84`) + `SetApiLayer` (`:131`) + `update` (`:260`) + a `segmented` control in `settingsBody` (`:492`) — model on scheme toggle (`SetScheme`, `Ports.storeScheme`). Route reads `sharedModel.apiLayer` to pick which code string to show.

Then the **deferred RISK** — **Phase A1 (mid/bottom layers):** extend `to-elm.mjs` with a `layer` option emitting `M3e.Cem.*` (middle, loose setters + Html children) and `M3e.Cem.Html.*` (bottom) forms, each compile-verified per layer (a layer that won't compile is dropped, top always ships). This is a Plan-2-sized effort with the same per-component surprises. Populate `mid`/`bottom` into the data + toggle. The toggle degrades gracefully to available layers until then.

---

## 4. Uncommitted/WIP state to be aware of

- **elm-m3e HEAD is a `wip(docs): Plan 3 B1` commit** containing `docs/src/Doc.elm`, `js/raw-html.js`, `docs/index.ts`. **The docs elm-review gate is INTENTIONALLY RED on this commit** — `Doc`'s `rawPreview`/`showcase`/`code_` are flagged `NoUnused.*` until B3 consumes them. This is expected; doing B3 greens it. (Verify: `cd docs && node_modules/.bin/elm-review --config ../review --compiler node_modules/.bin/elm` → 7 unused errors in `src/Doc.elm`.)
- **Pre-existing, unrelated:** `scratchpad/__pycache__` + `scratchpad/bin` are local cruft (gitignore-worthy, ignore them).

---

## 5. Commands cheat sheet

```bash
# Regenerate the library (BOTH configs now — note the second --config-from):
cd m3e-docs && node scripts/examples-to-elm.mjs   # regenerate config/examples.generated.json (compile-verified)
cd /Users/jack/Documents/code/elm-m3e && node elm-cem/bin/elm-cem.js \
  --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
  --config-from=config/slots.json --config-from=config/examples.generated.json \
  --output=packages/m3e/src

# Gates:
cd docs && node scripts/extract-reference.mjs && echo REFERENCE_OK   # elm make --docs
cd docs && node_modules/.bin/elm-review --config ../review --compiler node_modules/.bin/elm

# elm-cem tests:
cd elm-cem && node_modules/.bin/elm-test-rs --compiler ../docs/node_modules/.bin/elm --project tests tests/src/*.elm

# converter tests:
cd m3e-docs && node --test scripts/lib/*.test.mjs

# Build docs + browser-validate (the sandbox CANNOT run `elm-pages dev`/`npm start` — 5min webServer timeout).
# Instead: static build + serve dist + Playwright (this worked):
cd docs && npx elm-pages build            # static pre-render to dist/
python3 -m http.server 1239 --directory dist &   # playwright reuseExistingServer picks this up
cd docs && BASE_URL=http://localhost:1239 npx playwright test <spec>   # chromium is installed
```

**elm-format after any .elm edit:** `docs/node_modules/.bin/elm-format --yes <file>`.

---

## 6. Execution method

Both prior plans ran via **superpowers:subagent-driven-development** (fresh subagent per task, controller reviews between). The plans have bite-sized TDD tasks with real code. Golden tests + the compile-harness are the safety net — trust them, and prefer `{skip}`+log over emitting wrong Elm. Work is on `main` in all repos (user-approved). Push all three repos when landing a chunk.

## 7. Open follow-ups (non-blocking, tracked)
- 17 `List.map [singleton]` Simplify findings remain in `elm-cem/codegen/Generate.elm` required-record view emission (second template spot).
- Converter coverage 27/53 components — levers in `config/examples.skipped.txt`.
- `config/categories.json` taxonomy is editorial (7 buckets) — refine as desired.
