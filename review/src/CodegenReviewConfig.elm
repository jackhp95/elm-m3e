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
    , NoSeamOutsideAllowedModules.rule [ "Native", "Layout", "Kit", "Seam", "EscapeHatch" ]
    ]
