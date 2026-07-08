# Bidirectionality Fixes — Consolidated Plan

**Date:** 2026-07-08
**Status:** Planning — for parallel agent delegation
**Origin:** round-trip harness findings (748/1059 clean/deviating; 167 unconverted). See `docs/data/roundtrip-report.json`, memory `roundtrip-harness-epic`.

## Goal

Raise the round-trip fidelity of the docs example corpus by (a) making the diagnostic honest (diff tuning), (b) fixing the real generator/converter defects it exposed, and (c) closing the coverage gaps. Organized into **independent workstreams across 3 repos** so they can be authored in parallel, then integrated in one regen pass.

## Repos & the regen dependency chain (why integration is sequential)

- **elm-cem** (`./elm-cem`, PRIVATE, Elm+elm-codegen generator) — generates the library modules `M3e.*`, `M3e.Cem.*`, `M3e.Cem.Html.*` INCLUDING the barrel `M3e.elm`.
- **elm-review-cem** (sibling clone, PUBLIC) — the `Cem.PreferBarrel` rule that `gen-barrel` runs.
- **elm-m3e** (`.`, docs + library output) — the converter (`docs/scripts/examples-gen/`), the harness (`docs/scripts/roundtrip/`), and the committed generated library + example data.

**Build/regen order** (the integration pass): elm-cem change → **regen library** (`node elm-cem/bin/elm-cem.js … --output=packages/m3e/src`) → converter change → **regen examples** (`cd docs && npm run build:assets`, 2-pass per the reproducibility loop) → elm-review-cem change is consumed by **regen barrel** (part of `build:assets`) → **regen report** (`npm run verify:roundtrip -- --render`). Code authoring is parallel; this chain is sequential and shared.

---

## WS1 — elm-cem: property→attribute + universal HTML attrs  (repo: elm-cem)

Covers threads **#1** and **#2**. Pure elm-cem codegen/runtime; no elm-m3e edits until integration regen.

