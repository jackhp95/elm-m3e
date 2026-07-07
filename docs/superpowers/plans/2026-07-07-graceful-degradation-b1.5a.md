# Graceful Layer Degradation (Stream B1.5a) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Stop dropping an example when only *some* API-surface layers compile. Ship it at whatever surfaces DO compile (HTML always works), and show only the valid surface tabs — recovering all ~97 currently-dropped examples at once.

**Architecture:** Replace the all-or-nothing invariant in `examples-to-elm.mjs` (top AND mid AND bottom must all compile) with per-surface degradation: verify each of top/mid/bottom independently, set each to `code | null`, never drop the example (its `html` surface is always present). Thread the now-nullable `top`/`mid`/`bottom` through the data files, make them `Maybe String` in the Elm `UsageExample`, and make `layersFor` show a tab only when its surface is present (mirroring the existing `record`/`build` optional-tab pattern). Default the selected tab to the first available surface.

**Tech Stack:** Node ESM (`scripts/examples-gen/*.mjs`, `scripts/build-examples-data.mjs`), Elm (elm-pages, `app/Route/Components/Name_.elm`), `node --test`, playwright.

**Spec:** `docs/superpowers/specs/2026-07-07-example-sourcing-and-folding-design.md` (§ B1.5, "Meta-cause / graceful degradation").

**Branch:** continue on `docs/example-sourcing` (B1 lives here; B1.5 bundles with it — do NOT branch or touch main).

**Working directory for all commands:** `/Users/jack/Documents/code/elm-m3e/docs`

---

## Background the implementer needs

- Current drop flow in `examples-to-elm.mjs`: (1) generate top `code` per example; (2) `verifyExamples` → drop top-failures (~line 178-216); (3) Phase A1 (~line 218-278): generate mid+bottom for top-survivors, verify, drop the example if mid OR bottom fails. Net: an example survives only if all three compile.
- The renderer (`app/Route/Components/Name_.elm`): `UsageExample` has `top/mid/bottom : String` (always shown) and `record/build : Maybe String` (tab hidden when `Nothing`). `layersFor` (line 430) hardcodes `("M3e", Top) ::` and always appends Cem/Cem.Html/HTML. `codeFor` (line 481) reads `ex.top` for `Top`, etc. The selected layer per example is stored in `Model.layers : Dict Int Layer`, defaulting to `Top` when absent.
- `html` (the `Raw`/HTML tab) is the source markup string — it never fails to "compile" and always renders a live preview. So the safety net is: every example keeps at least its HTML surface.
- `@m3e/web 2.5.13` (what the site renders) defines every component tag used, so the live previews render even for examples whose Elm surfaces are null.

---

## File Structure

- **Modify** `docs/scripts/examples-gen/examples-to-elm.mjs` — replace all-or-nothing drop with per-surface null-on-failure; keep every example that has HTML; extraction-filter pure-`<script>` examples (they have no useful surface).
- **Modify** `docs/scripts/build-examples-data.mjs` — carry nullable `top`/`mid`/`bottom` into `data/examples.json`.
- **Modify** `docs/app/Route/Components/Name_.elm` — `UsageExample.top/mid/bottom : Maybe String`; decoder; `layersFor` conditional on presence; `codeFor` handles `Maybe`; default selected layer = first available.
- **Regenerate (committed artifacts):** `config/examples.generated.json`, `config/examples.rich.json`, `config/examples.surfaces.json`, `config/examples.barrel.json`, `config/examples.skipped.txt`, `docs/data/examples.json`.

---

## Task 1: Per-surface degradation in the generator

**Files:**
- Modify: `docs/scripts/examples-gen/examples-to-elm.mjs`

- [ ] **Step 1: Filter pure-`<script>` examples at their source**

These "Native module support" cards are just `<script type="module" src="…/dist/X.js">` — no useful surface. In the extraction/conversion loop where each candidate example is built (around line 140-168, where `rawHtml` is known), skip a candidate whose top-level non-whitespace nodes are ALL `<script>` or `<link>`. Reuse the existing `topLevelNodes(htmlString)` helper (defined ~line 59):

