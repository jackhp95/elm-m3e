# 12. Codegen-aware elm-review: generated facts + hand-written configurable rules

Date: 2026-07-01

## Status

Accepted. Builds on [ADR 8](0008-three-layer-generator-retarget.md) (the three
generated layers) and [ADR 11](0011-ir-faithfulness-advisory-cardinality.md)
(advisory required-presence + cardinality). Realises the "loose types +
elm-review" split in `COMPONENT_AGNOSTIC_API.md` §8.

## Context

The top layer is deliberately **loose**: the barrel exposes one component-agnostic
`variant` accepting every component's tokens, general slot setters, and (per
ADR 11) advisory-only required/cardinality. Correctness of the finer facts —
*is this enum value valid for THIS component, is a required slot present, is a
general slot better written as its specific name* — is intentionally **not**
encoded in the types; it is elm-review's job.

Those checks need facts only the [[CEM]]/config know (per-component valid enum
value-sets, required/multi slots, the shorthand↔specific pairing `variant` ↔
`variantButton`). Two further forces: an autonomous migrator (see
`docs/ORNITH_MIGRATION_PLAN.md`) needs *machine-actionable* guidance, not prose;
and we want rules that can **translate** a call between any two of the five API
surfaces (bottom, middle, and the top layer in each of its three shapes).

## Decision

**Generate the facts, hand-write the rules.** The generator emits a **facts
module** (a plain Elm data table: component → valid enums, required slots, multi
slots, shorthand↔specific names, the per-surface function map). A small set of
**hand-written, configurable, unit-tested** generic rules import it.

- **Universal invariants** — the `toHtml` gate, the Seam gate (Seam/Native only
  inside a repo's designated [[Seam module]](s), configurable list), no raw
  attribute on a component slot — are hand-written and config-parameterized.
- **Component-specific checks** — `ValidEnumValue`, `PreferSpecificSlot`
  (auto-fix), `RequireSlot`/`SingularSlot` — are one generic rule each, driven by
  the generated facts.
- **Layer/shape translation** — moving a call across the five surfaces is one
  algorithm parameterized by the facts, not N generated rule modules.

### Considered and rejected

- **Generate the rule modules themselves** (data baked into emitted `.elm`): every
  CEM bump rewrites logic you can't diff or unit-test; elm-review rules are subtle
  and want to be hand-authored against the existing `review/tests/` harness.
- **Pure hand-written rules**: cannot know per-component facts without duplicating
  the generator's CEM analysis.
- **Compiler-only (encode everything in phantom types)**: rejected upstream — the
  loose shapes exist on purpose for composition ergonomics (ADR 11); a fully
  type-gated top layer is the *phantom-builder* shape, one option among several.

## Consequences

elm-review becomes first-class generator output. The review project gains a
dependency on the generated facts module; on a `@m3e/web` release only the facts
regenerate while the rule logic stays hand-tested. The old-era `materialDiscipline`
rules are ported/generalized onto this footing (notably
`NoRawLayoutOutsideLayoutModule` → the configurable Seam gate). This is also what
gives the ornith migrator its actionable, per-component feedback loop.
