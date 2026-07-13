module M3e.Raw.Divider exposing (divider, inset, insetStart, insetEnd, vertical)

{-| Bottom layer for `<m3e-divider>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs divider, inset, insetStart, insetEnd, vertical

-}

import Html
import Html.Attributes


{-| The raw `<m3e-divider>` element — a partial application of `Html.node`.
-}
divider : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
divider =
    Html.node "m3e-divider"


{-| Whether the divider is indented with equal padding on both sides. (default: `false`)
-}
inset : Bool -> Html.Attribute msg
inset val_ =
    if val_ then
        Html.Attributes.attribute "inset" ""

    else
        Html.Attributes.classList []


{-| Whether the divider is indented with padding on the leading side. (default: `false`)
-}
insetStart : Bool -> Html.Attribute msg
insetStart val_ =
    if val_ then
        Html.Attributes.attribute "inset-start" ""

    else
        Html.Attributes.classList []


{-| Whether the divider is indented with padding on the trailing side. (default: `false`)
-}
insetEnd : Bool -> Html.Attribute msg
insetEnd val_ =
    if val_ then
        Html.Attributes.attribute "inset-end" ""

    else
        Html.Attributes.classList []


{-| Whether the divider is vertically aligned with adjacent content. (default: `false`)
-}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    if val_ then
        Html.Attributes.attribute "vertical" ""

    else
        Html.Attributes.classList []