```js
// Skip registration-only cards (e.g. "Native module support"): all top-level
// nodes are <script>/<link>. They have no meaningful preview or Elm surface.
const tops = topLevelNodes(rawHtml);
if (tops.length > 0 && tops.every((n) => n.nodeType === 1 && /^(script|link)$/i.test(n.tagName))) {
  // record + skip, do not push as an example
  skippedLines.push(`${module} :: ${title} :: filtered: registration-only (script/link)`);
  continue;
}
```

(Place this guard before the `examples.push({ title, code: res.code, … })` for that candidate. `module`, `title`, `skippedLines` are in scope in that loop.)

- [ ] **Step 2: Replace the all-or-nothing drop with per-surface null-on-failure**

Rework the verification region so NO example is dropped for a layer failure; instead the failing layer's field becomes `null`. Concretely:

1. Keep generating `code` (top) per example as today, and keep `html`.
2. **Do not** drop top-failures. Instead, after the top `verifyExamples`, for each top-failure set that example's `top` field to `null` (keep the example) and log `degraded: top: <reason>` instead of `compile:` (dropping).
3. In Phase A1, generate `mid`/`bottom` for **every** example (not just top-survivors), verify each layer, and set `mid`/`bottom` to `null` on failure (log `degraded: mid|bottom: <reason>`), instead of dropping.
4. Rename the internal `code` field carried for top to an explicit `top` on the example record (or keep `code` but also emit `top`), so the rich/data layer has a uniform `{ top, mid, bottom, html, record?, build? }` shape with `top/mid/bottom` each `string | null`.
5. An example is dropped ONLY if it has NO surface at all — which cannot happen because `html` is always present. (Keep a defensive drop if `html` is empty, logged as `dropped: no surface`.)

Preserve the existing skip-logging to `config/examples.skipped.txt`, but distinguish `degraded:` (surface nulled, example kept) from `filtered:`/`dropped:` (example removed). Update the final summary counts accordingly (e.g. `converted`, and a new `degraded` tally).

Note the `layerFailures` shadow-map machinery (line 235-256) already maps a layer's failures to `(module, idx)` — reuse it; just change the CONSEQUENCE from "drop the example" to "null that field."

- [ ] **Step 3: Run the generator and confirm no wholesale drops**

Run: `npm run build:examples-config`
Expected: completes; the log shows a `degraded` count > 0 and a much lower `dropped` count (ideally 0 real drops). `config/examples.skipped.txt` is now dominated by `degraded:` lines, not `compile:`/`layer` drops.

- [ ] **Step 4: Verify the generated shape carries nullable surfaces**

Run:
```bash
node -e "const g=require('./config/examples.rich.json'); const t=g.tabs?.examples?.find(e=>/Basic usage/.test(e.title))||Object.values(g).flatMap(m=>m.examples).find(e=>e.top===null); console.log('example with null top exists:', !!t); console.log(t && {title:t.title, top:t.top===null?'NULL':'ok', mid:t.mid===null?'NULL':'ok', bottom:t.bottom===null?'NULL':'ok', html: !!t.html})"
```
Expected: at least one example has `top: NULL` (e.g. a Tabs example) while `bottom`/`html` are present — proof degradation kept it.

- [ ] **Step 5: Commit**

```bash
git add scripts/examples-gen/examples-to-elm.mjs config/examples.generated.json config/examples.rich.json config/examples.skipped.txt
git commit -m "feat(docs): degrade examples per-surface instead of all-or-nothing drop

An example now ships if ANY surface compiles (HTML always does); each of
top/mid/bottom becomes null when that layer fails, rather than dropping the
whole example. Registration-only <script> cards filtered at extraction."
```

---

## Task 2: Carry nullable surfaces through the data assembly

**Files:**
- Modify: `docs/scripts/build-examples-data.mjs`
- Regenerate: `config/examples.surfaces.json`, `config/examples.barrel.json`, `docs/data/examples.json`

