module Cem.M3e.Divider exposing
    ( component
    , inset, insetStart, insetEnd, vertical
    )

{-| A thin line that separates content in lists or other containers.


## Component

@docs component


### Attributes

@docs inset, insetStart, insetEnd, vertical

-}

import Html
import Html.Attributes
import Json.Encode


{-| A thin line that separates content in lists or other containers.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-divider" attributes children


{-| Whether the divider is indented with equal padding on both sides. (default: `false`)
-}
inset : Bool -> Html.Attribute msg
inset val_ =
    Html.Attributes.property "inset" (Json.Encode.bool val_)


{-| Whether the divider is indented with padding on the leading side. (default: `false`)
-}
insetStart : Bool -> Html.Attribute msg
insetStart val_ =
    Html.Attributes.property "insetStart" (Json.Encode.bool val_)


{-| Whether the divider is indented with padding on the trailing side. (default: `false`)
-}
insetEnd : Bool -> Html.Attribute msg
insetEnd val_ =
    Html.Attributes.property "insetEnd" (Json.Encode.bool val_)


{-| Whether the divider is vertically aligned with adjacent content. (default: `false`)
-}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    Html.Attributes.property "vertical" (Json.Encode.bool val_)
