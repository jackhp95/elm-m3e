module CodegenReviewConfig exposing (config)

{-| The **codegen-aware** elm-review rules (ADR 0012), wired with the generated
`M3e.Review.Facts` (per-component valid enums, required/multi slots). Kept as its own
config while the old-era hand `ReviewConfig` is ported (task #7); merge in once the
whole set is verified against `elm-test`.

@docs config

-}

import M3e.Review.Facts
import RequireSlot
import Review.Rule exposing (Rule)
import SingularSlot
import ValidEnumValue


{-| The codegen-aware rule set, parameterised by the generated facts. -}
config : List Rule
config =
    [ ValidEnumValue.rule M3e.Review.Facts.facts
    , RequireSlot.rule M3e.Review.Facts.facts
    , SingularSlot.rule M3e.Review.Facts.facts
    ]
