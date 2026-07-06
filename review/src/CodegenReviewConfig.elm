module CodegenReviewConfig exposing (config)

{-| The **codegen-aware** elm-review rules (ADR 0012), wired with the generated
`M3e.Review.Facts` (per-component valid enums, required/multi slots). Kept as its own
config while the old-era hand `ReviewConfig` is ported (task #7); merge in once the
whole set is verified against `elm-test`.

@docs config

-}

import M3e.Review.Facts
import MissingRequiredAttribute
import MissingRequiredSingularSlot
import NoActionlessButton
import NoInternalImportOutsideAllowed
import NoSeamOutsideAllowedModules
import PreferSpecificSlot
import RequireSlot
import Review.Rule exposing (Rule)
import SingularAttribute
import SingularSlot
import ValidEnumValue


{-| The Vocab-API rule set. The facts-driven rules are parameterised by the
generated `M3e.Review.Facts` (per-component valid enums, required/multi slots,
attr/slot rewrites, required attrs); the Seam gate takes the list of modules
allowed to hold escape hatches — tune it per project.
-}
config : List Rule
config =
    [ ValidEnumValue.rule M3e.Review.Facts.facts
    , RequireSlot.rule M3e.Review.Facts.facts
    , SingularSlot.rule M3e.Review.Facts.facts
    , MissingRequiredAttribute.rule M3e.Review.Facts.facts
    , MissingRequiredSingularSlot.rule M3e.Review.Facts.facts
    , SingularAttribute.rule M3e.Review.Facts.facts
    , PreferSpecificSlot.rule M3e.Review.Facts.facts
    , NoActionlessButton.rule

    -- One Seam boundary (ADR 0014 §2, #81). Allowed holders: the reusable
    -- adapters (`Native`, `Layout`, `Kit`) and `Seam` itself, plus the docs
    -- app's own adapters — `Doc` (doc-rendering) and `Shared` (the app-shell
    -- root, already the sole holder of the `Node.toHtml` render exit). Prefixes,
    -- so `Kit` covers `Kit.Surface`/`Kit.Shape`. Feature routes are NOT listed.
    , NoSeamOutsideAllowedModules.rule [ "Native", "Layout", "Kit", "Seam", "Doc", "Shared" ]

    -- The opaque-IR `*.Internal` boundary (ADR 0014 §2): only generated `M3e.*`
    -- code and the modules that actually build the crossings (`Seam`, and the
    -- `Native`/`Layout`/`Kit` adapters) may import an interior module. The docs
    -- `Doc`/`Shared` adapters cross through `Seam`, so they need no Internal
    -- import and are deliberately absent here.
    , NoInternalImportOutsideAllowed.rule [ "M3e", "Native", "Layout", "Kit", "Seam" ]

    -- ## D6 codegen-aware translator (issue #145)
    --
    -- Enable exactly ONE of the five rules below to enforce a single canonical
    -- top-layer surface across the codebase. `elm-review --fix` rewrites every
    -- non-target call site to the target surface via `Seam.*` residue for any
    -- lossy pieces. See docs/superpowers/specs/2026-07-05-codegen-aware-translator-design.md.
    --
    -- import TranslateToStandard
    -- import TranslateToBuild
    -- import TranslateToRecord
    -- import TranslateToCem
    -- import TranslateToHtml
    --
    -- , TranslateToBuild.rule M3e.Review.Facts.facts
    --     |> Rule.ignoreErrorsForDirectories [ "src/legacy" ]
    ]
