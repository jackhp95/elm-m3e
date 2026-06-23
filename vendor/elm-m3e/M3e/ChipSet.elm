module M3e.ChipSet exposing (component)

{-| A container used to organize chips into a cohesive unit.


## Component

@docs component

-}

import Html


{-| A container used to organize chips into a cohesive unit.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-chip-set" attributes children
