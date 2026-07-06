# HANDOFF — start here

The single "read this first" doc for resuming work. Updated 2026-07-01 (Vocab core
BUILT). If a doc below contradicts this file, this file is newer — but verify
against the code.

## Current on-disk state — Vocab core is BUILT ✅

- `packages/m3e/` **ships the generated library** and compiles green — 379 modules
  (`cd packages/m3e && npx elm make src/M3e.elm --output=/dev/null`). Old hand `src/M3e`
  + `vendor/` are gone.
- The generator (`elm-cem/`, a **separate git repo** cloned in, gitignored — commit
  it separately) emits it from the `@m3e/web` CEM + `config/slots.json`. Work is on
  branch **`feat/vocab-architecture`** in BOTH repos.
- **The `docs/COMPONENT_AGNOSTIC_API.md` §9b Vocab architecture is now built.** The
  old bug (`M3e.Attr` returned raw `Html.Attribute`, unconsumable) is GONE. Shape now:
  - **`M3e.Cem.Html.Vocab`** — shared bottom, raw `elm/html`, every merged attr+event.
  - **`M3e.Cem.Vocab`** — the phantom shared vocab: `disabled : Bool -> M3e.Cem.Attr.Attr
    { c | disabled : Supported } msg`, etc. Wraps the bottom vocab. ONE loose,
    component-agnostic function per attr/event name (enum inputs union every
    component's values).
  - **`M3e.<Comp>`** (e.g. `M3e.Button`) — `view` (the constructor) + the component's
    OWN **strict** attr/event setters (aliases of the middle; enum inputs closed to
    THIS component's values, so `M3e.Button.variant M3e.Value.circular` is rejected) +
    typed slot setters. Group/variant-split modules keep natural names (`linear`/`circular`).
  - **`M3e`** (barrel) — one import re-exposing every constructor (as its noun,
    `M3e.button = M3e.Button.view`) + the whole loose vocab, all with **materialized
    type annotations** (all 313 exposed decls annotated). Collision guard: `shape`/`step`
    are both components and attrs → the attribute is suffixed (`shapeAttr`/`stepAttr`).

  **Two surfaces:** `import M3e.Button` = strict/value-checked; `import M3e exposing (..)`
  = loose one-import. Both verified with probes (positive compiles; wrong-capability and
  wrong-enum-value both fail).

## What's left

1. **elm-review rules (generated) — step 6, NOT yet built.** `ValidEnumValue` (flag a
   loose `variant Value.circular` on a Button — the backstop the loose barrel needs),
   `PreferSpecificSlot` (rewrite general `trailingSlot`→`appBarTrailingSlot`), and the
   ADR-0011 advisory `RequireSlot`/`SingularSlot`. The strict `M3e.<Comp>` API already
   gives full type safety; these only backstop the LOOSE barrel/general-slot path. The
   hand rules in `review/` are OLD Ui.*-era artifacts — decide delete vs keep.
2. **`M3e.Vocab` internal consolidation (§9b step 3) — deliberately SKIPPED.** The doc
   wanted an internal `M3e.Vocab` that both the barrel and component modules alias, to
   avoid duplication/cycles. The built structure already defines each constructor once
   (in `M3e.<Comp>`) with the barrel aliasing it — no duplication, no cycles — so the
   extra indirection wasn't built. Revisit only if it buys something concrete.
3. **Full `elm publish` docs-readiness** — 4 runtime templates (`M3e.Value.Core`,
   `M3e.Element`, `M3e.Node`, `M3e.Cem.Attr`) lack module doc comments, so `elm make
   --docs` fails. NOT needed for the product (consumers use source-dirs, not the
   published package) — only for actually publishing to package.elm-lang.org.

## Regenerate + verify (the loop)

Regenerate via `bin/elm-cem.js` (NOT bare `elm-codegen run` — see FRICTIONS F10).
First (re)generate the usage-examples config. The HTML→Elm converter was recovered
into elm-m3e at `docs/scripts/examples-gen/` (it was deleted from the standalone
`m3e-docs` repo, where its paths didn't resolve). It reads the mined corpus from the
nested `m3e-docs/data/examples.json`, compile-verifies each example against the real
library, and writes `config/examples.generated.json`:
```
cd docs && npm run build:examples-config   # (was: m3e-docs/scripts/examples-to-elm.mjs)
```
> **Caveat (pending emitter migration):** `examples-gen/lib/to-elm.mjs` still emits the
> pre-`M3e.Action` API, so the oracle now flags `action` as required and every clickable
> (button / icon-button / fab / chip) SKIPS the compile-verify gate — a fresh run yields
> ~49/106 examples, down from the committed 106. Until the emitter is updated to the
> `{ content, action }` shape, KEEP the committed `config/examples.generated.json`; do not
> overwrite it with a regressed run. Unit gate: `cd docs && npm run test:examples-gen`
> (the 10 red `to-elm` cases are this same drift).

Then:
```
node elm-cem/bin/elm-cem.js \
  --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
  --config-from=config/slots.json --config-from=config/native-mdn.json --config-from=config/examples.generated.json \
  --output=packages/m3e/src
cd packages/m3e && npx elm make src/M3e.elm --output=/dev/null    # expect: 379 modules
```
For a change, edit `elm-cem/codegen/Generate.elm`, regenerate, `elm make`, and drop a
scratch `packages/m3e/src/Probe.elm` that must FAIL to compile (then delete it).

## Then: migrate consumers (now UNBLOCKED)

The docs app (`docs/`, elm-pages, ~18 files) still uses the OLD `.view` API and does
NOT compile against the new library. Migrate it (and later sibling repos) — see
`docs/MIGRATION_OLD_TO_NEW.md` **but note it's written against the SUPERSEDED
per-component-setter API and must be rewritten to the Vocab API first.** Tooling +
environment (the GPU box, ornith, elmq, the agent harness): **`docs/MIGRATION_TOOLING.md`.**

## Read order for the design
1. `docs/THE_COMPLETE_EFFORT.md` — vision + every decision.
2. `docs/COMPONENT_AGNOSTIC_API.md` — the CURRENT target API (Vocab). §9b is authoritative.
3. `docs/ADOPTION_AND_SLOTS.md` — slot model, `any`, escapes (§8).
4. `docs/adr/0008`–`0011` — architecture decisions (0011 = faithfulness + advisory cardinality).
5. `docs/THREE_LAYER_PATTERN.md`, `docs/MIGRATION_OLD_TO_NEW.md` (stale re: API shape),
   `README.md`, `FRICTIONS.md` (the F-numbered gotchas), `docs/MIGRATION_TOOLING.md`.

## Non-obvious learnings (don't re-derive)
- **`bin/elm-cem.js`, never bare `elm-codegen run`** (F10 — it does TS-alias inlining;
  bare run degrades enums to `String`).
- **Escapes are userland, NOT in the package**: `Kit`/`Native`/`EscapeHatch`/`Seam` live
  in `packages/m3e-kit/` (copyable examples). `any` = a lowercase type var (no alias).
- **Node-level vs Element-level migration differ** (MIGRATION §1b): `Node msg`-returning
  layout code → `Node.raw (Html.*)` (correct there); `Element`-returning component code →
  the kit (`EscapeHatch`/`Native`). `Node.raw(Html…)` is an ANTI-PATTERN at the Element level.
- **Loose types + elm-review**, not maximal strictness: same-name-different-type attrs →
  type-suffix (`value`/`valueFloat`); per-component enum-value validity → the generated
  `ValidEnumValue` rule; slot general+specific → `PreferSpecificSlot` autofix.
- **`config/slots.json` is hand-rolled and may be wrong** — the loose+review approach is
  deliberately forgiving so config can be fixed iteratively.
- The CEM the config was built against: `docs/node_modules/@m3e/web/dist/custom-elements.json`.
