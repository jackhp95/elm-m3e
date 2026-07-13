module M3e.Raw.Accordion exposing (accordion, multi)

{-| Bottom layer for `<m3e-accordion>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs accordion, multi

-}

import Html
import Html.Attributes


{-| The raw `<m3e-accordion>` element — a partial application of `Html.node`.
-}
accordion : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
accordion =
    Html.node "m3e-accordion"


{-| Whether multiple expansion panels can be open at the same time. (default: `false`)
-}
multi : Bool -> Html.Attribute msg
multi val_ =
    if val_ then
        Html.Attributes.attribute "multi" ""

    else
        Html.Attributes.classList []
