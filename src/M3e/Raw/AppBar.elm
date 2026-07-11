module M3e.Raw.AppBar exposing (appBar, centered, for, size)

{-| Bottom layer for `<m3e-app-bar>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs appBar, centered, for, size

-}

import Html
import Html.Attributes


{-| The raw `<m3e-app-bar>` element — a partial application of `Html.node`.
-}
appBar : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
appBar =
    Html.node "m3e-app-bar"


{-| Whether the title and subtitle are centered. (default: `false`)
-}
centered : Bool -> Html.Attribute msg
centered val_ =
    if val_ then
        Html.Attributes.attribute "centered" ""

    else
        Html.Attributes.classList []


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"


{-| The size of the bar. (default: `"small"`)
-}
size : String -> Html.Attribute msg
size =
    Html.Attributes.attribute "size"
