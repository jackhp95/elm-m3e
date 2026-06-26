module Cem.M3e.PseudoRadio exposing (checked, component, disabled)

{-| 
An element which looks like a radio button.

## Component

@docs component

### Attributes

@docs checked, disabled
-}


import Html
import Html.Attributes
import Json.Encode


{-| An element which looks like a radio button. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-pseudo-radio" attributes children


{-| A value indicating whether the element is checked. (default: `false`) -}
checked : Bool -> Html.Attribute msg
checked =
    Html.Attributes.checked


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)