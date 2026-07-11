module M3e.Raw.ScrollContainer exposing (scrollContainer, dividers, thin)

{-| Bottom layer for `<m3e-scroll-container>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs scrollContainer, dividers, thin

-}

import Html
import Html.Attributes


{-| The raw `<m3e-scroll-container>` element — a partial application of `Html.node`.
-}
scrollContainer : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
scrollContainer =
    Html.node "m3e-scroll-container"


{-| The dividers used to separate scrollable content. (default: `"above-below"`)
-}
dividers : String -> Html.Attribute msg
dividers =
    Html.Attributes.attribute "dividers"


{-| Whether to present thin scrollbars. (default: `false`)
-}
thin : Bool -> Html.Attribute msg
thin val_ =
    if val_ then
        Html.Attributes.attribute "thin" ""

    else
        Html.Attributes.classList []
