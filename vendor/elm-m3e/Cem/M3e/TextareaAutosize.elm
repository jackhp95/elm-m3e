module Cem.M3e.TextareaAutosize exposing (component, disabled, for, maxRows, minRows)

{-| 
A non-visual element used to automatically resize a `textarea` to fit its content.

## Component

@docs component

### Attributes

@docs disabled, for, maxRows, minRows
-}


import Html
import Html.Attributes
import Json.Encode


{-| A non-visual element used to automatically resize a `textarea` to fit its content. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-textarea-autosize" attributes children


{-| Whether auto-sizing is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_


{-| The maximum amount of rows in the `textarea`. (default: `0`) -}
maxRows : Float -> Html.Attribute msg
maxRows val_ =
    Html.Attributes.property "max-rows" (Json.Encode.float val_)


{-| The minimum amount of rows in the `textarea`. (default: `0`) -}
minRows : Float -> Html.Attribute msg
minRows val_ =
    Html.Attributes.property "min-rows" (Json.Encode.float val_)