- [ ] **Step 1: Thread nullable top/mid/bottom into `data/examples.json`**

Read `build-examples-data.mjs`. Wherever it maps a rich example into the final `data/examples.json` shape, ensure `top`, `mid`, `bottom` are emitted as `null` when absent (not defaulted to a string, not omitted-as-required). They must serialize as JSON `null` so the Elm decoder can read them as `Nothing`. `record`/`build` already follow this pattern — mirror it for the three formerly-required fields.

- [ ] **Step 2: Regenerate the surfaces, barrel, and final data**

Run: `npm run build:examples-surfaces && npm run build:examples-barrel && npm run build:examples`
Expected: each completes. Then confirm the final data has nullable surfaces:
```bash
node -e "const e=require('./data/examples.json'); const all=Object.values(e).flatMap(v=>v.examples||v); const nulls=all.filter(x=>x.top===null); console.log('total examples:', all.length, '| with null top:', nulls.length); console.log('sample null-top example:', nulls[0]&&nulls[0].title)"
```
Expected: `total examples` **exceeds 265** (the pre-B1 baseline — degradation recovers the ~97), and `with null top` > 0.

- [ ] **Step 3: Commit**

```bash
git add scripts/build-examples-data.mjs config/examples.surfaces.json config/examples.barrel.json data/examples.json
git commit -m "feat(docs): carry nullable top/mid/bottom surfaces into examples.json"
```

---

## Task 3: Renderer shows only valid surface tabs

**Files:**
- Modify: `docs/app/Route/Components/Name_.elm`

- [ ] **Step 1: Make `top`/`mid`/`bottom` optional in `UsageExample` + decoder**

Change the `UsageExample` type alias (line 101-110): `top`, `mid`, `bottom` become `Maybe String` (matching `record`/`build`). Update the JSON decoder for `UsageExample` (find it in this file — it decodes these fields; `record`/`build` already use a nullable/optional decoder) so `top`/`mid`/`bottom` decode with the same nullable combinator. Update the doc comment (line 95-99) to say all Elm surfaces are optional and the UI hides absent tabs; `html` is always present.

- [ ] **Step 2: Make `layersFor` conditional on surface presence**

