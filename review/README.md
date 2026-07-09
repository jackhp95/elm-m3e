# `review/` — elm-review for `elm-m3e`

The `elm-review` configuration for the `elm-m3e` library (the `M3e.*` package at `src/`, the
generated Vocab-API wrapper over `@m3e/web`) and the `docs/` app. Alongside the
standard `jfmengels/*` rule packs it holds the project's **codegen-aware** custom
rules — see [ADR 0012](../docs/adr/0012-codegen-aware-elm-review.md) for the design.

## Running

From the **`docs/`** directory (elm + elm-review live in the docs install), against
`docs/elm.json` (whose source-dirs cover `app`, `src`, `.elm-pages`,
`../src`, `../docs/kit`):

```bash
cd docs
node_modules/.bin/elm-review --config ../review --compiler node_modules/.bin/elm
```

## Custom rules

All custom rules live in `review/src/` and are built test-first; their `Review.Test`
suites are under `review/tests/` (25 cases). No `elm-test` binary ships with this
repo, but `elm-cem/node_modules/.bin/elm-test-rs` runs them:

```bash
cd review
../elm-cem/node_modules/.bin/elm-test-rs --compiler ../docs/node_modules/.bin/elm tests/*.elm
```

| Rule | Kind | Enabled in `ReviewConfig`? |
|---|---|---|
| `ValidEnumValue` | facts-driven | ✅ — flags a loose enum setter given a token the component rejects |
| `SingularSlot` | facts-driven, advisory | ✅ — a singular content slot filled twice |
| `RequireSlot` | facts-driven, advisory | ✅ — a required-multi slot absent from content |
| `NoProprietaryDsClasses` | hand-written | ✅ — `ds-`/`t-` class tokens in `Attr.class` literals |
| `NoActionlessButton` | hand-written | ⬚ `CodegenReviewConfig` only — docs demos are inert on purpose |
| `NoSeamOutsideAllowedModules` | hand-written, configurable | ⬚ `CodegenReviewConfig` only — docs use `Seam` for Tailwind by design |

### Codegen-aware rules + `M3e.Review.Facts`

`ValidEnumValue` / `SingularSlot` / `RequireSlot` read `M3e.Review.Facts` — a data
module generated from the CEM alongside the library (per-component valid enums,
required slots, multi slots). The rule *logic* is hand-written and tested; a
`@m3e/web` bump only regenerates the facts. `review/elm.json` lists
`../src` as a source dir so the config can import the facts (it has no
dependencies of its own, so nothing else from the library is pulled in).

### Two configs

- **`ReviewConfig.elm`** — what this repo gates on. Includes the three facts-driven
  rules (verified clean against the whole docs app) + the standard packs.
- **`CodegenReviewConfig.elm`** — the full reusable Vocab-API set for *consumers*,
  including `NoActionlessButton` and the configurable `NoSeamOutsideAllowedModules`
  Seam gate. These two correctly fire on this repo's docs (demo buttons; intentional
  `Seam` use for Tailwind), so they're opt-in rather than gating this repo.

## Retired rules

The Ui-era material-discipline rules the Vocab API made obsolete were removed
(details in ADR 0012): `NoUntypedSlot` (phantom-typed slots enforce it),
`NoRawAttributeInUi` and `NoRawLayoutOutsideLayoutModule` (both generalized into
`NoSeamOutsideAllowedModules`), `PreferBadgeCount` (`M3e.Badge` has no `count`), and
`NoMissingFacadeEntry` (facade epic #52 closed).

## Relaxations

Deliberate, documented adjustments (not blind suppression) live as commented
`ignore*` helpers in `ReviewConfig.elm`: `.elm-pages/` is never linted (generated
routing); the library's public surface (`src/M3e/`) is exempt from `NoUnused.Exports`
/ `.Modules` / `NoMissingTypeExpose` (a library's exports are unused *by itself*); and
`M3e.Node.toHtml` is gated to `Shared` + `M3e.Node` (the single render escape hatch).
