module Cem.M3e.Accordion exposing (component, multi)

{-| Combines multiple expansion panels in to an accordion.

@docs component, multi

-}

import Html
import Html.Attributes
import Json.Encode


{-| Combines multiple expansion panels in to an accordion.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-accordion" attributes children


{-| Whether multiple expansion panels can be open at the same time. (default: `false`)
-}
multi : Bool -> Html.Attribute msg
multi val_ =
    Html.Attributes.property "multi" (Json.Encode.bool val_)
