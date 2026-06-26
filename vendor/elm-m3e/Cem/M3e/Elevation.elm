module Cem.M3e.Elevation exposing (component, disabled, for, level)

{-| 
Visually depicts elevation using a shadow.

## Component

@docs component

### Attributes

@docs disabled, for, level
-}


import Html
import Html.Attributes
import Json.Encode


{-| Visually depicts elevation using a shadow. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-elevation" attributes children


{-| Whether hover and press events will not trigger changes in elevation, when attached to an interactive element. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_


{-| The level at which to visually depict elevation. (default: `null`) -}
level : String -> Html.Attribute msg
level val_ =
    Html.Attributes.attribute "level" val_