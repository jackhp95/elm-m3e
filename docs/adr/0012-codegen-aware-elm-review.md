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
`variantButton`). Two further forces: an autonomous migrator needs
*machine-actionable* guidance, not prose;
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

## Caveat: elm-review clean is NOT "the app compiles"

**A green `elm-review` does not mean the app compiles.** elm-review runs its own
compile of the modules it lints, but it does not reliably re-typecheck a changed
route *body* against the generated `.elm-pages/Main.elm` router (this project is
Lamdera-based; `.elm-pages/Main.elm` imports `Lamdera.Wire3`). Route type errors
therefore pass review: shop, mail, and travel each shipped with a real Elm type
error while `elm-review` reported "I found no errors!" — the errors only surfaced
under the elm-pages dev server / a real build (see
[`frictions/_integration.md` §1](../frictions/_integration.md)). Reproduced again
for #128: an `("#" ++ 5)` planted in a route body passes `elm-pages gen` +
`elm-review` cleanly (exit 0) yet fails `elm-pages build` with a TYPE MISMATCH.

Hypothesis for the miss: `elm-pages gen` is codegen only and does not typecheck
route bodies; elm-review compiles the source modules it lints but does so against
its own view of the project (`docs/elm.json`), not against the Lamdera-wired
`.elm-pages/Main.elm` that actually instantiates each `route`, so a mismatch that
only manifests when the router applies the route stays invisible. This is a
guidance/tooling gap, not an elm-review bug to fix.

**The authoritative gate is a real compile**, not review:

- `pnpm run check` (= `build:assets && elm-pages build`) — the lightest command
  that actually typechecks every route. `elm-pages` has no typecheck-only mode;
  `gen` alone does not typecheck, so this is as light as it gets. CI's `docs` job
  already runs the equivalent `pnpm run build`, so route type errors DO fail CI —
  the gap this closes is the **local / agent dev loop**.
- `pnpm start` / the elm-pages dev server — loading the route also compiles it.

Run one of these before claiming a route compiles. elm-review remains valuable for
what it *is* good at (the rules below); it is just not the compiler here.

## Rule roster (implemented)

All rules live in `review/src/`, each covered by a `Review.Test` suite in
`review/tests/` (24 tests, `elm-test-rs` green). The Vocab-API set is wired in
`review/src/CodegenReviewConfig.elm`, kept separate from the repo's `ReviewConfig`
until an `elm-review` run confirms the docs pass clean (the docs use `Seam`
intentionally, so the Seam gate can't run against them here).

| Rule | Kind | What it flags |
| --- | --- | --- |
| `ValidEnumValue` | facts-driven | a loose barrel enum setter given an `M3e.Value` token the target component rejects — the backstop the loose top layer deliberately doesn't type-enforce. Handles both `M3e.button [ variant … ]` and `Button.view [ … ]`. |
| `SingularSlot` | facts-driven, advisory (ADR 11) | a singular content slot filled 2+ times. Reads only the content list, so repeated attrs aren't mistaken for slots. |
| `RequireSlot` | facts-driven, advisory (ADR 11) | a required-*multi* slot (not type-enforced, unlike required-singular in the record) absent from the content list. |
| `NoActionlessButton` | hand-written | a button whose attrs wire no `onClick`/`href`/`toggle` and no explicit `disabled`/`disabledInteractive` — well-typed but inert. Ported from the Ui-era `Ui.Button.new` form. |
| `NoSeamOutsideAllowedModules` | hand-written, configurable | any `Seam.*`/`EscapeHatch.*` reference outside a configured allow-list of adapter modules. Generalizes `NoRawLayoutOutsideLayoutModule`. |
| `NoProprietaryDsClasses` | hand-written (kept as-is) | `ds-`/`t-` proprietary class tokens in `Attr.class` literals. Still valid under the new API. |

### Retired as obsolete under the Vocab API

- `NoUntypedSlot` — phantom-typed slot rows enforce this at compile time now.
- `NoRawAttributeInUi` — subsumed by the Seam gate (raw attrs now pass through `Seam.asAttribute`).
- `NoRawLayoutOutsideLayoutModule` — generalized into `NoSeamOutsideAllowedModules`; the `Layout` module it steered toward is gone.
- `PreferBadgeCount` — `M3e.Badge` has no `count`/`label`; the concept no longer exists.
- `NoMissingFacadeEntry` — the facade epic (#52) is closed; there is no facade.
