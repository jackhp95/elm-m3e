module M3e.TextareaAutosize exposing (component, maxRows, minRows)

{-| 
A non-visual element used to automatically resize a `textarea` to fit its content.

## Component

@docs component

### Attributes

@docs maxRows, minRows
-}


import Html
import Html.Attributes
import Json.Encode


{-| A non-visual element used to automatically resize a `textarea` to fit its content. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-textarea-autosize" attributes children


{-| The maximum amount of rows in the `textarea`. (default: `0`) -}
maxRows : Float -> Html.Attribute msg
maxRows val_ =
    Html.Attributes.property "max-rows" (Json.Encode.float val_)


{-| The minimum amount of rows in the `textarea`. (default: `0`) -}
minRows : Float -> Html.Attribute msg
minRows val_ =
    Html.Attributes.property "min-rows" (Json.Encode.float val_)