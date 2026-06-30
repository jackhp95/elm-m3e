# Frictions log — elm-cem retarget (autonomous session 2026-06-30)

Every friction, deviation, and surprise hit while executing
`docs/elm-cem-retarget-plan.md`. Newest at the bottom.

## Pre-flight findings (before coding)

- **F1 — The `Value` vocabulary does not exist in any committed generator.** `VENDORED_FROM.txt`
  claims the vendored atoms were "regenerated with the shared design-token generator," but it is
  committed nowhere: not in elm-cem `main`, and the archived `elm-custom-elements-manifest` branches
  (`feat/resolve-ts-aliases-to-enums`, `codegen-quality-overhaul`) are *behind* elm-cem main (they
  still emit kebab property keys, lack the `*ToString` exposure). So the `Value` vocab is **net-new**,
  not a port. *(Impact: enlarges the retarget; the vendored atoms' Value rows were a non-reproducible
  local state.)*
- **F2 — elm-cem `main` is canonical and most-advanced.** Confirmed by content diff. The retarget
  happens here.
- **F3 — No external-config mechanism exists.** Only the CEM enters the Elm side today
  (`Generate.main` decodes `Cem.manifestDecoder` and nothing else). `slots.json` / `overrides` /
  `--config-from` are all net-new (bin pass-through + a new `Config` decoder).
- **F4 — `cem-configs/*` are analyzer configs, not elm-cem configs.** They drive `cem analyze` to
  produce each library's `custom-elements.json`; elm-cem never reads them.
- **F5 — R1 is partly already done in the generator.** elm-cem `main` already emits bool/number as
  camelCase *properties* (`spec.propName`) — commit 832f82c. The vendored atoms in this repo are
  stale (pre-fix). So regenerating already fixes much of R1; the remaining R1 gap is enum/string
  staying kebab *attributes* (correct) and the `selected`/`checked` property handling.

## Execution frictions

- **F6 — elm-cem `package.json` has a broken devDep** (`elm-test-rs@^3.0.0` — no such version), so `npm install` in the clone fails outright. Worked around by installing `elm-codegen` standalone in the scratchpad. *(Fix upstream: pin a real elm-test-rs version.)* The `elm` binary is reused from elm-m3e's `node_modules/.bin`.
- **F7 — Deviation (logged): the IR core is NOT generated this session.** ADR 8 c1 says the generator should emit the core (Node/Element/Internal/Attr/Action/Value). For the proof-of-pipeline vertical, generated top-layer components instead IMPORT the existing hand-written `src/M3e/*` core. Core-generation is deferred to fan-out; this keeps the vertical focused on the component-emit retarget. Aligns with the vision (the core is foundational, not a component) and is the cheaper proof.
- **F8 — Toolchain VERIFIED:** `elm-codegen run` on the m3e CEM produced 126 modules. Edit→regen→compile loop is open.

- **F9 — Elm 0.19 shadowing bit the emitter.** First top-layer emit named every setter's
  parameter `value`, which shadows the `value` setter function (Button has a `value` attr) — an
  Elm 0.19 compile error. Fixed by using fixed non-colliding param names (`val_`, `cfg_`).
  *(General lesson for the generator: never derive a binder name from an attr name without a
  collision-proof prefix.)*
- **F10 — Direct `elm-codegen run` skips bin/elm-cem.js's TS-alias inlining**, so enum attrs
  (variant/size/shape) whose CEM type is a named alias fall back to `AString` (emitted as string
  setters/attributes, not enums). Harmless for the proof; real runs must go through `bin/elm-cem.js`
  (or replicate `inlineTypeAliases`). Enum→`Value` is a separate remaining item regardless.
- **F11 — Proof-of-pipeline VERIFIED.** Generated top-layer `M3e.Button/Card/Switch/Icon/Slider`
  compile against the hand-written core; `elm-test` on generated `M3e.Button` passes 4/4 IR
  assertions incl. R1 boolean-reset. The full vertical (CEM → 3 layers → compiles → correct IR)
  works on a representative set.
- **F12 — `elm make` in a fresh project hangs on registry fetch** (~7 min timeout) in this sandbox.
  Workaround: reuse elm-m3e's cached ELM_HOME by copying its elm.json deps; never `elm init` here.

## Resolutions (2026-06-30, follow-up)

- **F6 — RESOLVED (lasting).** Root cause: `elm-test-rs@^3.0.0` is not on npm (only prereleases);
  the binary is pinned in `elm-tooling.json` and installed by **elm-tooling** (the elm install tool).
  Fix: dropped the bogus `elm-test-rs` npm devDep from `elm-cem/package.json`. `npm install` now
  succeeds and `elm-tooling install` reports elm/elm-format/elm-test-rs "all good". The clone is
  self-sufficient. *(elm-cem, committed.)*
- **F10 — RESOLVED (lasting).** Now that the clone has its tools, verification runs through
  `bin/elm-cem.js`, which inlines the TS aliases (206 refs) so enums classify as `AEnum` (typed
  unions) instead of `String`. The earlier `String` degrade was an artifact of bypassing bin.
  *(NB: enum→`Value` shared vocab is still separate, foundational, remaining work.)*
- **F9 — already lasting** (emitter uses collision-proof binder names).
- **F7/F12** remain deliberate deviation / environmental, as logged.
