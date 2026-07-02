# Docs Site — Live Examples, Layer Toggle & Categorized Nav (Plan 3 of 3)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development to implement task-by-task. Steps use checkbox (`- [ ]`) syntax.

**Goal:** Turn the per-component docs page into a matraic-style **Usage** page: each example shows a **live, theme-inheriting preview** (the raw `<m3e-*>` HTML upgrades automatically) plus its **code** in a chosen API layer, switchable via an **API-layer toggle** (M3e top / M3e.Cem middle / M3e.Cem.Html bottom / raw HTML) modeled on the existing scheme toggle. Group the component nav by **category**. Keep the standard API reference below Usage.

**Architecture:** No compiled example modules, no static route generation, no bundle-bloat — the dynamic `Route/Components/Name_.elm` stays. Live preview = embed the example's raw HTML (`index.ts` already does `import "@m3e/web/all"`, so `<m3e-*>` upgrades in-DOM under the page's `<m3e-theme>`). Code = the verified Elm string in the selected layer, syntax-highlighted. The converter (Plan 2) is extended to emit all three Elm layers + the raw HTML per example; a build step writes `docs/data/examples.json`; the route reads it and renders Usage sections. The toggle is a `Shared.Model` field the route reads (it currently discards `sharedModel` with `_`).

**Tech Stack:** elm-pages v3, `pablohirafuji/elm-syntax-highlight` (already a dep), `@m3e/web/all` (already registered in `index.ts`), the Plan 2 converter (`m3e-docs/scripts/`), `config/categories.json`.

**Plan 3 of 3** (epic: `docs/superpowers/specs/2026-07-02-docs-matraic-alignment-design.md`). Plans 1 (elm-cem examples/docMeta) and 2 (deterministic converter, 43 verified examples / 27 components) are LANDED.

**Decisions carried in (confirmed with user):**
- **Preview = raw-HTML upgrade** (not compiled Elm modules). Preview fidelity rests on the HTML; the Elm was verified-derived from it in Plan 2.
- **Toggle = all 4 layers** (M3e / M3e.Cem / M3e.Cem.Html / raw HTML). Requires the converter to emit mid+bottom Elm (Phase A, the risk).

**Key exploration facts (verified):**
- Example Elm code is ALREADY in `reference.json`'s `overview` (the `## Examples` block isn't stripped by `overview()`), but we will source Usage from a dedicated `docs/data/examples.json` instead (cleaner, carries all layers + html).
- Scheme toggle is a clean `Shared.Model`+`Msg`+`update`+`Ports.storeScheme` pattern (`Shared.elm:84-93,120-131,242-260,506-528`; `Ports.elm:15`; `index.ts:19-40`). The `segmented` helper (`Shared.elm:506-519`) renders a `SegmentedButton`.
- `docs/elm.json` source-dirs include `../packages/m3e/src` + `../packages/m3e-kit/src`, and `app`/`src` (so `Kit`/`Native`/`Layout`/`EscapeHatch` resolve).
- `showcase` (`Styles/Color.elm:113-115`) and `code_`/`Lang` (`GettingStarted/Installation.elm:65-113`) exist but are route-local — lift into a shared module.
- Nav seam: `navMenu` groups (`Shared.elm:655-665`), `componentList` (`:697-751`), `navGroup`/`navLeaf` (`:668-691`). `Shared.data` is `BackendTask.succeed ()` today — making nav data-driven means giving Shared a real `data` task, OR keeping `componentList` a literal and adding a `category` literal beside each entry.

---

## File Structure

| File | Responsibility | Change |
| --- | --- | --- |
| `m3e-docs/scripts/lib/to-elm.mjs` | mapper gains a `layer` option (top/mid/bottom) | Modify |
| `m3e-docs/scripts/examples-to-elm.mjs` | emit `{html, top, mid, bottom}` per verified example | Modify |
| `m3e-docs/scripts/verify-examples.mjs` | compile-verify each layer | Modify |
| `docs/scripts/build-examples-data.mjs` | write `docs/data/examples.json` (merge category) | Create |
| `docs/data/examples.json` | generated Usage data (per component) | Create (generated) |
| `docs/src/Doc.elm` | shared `showcase`, `code_`/`Lang`, `rawPreview` | Create |
| `docs/app/Shared.elm` | `apiLayer` Model/Msg/update/toggle + categorized nav | Modify |
| `docs/app/Ports.elm` + `docs/index.ts` | optional: persist `apiLayer` | Modify |
| `docs/app/Route/Components/Name_.elm` | render Usage sections above API ref | Modify |

