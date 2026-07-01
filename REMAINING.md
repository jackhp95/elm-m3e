> ⚠️ **STALE — predates the component-agnostic/Vocab redesign and the adoption.** The
> "ALL GENERATOR MECHANISMS DONE / 125/125" framing below describes an *earlier* finish
> line. Since then: the library was adopted into `packages/m3e/` (double-list), then the
> **Vocab redesign** started (not finished) with a **known `M3e.Attr` bug**, and the docs
> migration hasn't run. **For the current state + next steps, read `HANDOFF.md`** and
> `docs/COMPONENT_AGNOSTIC_API.md` §9b. Kept below for historical context only.

# Remaining work — elm-cem retarget

State after the autonomous session of 2026-06-30. What's **done** is a verified
proof-of-pipeline; what's **below** is the bulk of the full retarget. Ordered
roughly by dependency. Tracked against elm-cem#1 / elm-m3e#71.

## Done (the partial-application retarget — verified, whole library 125/125)
The generator now emits the locked three-layer partial-application model
([THREE_LAYER_PATTERN.md](THREE_LAYER_PATTERN.md)) for every component:
- **Bottom** (`<Lib>.Cem.Html.*`) — partial-applied elm/html (point-free element + attrs).
- **Middle** (`<Lib>.Cem.*`) — capability-typed `Attr` setters reusing the bottom; `Value`-typed
  enum setters; eager component.
- **Top** (`<Lib>.*`) — lazy IR `view`; aliased setters; phantom kind-row result.
- **`Value` vocabulary** (`<Lib>.Value`) — ~140 manifest-wide tokens over a hand `Value.Core`.
- **Config** (`--config-from`) — typed-slot children (closed kind-row); config-free path generic.
- **All three phantom dimensions enforced + verified** against generated output (positive +
  negatives): `Value` (wrong value ✗), capability (foreign attr ✗), element-kind (wrong child ✗).
- Whole library compiles 125/125 (config-free and config-driven).
- Commits: elm-cem `aa0e4af`(bottom) `568b56d`(middle+top) `2caa42f`(Value) `496879e`(config);
  elm-m3e `baed195`/`f6e7d62` (snapshot + config). *(M1/M2 superseded.)*

## Remaining (largest → smallest, with the relevant issue)

### Also DONE since (this session, continued)
- **Config support** (`--config-from`, single JSON file) — typed-slot children (3rd phantom row),
  config-free path preserved. *(elm-cem `496879e`)*
- **Core generation** (resolves F7) — IR core emitted verbatim from `runtime/` templates via the
  transparent `Elm.File` record; output 100% generated, 125/125. *(`619091e`)*
- **Events (R9 generic form)** — `onX : Decoder msg -> Attr {c|onX} msg` across all layers; event
  caps in the closed row. *(`f3216ad`)*
- **Required content + a11y** — config `required` (content ⇒ `Element` child; ariaLabel ⇒ required
  `String` → `aria-label`); top `view` gains a `{required}` record. *(`a2ef94d`)*

### Also DONE (continued further)
- **Typed events** — derived from the controlled property (checked→Bool, value→String), no config.
- **Menu/FabMenu typed containers** — via typed-slot config; **key finding (F17): container+items do
  NOT fold** (items are reused, e.g. menu-item ∈ menu & fab-menu), so it's config, not new code.
- **Naming fix (F18)** — `decapitalize` (pascal→camel) so multi-word fns/kinds are `menuItem`.

### ALL GENERATOR MECHANISMS NOW DONE
- ✅ **Variant-split folding** — `config.group` folds member tags into one module (Progress
  `linear`/`circular`; standalone tops folded). Add more via config (e.g. Fab/ExtendedFab).
- ✅ **`Action` integration** — `required` kind `action:click,link` ⇒ an `Action` field; the
  overlapping `onClick`/`href` are suppressed. (AssistChip authored.)

### The ONLY remaining work: config-authoring COVERAGE (for your review)
The generator is complete. `config/slots.json` covers ~28 components (containers, a11y, action,
required content, the Progress group), all evidence-based from `@m3e/web`. The other ~96 are at
safe defaults (free child row, no required) — still compile. Extending them (child kinds, required
content, a11y, groups) is domain authoring, per-component. **This is the part you said you'd review.**

### Remaining — Generator (elm-cem) [original list, mostly superseded above]
1. **Enum → `Value` vocabulary (R3, net-new — elm-cem#5).** Today enums fall back to per-attr
   unions (middle) or `String` (top, when alias-inlining is skipped). Build the shared phantom
   `Value` token vocab + closed supported-rows; wire top-layer enum setters to it. *Biggest item.*
2. **Config decoder + `--config-from` (F3, net-new — part of #1/#6).** `bin/elm-cem.js` must merge
   a `slots.json`+`overrides` JSON into the flags; `Generate.main` must decode `{manifest, config}`.
   Nothing config-driven works until this lands.
3. **Typed slots / children (R4 — elm-cem#6).** Top-layer `view` currently takes a free-row
   `List (Element child msg)`. Emit closed-row slot aliases from `slots.json`; wrap modes (R8).
4. **Events (elm-cem#9).** Top layer emits no `onX` yet — port the middle-layer event helper to
   return `Node.on`-based options + R9 typed-payload decoders.
5. **Required content / a11y / required-id (R6 — elm-cem#11).** `view` required-record fields;
   `Action` value (R5); the form-field `id` wiring.
6. **R5 groups, R7 optionality, R11 text-resolver, R12 typed-args, R13 curation, R-EXTRA.**
7. **Core generation (ADR 8 c1).** Emit `Node`/`Element`/`Internal`/`Attr`/`Action`/native-HTML
   instead of importing elm-m3e's hand core (the F7 deviation).
8. **Upstream hygiene:** fix the broken `elm-test-rs` devDep (F6); route runs through
   `bin/elm-cem.js` so alias-inlining happens (F10).

### This repo (elm-m3e)
9. **Author the m3e config** (slots.json + overrides) — blocked on (2). (#72)
10. **Integration checkpoint** Button/Card/Slider/TextField via config, golden-matched to the
    hand `src/M3e/*`. (#73)
11. **Fan-out** all ~74 (#74); **docs/examples refactor** (#75, intentionally untouched — for the
    local-LLM refactor agent); **regen-on-release pipeline + delete clone** (#76).

### Config-free other libraries (the "SHOULD")
12. Generate `elm-fluent-ui` / `elm-calcite` / `elm-web-awesome` / `elm-warp` / `elm-shoelace`
    config-free (lower layers). Needs each library's `custom-elements.json` (npm-shipped or via
    `cem analyze` on source). Not attempted this session beyond confirming the pipeline is
    config-free by construction (M1/M2 take no config).

## How to resume the harness
- elm-codegen installed standalone at `scratchpad/ecg`; run:
  `PATH=…/elm-m3e/node_modules/.bin:…/scratchpad/ecg/node_modules/.bin:$PATH \
   elm-codegen run codegen/Generate.elm --flags-from=<cem> --output=<dir>` from `elm-cem/`.
- Compile generated **lower** layers: drop into `vendor/elm-m3e/M3e/…`, `elm make`.
- Compile generated **top** layer: isolated project with `src/M3e/{Node,Element,Internal}.elm`
  + the generated module (avoids the hand-`M3e.Button` clash), reuse elm-m3e's elm.json deps.
- m3e CEM: `docs/node_modules/@m3e/web/dist/custom-elements.json`.
