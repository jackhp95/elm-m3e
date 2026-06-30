# Remaining work — elm-cem retarget

State after the autonomous session of 2026-06-30. What's **done** is a verified
proof-of-pipeline; what's **below** is the bulk of the full retarget. Ordered
roughly by dependency. Tracked against elm-cem#1 / elm-m3e#71.

## Done (this session)
- **M1** — three-layer namespace flip + bottom layer (`<Lib>.Cem.Html.*` plain html,
  `<Lib>.Cem.*` middle, `<Lib>.Cem.Common`). Generates 125×3+1 modules for m3e; lower
  layers compile. *(elm-cem `3a692ce`)*
- **M2** — top layer (`<Lib>.<Component>`): `Config`/`Option`/`defaultConfig`/setters/`view`
  returning the `Element`/`Node` IR, importing the hand core. Bool/number/string options.
  Verified: 5 components compile + `M3e.Button` passes 4/4 IR tests incl. R1 reset.
  *(elm-cem `69dcf48`)*

## Remaining (largest → smallest, with the relevant issue)

### Generator (elm-cem)
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