Rewrite `layersFor` (line 430-449) so M3e/M3e.Cem/M3e.Cem.Html each appear only when their field is `Just`, using the existing `optional` helper, while `HTML` (Raw) is ALWAYS appended (it's the guaranteed surface):

```elm
layersFor : UsageExample -> List ( String, Layer )
layersFor ex =
    let
        optional : Maybe String -> String -> Layer -> List ( String, Layer )
        optional field label layer =
            case field of
                Just _ ->
                    [ ( label, layer ) ]

                Nothing ->
                    []
    in
    optional ex.top "M3e" Top
        ++ optional ex.record "M3e.Record" Record
        ++ optional ex.build "M3e.Build" Build
        ++ optional ex.mid "M3e.Cem" Middle
        ++ optional ex.bottom "M3e.Cem.Html" Bottom
        ++ [ ( "HTML", Raw ) ]
```

- [ ] **Step 3: `codeFor` handles the now-optional surfaces**

Update `codeFor` (line 481-510): for `Top`, `Middle`, `Bottom`, the field is now `Maybe String`. Since `layersFor` never offers a tab whose field is `Nothing`, these are only reached when `Just`, but the types must compile. Fall back to the always-present `ex.html` (rendered as XML) if somehow `Nothing`:

```elm
        Top ->
            case ex.top of
                Just code -> Doc.code_ Doc.Elm code
                Nothing -> Doc.code_ Doc.Xml ex.html

        Middle ->
            case ex.mid of
                Just code -> Doc.code_ Doc.Elm code
                Nothing -> Doc.code_ Doc.Xml ex.html

        Bottom ->
            case ex.bottom of
                Just code -> Doc.code_ Doc.Elm code
                Nothing -> Doc.code_ Doc.Xml ex.html
```

(Leave `Record`/`Build`/`Raw` as they are.)

- [ ] **Step 4: Default the selected layer to the first available surface**

Find where the current layer is resolved for rendering (a `Dict.get index model.layers |> Maybe.withDefault Top`). Replace the `Top` default with the first layer offered by `layersFor ex`:

```elm
defaultLayerFor : UsageExample -> Layer
defaultLayerFor ex =
    layersFor ex |> List.head |> Maybe.map Tuple.second |> Maybe.withDefault Raw
```

and use `Maybe.withDefault (defaultLayerFor ex)` at the resolution site (there may be more than one — search for `Maybe.withDefault Top`). This ensures an example whose `top` is `Nothing` opens on its first real tab, not a blank Top.

- [ ] **Step 5: Format and compile-check**

Run: `node_modules/.bin/elm-format --yes app/Route/Components/Name_.elm && npm run gen`
Expected: format clean; `npm run gen` (elm-pages gen) reports OK — the Elm compiles.

- [ ] **Step 6: Commit**

```bash
git add app/Route/Components/Name_.elm
git commit -m "feat(docs): render only the API-surface tabs that compiled

top/mid/bottom are now Maybe; layersFor hides absent Elm surfaces while HTML is
always shown; selected tab defaults to the first available surface."
```

---

## Task 4: Playwright — verify recovery + partial toggles work

**Files:**
- Create (temporary, scratchpad, not committed): a playwright verification script.

- [ ] **Step 1: Build dist and serve**

Run:
```bash
pkill -f "serve-dist.mjs" 2>/dev/null
npm run build
node scripts/serve-dist.mjs dist 1239 &
```
Expected: `build:ci`-style success; server on :1239.

- [ ] **Step 2: Verify a composite page recovered with a (partial) toggle**

Write a scratch script under `/private/tmp/claude-501/-Users-jack-Documents-code-elm-m3e/31058183-3334-4604-b4dd-5d33fdba2c1d/scratchpad/verify-degrade.mjs` (import chromium from the resolved `@playwright/test` path used in the B1 plan). Load `http://localhost:1239/components/tabs`, wait 1500ms, and assert:
- There is ≥1 Usage example rendered (a live `<m3e-tabs>` in a preview), i.e. the Tabs examples were NOT dropped.
- At least one example's surface-tab strip is present and its labels are a SUBSET of `["M3e","M3e.Cem","M3e.Cem.Html","HTML"]` including `"HTML"` (a partial toggle is acceptable and expected pre-B1.5c).
- Screenshot to the scratchpad.

Report the tab labels found. Expected: Tabs page shows examples (recovered) with at least the `HTML` tab; `M3e` may be absent until B1.5c's routing fix.

- [ ] **Step 3: Verify the count exceeds baseline site-wide**

Run:
```bash
node -e "const e=require('./data/examples.json'); const n=Object.values(e).flatMap(v=>v.examples||v).length; console.log('total examples:', n); console.log(n>265?'PASS: exceeds pre-B1 baseline (265)':'FAIL: below baseline')"
```
Expected: `PASS`.

- [ ] **Step 4: Stop the server**

Run: `pkill -f "serve-dist.mjs"`

---

## Final Verification

- [ ] `npm run build:ci` → exit 0, `check-nav: OK`, adapter success.
- [ ] `node_modules/.bin/elm-format --validate app src` → `[]`.
- [ ] `data/examples.json` total example count **> 265** (pre-B1 baseline) — degradation recovered the drops.
- [ ] `config/examples.skipped.txt` no longer *drops* examples for layer/compile reasons — those become `degraded:` (kept) lines; only registration-only `filtered:` and any genuine `dropped: no surface` remain.
- [ ] Playwright: `/components/tabs` (and one more composite, e.g. `/components/stepper`) render their examples with at least the HTML tab; no composite page is empty.
- [ ] `npm run test:examples-gen` and `node --test scripts/examples-gen/extract-matraic-examples.test.mjs` still pass.