**Test/build commands:**
- Converter: `cd m3e-docs && node --test scripts/lib/*.test.mjs` then `node scripts/examples-to-elm.mjs`
- Usage data: `cd docs && node scripts/build-examples-data.mjs`
- Docs build/gate: `cd docs && node scripts/extract-reference.mjs && npx elm-pages build` (or `elm-pages dev` to view); `elm-review` as in Plan 2.

---

## PHASE A — Multi-layer example data (the converter extension; highest risk)

### Task A1: `to-elm.mjs` emits a chosen layer (top/mid/bottom)

**Files:** Modify `m3e-docs/scripts/lib/to-elm.mjs`; extend `to-elm.test.mjs`.

Add a `layer` option to `toElm(html, oracle, { layer = "top" })`. Layer differences (confirm against real modules `packages/m3e/src/M3e/Button.elm`, `M3e/Cem/Button.elm`, `M3e/Cem/Html/Button.elm`):
- **top** (existing): `M3e.Button.view [ setters ] [ contentHelpers ]` — Value tokens, required records, typed slot helpers, `Kit.text`.
- **mid** (`M3e.Cem.*`): `M3e.Cem.Button.button [ M3e.Cem.Button.variant M3e.Value.filled, ... ] [ <Html children> ]` — loose setters (read the module's exposing), children are raw `Html` (nested m3e → `M3e.Cem.<C>.<c> [...] [...]`, text → `Html.text`, slotted child → the child with a `M3e.Cem.Attr` slot attribute or `Html.Attributes.attribute "slot" "..."`). Verify the exact middle-layer constructor + setter names.
- **bottom** (`M3e.Cem.Html.*`): `M3e.Cem.Html.Button.button [ Html.Attributes.attribute "variant" "filled", ... ] [ <Html children> ]` — closest to raw elm/html; attrs via `Html.Attributes`.

Add golden tests for Button + Checkbox at each layer, authoring expected Elm by reading the real per-layer modules. When a layer can't represent an example, `{skip}` for THAT layer only (the example can still ship other layers).

- [ ] Step 1: Write failing per-layer golden tests (Button/Checkbox × top already passes; add mid/bottom). Read the real `M3e.Cem.Button` / `M3e.Cem.Html.Button` exposing + signatures first — the expected strings must match exactly.
- [ ] Step 2: Run — expect FAIL on mid/bottom cases.
- [ ] Step 3: Implement the `layer` branch in `to-elm.mjs` (share the tree walk; vary tag→module prefix, setter forms, and child rendering per layer).
- [ ] Step 4: Run — PASS. Full lib suite green.
- [ ] Step 5: Commit (m3e-docs): `git commit -m "feat(examples): mapper emits top/mid/bottom M3e layers"`.

### Task A2: orchestrator + harness emit & verify all layers

**Files:** Modify `m3e-docs/scripts/examples-to-elm.mjs`, `verify-examples.mjs`.

- Each example record becomes `{ title, section, html, top, mid?, bottom? }` where `html` = the ORIGINAL raw HTML (from `examples.json`), `top` = current verified Elm, `mid`/`bottom` = per-layer Elm (present only if that layer converted AND compiled).
- The compile-harness verifies EACH present layer (wrap each layer's code in the scratch `Verify` module with computed imports; a layer that fails compile is dropped from that example + logged, but the example still ships with its passing layers). An example ships iff `top` compiles (top is the primary); mid/bottom are best-effort.
- `config/examples.generated.json` schema updated accordingly (top stays the elm-cem `examples[].code`; add `html`/`mid`/`bottom` — but NOTE only `top`+`section`+`title` feed elm-cem's doc comments via `config/examples.generated.json`; the extra fields are for the docs data file. To keep the elm-cem config clean, write the RICH per-example data (`html`/`mid`/`bottom`) to a SEPARATE file `config/examples.rich.json` and keep `config/examples.generated.json` as the elm-cem-facing `{examples:[{title,code,section}],docMeta}`.)

- [ ] Step 1: Update the orchestrator to build both files (`examples.generated.json` = elm-cem-facing top-only; `examples.rich.json` = `{Component: [{title,section,html,top,mid,bottom}]}`). Update the harness to verify each layer.
- [ ] Step 2: Run `node scripts/examples-to-elm.mjs`; confirm summary reports per-layer coverage (e.g. `top N, mid M, bottom K compiled`); skip log accounts for every dropped layer/example (no silent caps).
- [ ] Step 3: Commit (m3e-docs script) + (outer repo `config/examples.generated.json` + `config/examples.rich.json` + skip log) — two commits, correct repos.

### Task A3: build `docs/data/examples.json`

**Files:** Create `docs/scripts/build-examples-data.mjs`.

Reads `config/examples.rich.json` (paths derivable via a `REPO` const like `extract-reference.mjs:25`) + `config/categories.json`; emits `docs/data/examples.json` = `{ "<slug>": { category, examples: [{title, section, html, top, mid, bottom}] } }` keyed by component SLUG (lowercase, matching `reference.json` slugs / the `/components/:slug` route). Add it to `docs/package.json` `build:assets` (alongside `build:reference`) so `elm-pages dev`/`build` regenerate it.

- [ ] Step 1: Implement the script; wire into `build:assets`.
- [ ] Step 2: Run `cd docs && node scripts/build-examples-data.mjs`; spot-check `docs/data/examples.json` (button has category "Actions" + a "Variants" section with `html`/`top`/`mid`/`bottom`).
- [ ] Step 3: Commit (outer repo): `docs/scripts/build-examples-data.mjs`, `docs/package.json`, `docs/data/examples.json`.

---

## PHASE B — Docs rendering

### Task B1: shared `Doc.elm` (showcase, code_, rawPreview)

**Files:** Create `docs/src/Doc.elm`.

Lift `showcase` (`Styles/Color.elm:113-115`) and `code_`/`Lang` (`GettingStarted/Installation.elm:65-113`) verbatim into `Doc.elm`, exposing them. Add the LIVE-PREVIEW primitive:
```elm
{-| Render a raw HTML string as live DOM so the embedded <m3e-*> custom elements
upgrade in place (inheriting the page <m3e-theme>). -}
rawPreview : String -> Element { s | html : Supported } msg
```
- [ ] Step 1: **Validate the preview mechanism FIRST** (it's the linchpin). Prototype `rawPreview` two ways and pick what renders: (a) `EscapeHatch.fromHtml (VirtualDom.node "div" [ VirtualDom.property "innerHTML" (Json.Encode.string html) ] [])` — client-side upgrade after hydration; or (b) if an HTML-string→`Html` parser is available/addable (e.g. `hecrj/html-parser`), parse so it SSRs. Run `cd docs && npx elm-pages dev`, open a component page with a hardcoded `rawPreview "<m3e-button variant=\"filled\">Hi</m3e-button>"`, and CONFIRM the button upgrades (has a shadow root / renders styled). Record which approach works; if neither, STOP and report (the whole plan's preview rests on this).
- [ ] Step 2: Implement `Doc.elm` with the working `rawPreview` + lifted `showcase`/`code_`. Update `Installation.elm` to import from `Doc` (remove its local copies) to avoid duplication.
- [ ] Step 3: `elm-review` green; commit.

### Task B2: API-layer toggle in Shared

**Files:** Modify `docs/app/Shared.elm` (+ optionally `Ports.elm`/`index.ts`).

Model exactly on the scheme toggle:
- `type ApiLayer = LayerM3e | LayerCem | LayerHtml | LayerRaw` + `apiLayer : ApiLayer` in `Model` (`Shared.elm:84`), default `LayerM3e`.
- `SetApiLayer ApiLayer` in `Msg` (`:131`); update branch (`:260`) writes it (+ optional `Ports.storeApiLayer`).
- A `segmented [ ("M3e", …, SetApiLayer LayerM3e), ("Cem", …), ("Html", …), ("HTML", …) ]` control added to `settingsBody` (`:492-500`).
- Expose `ApiLayer`, `apiLayer`, and a helper `layerCode : ApiLayer -> {top,mid,bottom,html} -> String` (picks the string) for routes.

- [ ] Step 1: Add the type/field/msg/update/control; `elm make`/`elm-review` green. (Optional persistence port mirrors `storeScheme`.)
- [ ] Step 2: Commit.

### Task B3: Usage sections in `Name_.elm`

**Files:** Modify `docs/app/Route/Components/Name_.elm`.

- Add a BackendTask reading `docs/data/examples.json` (decode to `Dict slug -> {category, examples:[{title,section,html,top,mid,bottom}]}`), merged into the route `Data` (or a second `BackendTask.map2`). Decode gracefully (missing entry ⇒ no Usage section).
- In `view` (`:115-136`), between the overview `<p>` (`:128`) and the `"API"` heading (`:129`), insert Usage sections: for each `section` (group examples by `.section`), a `Heading(headline,2)` + for each example a `showcase (Doc.rawPreview ex.html)` **paired with** `Doc.code_ Elm (Shared.layerCode sharedModel.apiLayer ex)` (use `Doc.code_ NoLang` when the layer is `LayerRaw`). Read `sharedModel` (change `view app _` → `view app sharedModel`).
- Keep the API member list below, unchanged.

- [ ] Step 1: Extend decoders + Data; add Usage rendering; switch `_`→`sharedModel`. `elm make` green.
- [ ] Step 2: `cd docs && npx elm-pages dev` — open `/components/button`: live variants preview renders (theme-inherited), code block shows M3e Elm, and flipping the settings API-layer toggle switches the code (M3e/Cem/Html/HTML). elm-review green.
- [ ] Step 3: Commit.

### Task B4: categorized nav

**Files:** Modify `docs/app/Shared.elm`.

Group `componentList` by category. Simplest without giving Shared a BackendTask: add a `categoryOf : String -> String` lookup (a literal map mirroring `config/categories.json`, or extend `componentList` entries to `(slug, label, category)`), then in `navMenu` (`:660`) replace the single `("grid_view","Components",…)` tuple with **one `navGroup` per category** (category order: Actions, Communication, Containment, Navigation, Selection, Text inputs, Layout & style), each holding its slugs alphabetically. Keep Getting Started / Styles / Studies / Reference as-is; final order: Getting Started · Styles · Components (categorized) · Studies · Reference.

- [ ] Step 1: Implement grouping; `elm make`/`elm-review` green; visually confirm the drawer shows category groups.
- [ ] Step 2: Commit.

---

## Final gate + integration

- [ ] Full build: `cd docs && node scripts/build-examples-data.mjs && node scripts/extract-reference.mjs && npx elm-pages build` succeeds.
- [ ] `elm-review` green (`cd docs && node_modules/.bin/elm-review --config ../review --compiler node_modules/.bin/elm`).
- [ ] Manual: a few component pages (Button, Checkbox, Card, IconButton) show live previews + working 4-layer toggle + categorized nav.
- [ ] Commit any regenerated data; push all repos.

---

## Self-Review

**Spec coverage (design §Layer 3):** renderer/preview (Task B1 rawPreview — raw-HTML upgrade replaces the extractor→module approach per confirmed decision), inline theme-inheriting previews (B1/B3), categorized nav (B4), matraic Usage pages (B3), API-layer toggle (B2, all 4 layers via Phase A). Standard API reference retained (B3 keeps the member list). ✅

**Deviations from the original spec (intentional, user-confirmed):** no `elm-verify-examples`-style renderable modules and no per-component static routes — the `@m3e/web/all` auto-upgrade makes them unnecessary. The "examples can't lie" guarantee still holds for the CODE (compile-verified in Plan 2 + Phase A); the PREVIEW renders the HTML the code was derived from.

**Highest risk:** Phase A (mid/bottom layer conversion) — same class of per-component surprises the top mapper hit; mitigated by per-layer golden tests + the compile-harness (a layer that won't compile is dropped + logged, top always ships). Second risk: B1's `rawPreview` mechanism under elm-pages SSR/hydration — validated FIRST (B1 Step 1) before building on it.

**No silent caps:** every dropped example/layer is logged (`config/examples.skipped.txt`); the toggle only offers layers that shipped.

**Phasing:** Phase B can begin against top+html once A2 emits them, even if mid/bottom lag — the toggle degrades gracefully to available layers.