### WS1a — property→attribute for reflected scalars (thread #1)
- **Defect:** `codegen/Generate.elm:3302-3377` `bottomScalarAttr` emits `Html.Attributes.property <fieldName>` (camelCase) whenever the CEM attribute carries a `fieldName` (`Attr.elm:101` `reactiveProp = attribute.fieldName`). Affects bool/number/int only (strings/enums already emit kebab `attribute`). This breaks SSR faithfulness and the "M3e.Cem.Html *is* the HTML" contract, and produces the paired `disabled-interactive`↔`disabledInteractive` (48), `strong-focus`↔`strongFocus` (42), `case-sensitive`↔`caseSensitive` round-trip deviations (~330 total).
- **Fix:** in the `Just prop` branch, emit `Html.Attributes.attribute s.htmlName <serialized>` instead of `property`. Every spec reaching `bottomScalarAttr` already carries the kebab `s.htmlName` (sourced from CEM `attributes[].name`), so this is safe. Serialization: bool → presence (`attribute name ""` when true, else nothing — mirror the existing `Nothing` branch's `ifThen`); number/int → `attribute name (String.fromFloat/Int v)` (same as the current `Nothing`-branch fallbacks).
- **#33 guard (MANDATORY):** do NOT touch the `Nothing → attribute` branch — that IS the fix for elm-cem issue #33 (aria-*/hyphenated attrs without a backing property). Our change is confined to `Just prop`.
- **Property-only escape hatch:** if any member is genuinely property-only (observed as a JS property, no attribute — detect via CEM member `reflects: false` AND absence from `attributes[]`), keep `property` for it. In practice `bottomScalarAttr` only sees `attributes[]` entries, so all have an observed attribute; still, consult member-level `reflects`/`attribute` (decoded but unused today, `Cem.elm:133-134`) to be principled.
- **Config knob (thread #1 "update config"):** add a per-component/per-attribute override to `componentDecoder` (`Generate.elm:596-613`), e.g. `attrForm: { "<attr>": "attribute" | "property" }`, carried onto `Attr.AttrSpec` (`Attr.elm:62-78`) and consulted in `bottomScalarAttr`. Default = manifest-driven (attribute when observed). This is the escape hatch for the rare case where property-setting is genuinely wanted.
- **Verification:** golden/generation tests in `elm-cem/tests/src/` (add a case asserting a reflected bool emits `attribute "disabled-interactive"`). `npm test` in elm-cem green. Impact confirmed at integration: the ~330 paired deviations flip to matches, and bottom-surface match rate jumps.
- **Open decision D1:** default behavior — always kebab-attribute for observed attrs (simplest, most faithful) vs only when `reflects: true`. Recommendation: **kebab-attribute for all observed scalar attrs**, config override for exceptions.

### WS1b — universal `id`/`for`/`class`/`style` setters (thread #2)
- **Gap:** `id`/`for` only via the narrow `idWiring` slot mechanism; `class`/`style` unmodeled. The converter can't set them, so they're dropped (id 636, for 174 in the report — many cosmetic, but `for`/functional `id` matter).
- **Fix (mirror the Aria precedent exactly):** Aria is universal via hand-written runtime modules with an **open `capability` type variable** (`elm-cem/runtime/M3e/Aria.elm` middle/top, `runtime/M3e/Cem/Html/Aria.elm` bottom), re-exported at the barrel via `ariaUniversals` (`Generate.elm:6331-6353`). Add universal `id`, `for` (Elm `htmlFor`), and optionally `class`/`style` setters the same way — pure universal HTML truth, no CEM data. Add them to the `ariaUniversals` re-export list (or a sibling `htmlUniversals` list).
- **CONFIRMED (D2): expose all four — `id`, `for`, `class`, `style`.** Signatures:
  - `id : String -> Attr …` (bottom: `Html.Attributes.attribute "id"`), `for : String -> Attr …` (`"for"` / `Html.Attributes.for`).
  - `class : String -> Attr …` (space-separated; `Html.Attributes.attribute "class"`). (A `classList : List (String, Bool)` variant is a nice-to-have, not required.)
  - **`style : List (String, String) -> Attr …`** — Elm-0.18-style list of (CSS-property, value) pairs. **Emit a single plain `style` attribute string**: `Html.Attributes.attribute "style" (String.join "; " (List.map (\( k, v ) -> k ++ ": " ++ v) pairs))`. Rationale (from the user): the built-in single-property `Html.Attributes.style` is awkward/unreliable for **CSS custom properties** (`--var`); a plain `style="--var: val; color: red"` attribute carries custom properties correctly AND round-trips as a `style` attribute. Do NOT emit per-property `Html.Attributes.style` calls or a `property`.
- **Config:** still make the universal set config-listable (`universalAttrs`), but default = all four ON.
- **Verification:** elm-cem tests; at integration, the converter (WS3d) can then emit these and `for`/functional-`id`/`style` deviations drop. Note `class`/`style` remain *cosmetic in the diff* (WS4) — being settable and being diff-cosmetic aren't in tension: you can set them, the round-trip score just doesn't penalize their absence.

**WS1 parallelism:** WS1a and WS1b are different code areas in elm-cem; one agent can do both sequentially, or two agents in elm-cem worktrees. Both must land before the library regen.

---

## WS2 — elm-review-cem + barrel exposure: close barrel gaps  (repos: elm-cem barrel exposure + elm-review-cem)

Covers the **barrel gaps** (99 nulls). NOT a component API hole — three sub-causes (`gen-barrel`/`PreferBarrel` limits):

- **C1 — generalized slot names not re-exposed (biggest: all Autocomplete/FormField/Stepper).** `PreferBarrel.slotBarrelName` (`elm-review-cem/src/Cem/PreferBarrel.elm:304-311`) rewrites per-component `.control`/default helpers to generalized names (`slotDefault`, `control`) that `M3e.elm` (barrel) does NOT export (`defs=0`), so bindings fail to compile → null. **Fix:** re-expose the generalized `slotDefault`/`control` (and `child`/`children`) in the barrel — this is an **elm-cem** change (the barrel `M3e.elm` is generated; adjust what `Generate.elm` re-exports at the barrel), OR make `slotBarrelName` emit the component-specific `<comp>SlotDefault` name that IS exposed. Decide which in D3.
- **C2 — `.value`/`.name` left qualified (Slider/SplitPane/Datepicker).** `PreferBarrel` intentionally leaves `.value`/`.name`/`.child`/`.children` qualified (gen-barrel header, `PreferBarrel` logic), so a barrelised `M3e.slider` constructor mixed with a per-component `M3e.Slider.value` Attr fails to typecheck → null. **Fix options:** expose `value`/`name` at the barrel too, OR teach `PreferBarrel` to rewrite them, OR accept and mark cleanly-skipped (with a reason) rather than silent null.
- **C3 — variant-group constructors never rewritten (all ProgressIndicator).** `PreferBarrel.barrelReplacement` (`PreferBarrel.elm:249-265`) rewrites the constructor only when `name == "view"`; variant-group constructors (`M3e.Progress.circular`) aren't `view` and `circular`/`linear` have barrel `defs=0` → no edit → null. **Fix:** teach `PreferBarrel` to rewrite variant-group constructors, and expose them at the barrel.
- **Also:** `gen-barrel.mjs` silently falls back to null per-component (only a corpus-wide-zero FATAL guard). **Add per-component logging** of why a cell stayed null (fallback-didn't-compile vs unchanged) so future gaps aren't silent.
- **Verification:** `elm-review-cem` tests (pinned runner `npx -y elm-test@0.19.1-revision12 --compiler docs/node_modules/.bin/elm`) green; at integration, barrel regen fills the previously-null cells.
- **CONFIRMED (D3): close all three (C1 + C2 + C3).** C1 → expose generalized `slotDefault`/`control`/`child`/`children` at the barrel. C3 → teach `PreferBarrel` to rewrite variant-group constructors + expose `circular`/`linear`/etc. at the barrel. C2 → expose `.value`/`.name` at the barrel AND teach `PreferBarrel` to rewrite them, resolving the barrel-Element + qualified-Attr type tension (verify the rewritten bindings actually typecheck; if a specific mix genuinely can't, fall back to logged-skip for just those cells, not silent null).

**WS2 parallelism:** independent of WS1/WS3/WS4 at authoring time. The elm-cem barrel-exposure part could merge into WS1 (same repo) if one agent takes all elm-cem work. Barrel regen (integration) needs WS1 + WS2 + WS3 landed.

---

## WS3 — converter: typos, child-order, attribute capture  (repo: elm-m3e/docs)

Covers **top-layer typos**, **#3**, and the converter side of **#2**. All in `docs/scripts/examples-gen/`.

- **WS3a — `type`→`type_` keyword escaping (A1).** `oracle.mjs:133` `const setter = camel(htmlName)` never applies Elm keyword escaping. Port `elm-cem/codegen/Generate.elm:3142-3144`'s `elmKeywords` list + `safeField` (`+"_"`) into `naming.mjs` and apply at `oracle.mjs:133`. Fixes Checkbox "Required" (fails all surfaces today) + any `type`/`port`/etc. attr. **Code.**
- **WS3b — `extended`→`expanded` + enum validation (A2).** Corpus HTML `mode="extended"` (`examples.rich.json:1483` region; source corpus) is INVALID per the CEM (`NavBarMode = auto|compact|expanded`). Converter emits `M3e.Value.extended` (nonexistent) via bare `camel(value)` at `to-elm.mjs:332-334` → top fails. **Fix (both):** (1) correct the corpus source value to `expanded`; (2) wire up the collected-but-unused `oracle.enumValues` (`oracle.mjs:158-164`) to **validate** the HTML value against the real token set in `to-elm.mjs:332-334` — drop/flag with a clear reason instead of silently emitting a bad token. **Code + data.**
- **WS3c — preserve DOM child order (#3, the routing swaps).** `to-elm.mjs:437-441` builds children as `requiredSlotExprs ++ slottedExprs ++ defaultElementExprs`, discarding document order (tab/panel, bottom-sheet-action/span swaps). **Fix:** interleave slotted + default children in original DOM position within the children loop (`to-elm.mjs:356-441`) — keep required-slot hoisting if the API needs it, but emit non-required children in source order. **Code.**
- **WS3d — attribute capture on native/component elements (thread #2 converter side).** Functional attrs dropped: `value`/`placeholder`/`type`/`src` on `Native.node Html.input/img` (converter emits bare `Native.node ... []`), and some component attrs (`filter`, `detents`, `density`, `required`) the converter doesn't map. **Fix:** (1) carry HTML attributes onto `Native.node` emissions; (2) for component attrs, ensure the oracle/`to-elm` maps all CEM attributes (triage each: is there a library setter? if yes → converter must emit it; if no → it's a WS1/elm-cem setter gap, escalate). Depends on WS1b for `id`/`for` universals. **Code (converter) + possible escalation to WS1.**
- **Verification:** after each, regen examples (2-pass) and check the specific cells convert + round-trip; `build:ci` green; elm-review green; the browser + roundtrip tests green.
- **Open decision D4:** WS3b — fix the corpus value in place, or treat `extended` as an alias→`expanded`? Recommendation: **fix the corpus (it's simply wrong) AND add validation** so future bad values fail loudly.

**WS3 parallelism:** sub-tasks touch different functions (`oracle.mjs:133`, `to-elm.mjs:332`, `:437`, native-node handling) — low conflict, but all regenerate `examples.rich.json`. Best as ONE agent doing 3a→3b→3c→3d sequentially (shared output), or parallel worktrees merged before a single regen. 3d partly depends on WS1b (universals).

---

## WS4 — diff tuning + role/slot normalization  (repo: elm-m3e/docs)

Covers **diff-tuning** and **#4**. Fully independent — changes only how the harness *measures*, not any surface. **Can land first** and re-baseline immediately.

- **Classify deviations `cosmetic` vs `functional`** in `docs/scripts/roundtrip/dom-diff.mjs`: tag each deviation with `cosmetic: true` when it's `class`/`style` on any element (~2,202 diffs), or `id` on an element NOT referenced by a `for`/`aria-*`/`headers`/`list` on the page (detect references by scanning the other side's attribute values for the id). Everything else = functional.
- **#4 normalization:** treat typed-layer-*added* `role` and `slot` as `cosmetic`/acceptable by default (the typed API making an implied ARIA role / slot placement explicit — confirmed on `m3e-form-field role="group"`, `m3e-drawer-container slot="end"`). Keep them recorded but not counted as functional deviations. (Spot-check a few `slot` adds first to ensure none are genuinely *wrong* placements — if a placement is wrong it's a WS3c routing bug, not normalization.)
- **Report + route:** add `functionalMatches` bool + per-surface functional counts to `roundtrip-report.json`; make `/roundtrip` (`docs/app/Route/Roundtrip.elm`) rank/score on functional deviations; "clean round-trip" = no functional deviations. Keep the full strict record too.
- **Unit tests:** extend `dom-diff.test.mjs` — cosmetic class/style is flagged cosmetic; a referenced id is functional, an unreferenced id is cosmetic; added role/slot is cosmetic.
- **Impact (measured on CURRENT data):** strict 748 → ignore class/style 907 (+159) → +id 1093 (+345) clean cells. After WS1a lands (~330 paired attr deviations flip), functional-clean rises further.
- **Open decision D5:** `id` default — cosmetic-unless-referenced (recommended) vs always-functional. Recommendation: **cosmetic-unless-referenced.**

---

## Integration pass (sequential, after code authoring)

1. Land WS1 (elm-cem) → **regen library** into `packages/m3e/src` (the documented regen command) → `packages/m3e` compiles; commit generated deltas.
2. Land WS2 (elm-review-cem) → publish/point the sibling clone.
3. Land WS3 (converter) → **regen examples** (2-pass reproducibility loop) → **regen barrel** (uses WS2's rule) → commit `config/examples.*.json` + `docs/data/examples.json`.
4. WS4 already landed → **regen report** (`verify:roundtrip -- --render`) → commit `roundtrip-report.json`.
5. Full verification bar: `packages/m3e` compiles, `docs && npm run build:ci` 0, `npm run build` 0, `test:roundtrip` + `test:examples-gen`, elm-review clean (baseline unchanged), Playwright suite, `/roundtrip` renders. Measure the before/after functional-clean rate.

## Parallelization graph

```
Author in parallel:   WS1 (elm-cem)   WS2 (elm-review-cem)   WS3 (converter)   WS4 (diff tuning)
                          |                  |                     |                 |
                          |                  |                     | (3d needs WS1b) | (independent,
                          |                  |                     |                 |  land first)
                          +--------+---------+----------+----------+
                                   v  INTEGRATION (sequential regen chain)
                        regen library → regen examples → regen barrel → regen report → verify
```

- **WS4** is fully independent → land immediately, re-baseline.
- **WS1, WS2, WS3** author in parallel (different repos/files). WS3d has a soft dependency on WS1b (universals) — do WS3a/b/c first, WS3d after WS1b or escalate.
- Within-repo sub-threads (WS1a/b; WS3a–d; WS2 C1/C2/C3) are sequential or worktree-isolated to avoid index races (see memory `worktree-base-gotcha`).

## Open decisions to confirm before delegating

- **D1** (WS1a): default property→attribute for *all* observed scalar attrs, config-override for exceptions? [rec: yes]
- **D2** (WS1b): expose `class`/`style` as universal setters, or `id`/`for` only? [rec: id/for on; class/style config-gated off]
- **D3** (WS2): close barrel gaps via barrel re-exposure of generalized names + variant-group rewrite; skip `.value`/`.name` with a reason for now? [rec: yes]
- **D4** (WS3b): fix corpus `mode="extended"`→`expanded` AND add enum validation? [rec: yes]
- **D5** (WS4): `id` cosmetic-unless-referenced? [rec: yes]

---

## Confirmed decisions (2026-07-08)

- **D1** ✅ property→attribute is the DEFAULT for all observed scalar attrs; per-attr config override for exceptions.
- **D2** ✅ expose `id`/`for`/`class`/`style` universally; `style` takes `List (String,String)` → plain `style` attribute string (CSS-var-safe). All on by default.
- **D3** ✅ close all barrel gaps (C1+C2+C3).
- **D4** ✅ fix corpus `mode="extended"`→`expanded` AND wire up enum-value validation.
- **D5** ✅ `id` cosmetic-unless-referenced in the diff.
- **Kickoff** ✅ land WS4 first (re-baseline), then fan out WS-CEM / WS-RULE / WS-CONV; subagent-driven with two-stage review; I run the integration regen.

## Execution mapping (by repo, to avoid same-repo parallel conflicts)

Workstreams are re-grouped **by repo** so no two parallel agents edit the same repo:

- **WS-CEM** (repo `./elm-cem`, one agent): WS1a (property→attr + config knob) + WS1b (universal id/for/class/style runtime + barrel re-export) + the **barrel-exposure** half of WS2 (expose generalized `slotDefault`/`control`/`child`/`children`, `value`/`name`, and variant-group constructors `circular`/`linear`/… at the barrel `M3e.elm`). Ends: `elm-cem` tests green. Does NOT regen elm-m3e.
- **WS-RULE** (repo elm-review-cem sibling, one agent): the **rule** half of WS2 — teach `Cem.PreferBarrel` to rewrite `.value`/`.name` and variant-group constructors, and align `slotBarrelName` with the barrel names WS-CEM exposes. Ends: elm-review-cem tests green (pinned runner).
- **WS-CONV** (repo elm-m3e/docs, one agent, AFTER WS4 merges): WS3a (type_) + WS3b (expanded + enum validation) + WS3c (DOM child order) + WS3d (attr capture; the `id`/`for`/`class`/`style` emission depends on WS-CEM's universals being available at integration — author the converter to emit them, verified at integration regen).
- **WS4** (repo elm-m3e/docs, one agent, FIRST): diff tuning + role/slot normalization.

### Shared barrel-name CONTRACT (WS-CEM ↔ WS-RULE must agree)
The barrel exposes and `PreferBarrel` rewrites to EXACTLY these names (so rewritten bindings compile):
- generalized slot helpers: `slotDefault`, `control`, `child`, `children`
- scalar setters left qualified today: `value`, `name`
- variant-group constructors: `circular`, `linear` (+ any other non-`view` group constructors PreferBarrel encounters)
Both agents get this contract verbatim; integration (barrel regen) is the proof they agree.

## Integration ownership
The regen chain (library → examples → barrel → report) and the full verification bar are run by the **controller (me)**, not a workstream agent, after WS-CEM/WS-RULE/WS-CONV land and their repo-local tests are green. elm-cem and elm-review-cem changes are committed on branches in their repos; nothing is published/pushed without the user's say-so.
</content>
