module Cem.M3e.ChipSet exposing (component, vertical)

{-| 
A container used to organize chips into a cohesive unit.

## Component

@docs component

### Attributes

@docs vertical
-}


import Html
import Html.Attributes
import Json.Encode


{-| A container used to organize chips into a cohesive unit. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-chip-set" attributes children


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    Html.Attributes.property "vertical" (Json.Encode.bool val_)