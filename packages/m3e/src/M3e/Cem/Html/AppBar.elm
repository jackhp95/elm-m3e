module M3e.Cem.Html.AppBar exposing (appBar, centered, for, size)

{-| 
@docs appBar, centered, for, size
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-app-bar>` element — a partial application of `Html.node`. -}
appBar : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
appBar =
    Html.node "m3e-app-bar"


{-| Whether the title and subtitle are centered. (default: `false`) -}
centered : Bool -> Html.Attribute msg
centered val_ =
    Html.Attributes.property "centered" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"


{-| The size of the bar. (default: `"small"`) -}
size : String -> Html.Attribute msg
size =
    Html.Attributes.attribute "size"