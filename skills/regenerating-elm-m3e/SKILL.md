---
name: regenerating-elm-m3e
description: >-
  Regenerates the generated src/ of elm-m3e from the @m3e/web Custom Elements Manifest
  plus config/, and reviews the resulting diff — the maintainer regen contract. Use when
  maintaining elm-m3e and a @m3e/web version bump changed the manifest, a config key
  (config/slots.json, native-mdn.json, examples.*) was edited, someone hand-edited a file
  under src/M3e/ (which must be reverted and regenerated), a regen diff needs reviewing
  (expected vs suspicious), or zero-diff needs verifying after a toolchain/generator
  change. Covers the never-hand-edit rule, the exact elm-cem command, the config/slots.json
  schema and how edits flow through the generator, the regen-on-bump.yml automation, and
  reading a regen diff. This is a maintainer-run workflow, not something to trigger from a
  consumer's feature request. For releasing see releasing-elm-m3e.
disable-model-invocation: true
---

# Regenerating elm-m3e

**Everything under `src/M3e/` is a generated artifact.** The hand-craft lives in the
generator (`elm-cem`), the config (`config/`), and the userland seam (`docs/kit/`) — never
in the per-component modules. The regen contract: **CEM + config in, the layered
`M3e.*` binding out** (`docs/DESIGN.md` §6).

## The one rule: never hand-edit generated files

If you find a bug in a generated module, the fix is upstream — in the config or the
generator — never in `src/M3e/`. A hand-edit is silently overwritten on the next regen and
diverges the library from `@m3e/web`. If someone *has* hand-edited a generated file:

1. Revert the file (`git checkout -- src/M3e/<File>.elm`).
2. Make the real fix in `config/slots.json` (or upstream in `elm-cem`).
3. Regenerate and confirm the intended change appears in the diff.

(The hand-written IR *core* — `Markup.Node`, `Markup.Element`, `Markup.Html.Attr`,
`Markup.Aria`, `Markup.Attributes`, and `Markup.Kind` — now lives in the shared
`markup-core` package (`elm-cem/markup/src/Markup/`), not in `src/M3e/`. elm-m3e
imports these modules as a dependency (`ownsRuntime = false`). Per-component modules
under `src/M3e/` are deliberately excluded from `elm-format --validate` because they
are generated.)

## The regen command

Run from the repo root (mirrors `regen-on-bump.yml`). `elm-cem/` is gitignored and cloned
alongside; install its deps first (`cd elm-cem && npm ci`). It needs an `elm` 0.19.1 on
`PATH`.

```bash
node elm-cem/bin/elm-cem.js \
  --flags-from=docs/node_modules/@m3e/web/dist/custom-elements.json \
  --config-from=config/slots.json \
  --config-from=config/native-mdn.json \
  --config-from=config/examples.generated.json \
  --config-from=config/runtime.json \
  --output=src
```

`config/runtime.json` carries `{ "_runtime": { "owns": false } }` — it tells the
generator that elm-m3e imports its IR core from the shared `markup-core` package
(`Markup.*` modules) rather than emitting its own runtime copies.

Then **format** (the raw output is not elm-formatted — committing it raw floods the diff
with line-wrap churn that swamps the real API change):

```bash
elm-cem/node_modules/.bin/elm-format src --yes
```

Then **verify it compiles** — the correctness proof and the publish gate:

```bash
node_modules/.bin/elm make src/M3e.elm --output=/dev/null   # must be EXIT 0
```

## `config/slots.json` — the schema, and how edits flow

Keyed by **PascalCase component name**, plus `_`-prefixed meta-keys (`_exclude`,
`_native`, `_seams`). Full schema: `docs/CONFIG_SCHEMA.md`. What each key changes in the
output:

| Config key | Flows to the generated output as |
|------------|----------------------------------|
| `slots.<name>.kinds` | the slot's phantom kind row (closed set via `"shared:<atom>"` or private `"<kind>"`, `"arbitrary"` open row, or build error if empty) |
| `slots.<name>.multi` | cardinality (advisory `SingularSlot`/multi accumulation) |
| `slots.<name>.required` | required-slot record field / `RequireSlot` fact |
| `required` (action facet) | a required-record field on the `M3e.Record`/`M3e.Build` form |
| `requiredAttrs` | required record fields (e.g. `aria-label` → a11y-required) |
| `staticAttrs` | always-on attrs, never surfaced as setters |
| `actionMap` / `events` | Action facets / custom-event decoders |
| `idWiring` | structural `for`/`id` label↔control association |
| `group` | variant-split members folded into one module |
| `attrTypes` | typed-arg overrides (force an attr's Elm type) |
| `_actions` | the `M3e.Action` roster (capability-typed behavioural values) |
| `_native` | the typed native-HTML facade (`M3e.Native`) |
| `_seams` | the `M3e.Seam` contract types + stampers |
| `_coerce` | config-blessed brand crossings emitted as `M3e.Coerce.<name>` functions |
| `_runtime` | `{ "owns": false }` → import `Markup.*` from `markup-core` (not emit) |

**Vocabulary that bites:** the unnamed slot is keyed `"unnamed"` (not `"default"`); the
accepts-anything sugar is the bare string `"arbitrary"` (not `"any"`); `[]` means *no
typed children* and is rare — an unrestricted slot is `"arbitrary"`, never `[]`. A
component **absent from config gets safe permissive defaults** (free child row, no
required, no groups) — so config is grown by evidence, not up front. See CONFIG_SCHEMA.

Editing config → rerun the regen command → the change shows in the `src` diff.

## The `regen-on-bump.yml` automation

A `@m3e/web` bump in `docs/package.json`/`docs/pnpm-lock.yaml` triggers `regen-on-bump.yml`:
it detects whether `@m3e/web` actually changed, installs to materialize the new CEM, clones
`elm-cem`, runs the exact command above, elm-formats, and **commits the regen diff back
onto the PR branch**. CI then re-runs and proves the regenerated output still compiles. The
regen is **deterministic** — a no-op bump produces no commit (the workflow's `git diff
--quiet -- src` guard). You review the auto-committed diff like any code change.

## Reading a regen diff — expected vs suspicious

**Expected** (accept): new component modules, new attribute setters, new enum tokens in a
`Value` row, doc-comment text changes (from `native-mdn.json` refresh), example-corpus
churn — all tracking real `@m3e/web` changes.

**Suspicious** (investigate before merging):

- A **slot row narrowing from `"arbitrary"` to a closed set, or the reverse**, that you
  did not intend — a manifest change altered inferred kinds; confirm it matches upstream.
- A **required field appearing/disappearing** unexpectedly — check the manifest and config.
- A phantom capability **renamed** (breaks consumer type annotations) — a real breaking
  change; note it for the changelog/`elm bump`.
- **Massive whitespace-only churn** — you forgot the `elm-format` step; re-run it.
- Any change under `src/M3e/` to modules that shouldn't be generated — the IR core
  (`Markup.*`) lives in `markup-core`, not in `src/M3e/`; the generator should never
  produce files named `Node.elm`, `Element.elm`, `Html/Attr.elm` etc. under `src/M3e/`.

## Zero-diff verification after a toolchain change

After bumping `elm-cem` or changing the generator with **no** intended output change, prove
it: regenerate + format, then `git diff --stat src` should be **empty**. A non-empty diff
means the toolchain change was not behavior-preserving — inspect it. This is the same
determinism the golden suite in `elm-cem` gates.

## Reference

- `docs/DESIGN.md` §6 (Regeneration) and §1–§4 (what the layers/seams the generator emits).
- `docs/CONFIG_SCHEMA.md` — the authoritative `config/slots.json` schema and vocabulary.
- `.github/workflows/regen-on-bump.yml` — the automation this skill operationalizes.

---
_Validated against elm-m3e 1.0.0, 2026-07._
