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

- **F13 — open-vs-closed caught by a negative probe (the reason we test negatives).** First cut
  made the `variant` setter's accepted `Value` row OPEN (`{ v | … }`); `Value.small` then wrongly
  compiled. A `Value` *consumer* must be CLOSED (open token, closed consumer). Fixed. The same
  rule holds for all three phantom rows: **producers open, consumers closed.** The model is now
  proven: positive compiles, all three negatives reject.

- **F14 — WHOLE-LIBRARY MILESTONE.** The retargeted generator emits the full
  partial-application three-layer model + the Value vocabulary for ALL 125 m3e
  components; **all 125 top modules compile** over the hand core. Two of three
  phantom dimensions (Value + capability) are enforced and verified positive+negative
  against generated output. (Also re-learned: shell loops that round-trip module
  names through sed are fragile — iterate files directly. The first "0/125" was a
  loop bug, not a real failure.)

- **F15 — Config support landed (3rd phantom dimension).** `--config-from=<json>` is merged into
  the CEM flags under `_config` by bin (flag stripped; absent ⇒ generic config-free path). The top
  `view`'s children become a CLOSED kind-row when configured, a free row otherwise. Verified: a
  Button `{children:[icon,element]}` accepts icon+text children and REJECTS a button child;
  config-free whole-library regen still 125/125. All three phantom rows (Value, capability,
  element-kind) now enforced in generated output. No friction of note — the `_config`-in-flags
  approach kept the change small (no new elm-codegen flag channel).

- **F7 — RESOLVED.** The "hand-written core" is now generator output. Explored elm-codegen's embed
  options: `Elm.parse` (parses source → declarations) **drops imports** (verified — emitted a
  module missing `import Html`); `Elm.unsafe` injects a raw string mid-file (bad for imports). The
  clean mechanism is that **`Elm.File` is a transparent `{ path, contents, warnings }` record** — so
  the generator emits hand-written, type-checked source *verbatim* (imports intact) by constructing
  a `File` directly. Core authored in `elm-cem/runtime/` (single source of truth), injected by bin
  under `_runtime`, emitted with prefix substitution. Whole library 125/125 from generator output
  alone. (Prefix substitution is a plain `String.replace "M3e" <lib>` — safe for these tiny files;
  watch for false matches if a library name ever contains the token.)

- **F16 — the mechanical/design boundary.** Built straight through: config/typed-slots, core
  generation (F7), events, required-content/a11y, and the `M3e.Action` module — all verified,
  whole library 125/125 throughout. The remaining items are no longer "mechanical generation"
  but **design + per-component curation**: (a) `Action` *integration* (which components take it;
  suppressing the overlapping onClick/href; the action-vs-stateful read), and (b) **R5 groups** —
  folding multiple CEM tags into one module (Menu/List/Chip families), which **restructures the
  public module layout** (e.g. `M3e.MenuItem` → `M3e.Menu.item`). Plus authoring `config` for all
  125 components (domain knowledge). Not a technical block; flagging because (b) changes the public
  API shape and warrants a confirm before I restructure the generation pipeline around it.

- **F17 — KEY DESIGN FINDING: container+items should NOT fold (validates the usage rule).**
  `@m3e/web` shows `m3e-menu-item` used in BOTH `m3e-menu` and `m3e-fab-menu` (`@tag m3e-menu-item`
  in fab-menu.js). So folding it into `M3e.Menu.item` would break its reuse. **Conclusion: keep
  item modules standalone; containers accept them via the typed-slot `children` config (the
  mechanism already built).** Folding is reserved for true VARIANT-SPLITS (Progress linear/circular)
  where the tags are alternatives of one concept and not reused. This shrinks "R5 groups" massively:
  most families are just typed-slot config, no new generator code. (Authored Menu/FabMenu as typed
  containers; Menu accepts {menuItem,menuItemCheckbox,menuItemRadio}, rejects a Button — verified.)
- **F18 — naming bug caught by the Menu probe.** `Naming.camel` on a PascalCase module name
  lowercased everything (`menuitem`); multi-word components had all-lowercase fn/kind names. Fixed
  to `Naming.decapitalize`. (The whole library still compiled before the fix — internally
  consistent — so only a cross-module probe like "Menu accepts MenuItem" surfaced it. Another case
  of negative/integration probes earning their keep.)

- **F19 — required-param shadowing (F9 class, 3rd time).** The view's `required` record param
  shadowed the `required` form attribute setter on Checkbox/Radio. Renamed to `req_`. The recurring
  lesson: NO generated binder may be an attr-derived word; the safe set is fixed (`val_`/`cfg_`/`req_`/
  `f_`/`erased`/`ch`). Caught only when the config batch turned on required fields for form controls.
- **F20 — config authoring batch (for review).** Authored 27 components from `@m3e/web` evidence
  (`::slotted` kinds + CEM slots/attrs): containers (List/Tabs/Stepper/Breadcrumb/Tree/Nav*/
  SegmentedButton/Toc/ChipSet*/SelectionList/MenuItemGroup) with typed child-kind rows; a11y names
  for the textless controls (Checkbox/Switch/Radio/Fab/Slider); AssistChip action. Whole library
  125/125. The remaining ~98 components are at safe defaults (free child row, no required) and are
  the user's to review/extend — child-kind/required decisions are domain judgments.
