module M3e.Cem.Html.Divider exposing (divider, inset, insetEnd, insetStart, vertical)

{-| 
@docs divider, inset, insetStart, insetEnd, vertical
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-divider>` element — a partial application of `Html.node`. -}
divider : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
divider =
    Html.node "m3e-divider"


{-| Whether the divider is indented with equal padding on both sides. (default: `false`) -}
inset : Bool -> Html.Attribute msg
inset val_ =
    Html.Attributes.property "inset" (Json.Encode.bool val_)


{-| Whether the divider is indented with padding on the leading side. (default: `false`) -}
insetStart : Bool -> Html.Attribute msg
insetStart val_ =
    Html.Attributes.property "insetStart" (Json.Encode.bool val_)


{-| Whether the divider is indented with padding on the trailing side. (default: `false`) -}
insetEnd : Bool -> Html.Attribute msg
insetEnd val_ =
    Html.Attributes.property "insetEnd" (Json.Encode.bool val_)


{-| Whether the divider is vertically aligned with adjacent content. (default: `false`) -}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    Html.Attributes.property "vertical" (Json.Encode.bool val_)