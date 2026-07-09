module M3e.Cem.Html.Breadcrumb exposing ( breadcrumb, wrap )

{-|
Bottom layer for `<m3e-breadcrumb>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs breadcrumb, wrap
-}


import Html
import Html.Attributes


{-| The raw `<m3e-breadcrumb>` element — a partial application of `Html.node`. -}
breadcrumb : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
breadcrumb =
    Html.node "m3e-breadcrumb"


{-| Whether items wrap to a new line. (default: `false`) -}
wrap : Bool -> Html.Attribute msg
wrap val_ =
    if val_ then
        Html.Attributes.attribute "wrap" ""
    
    else
        Html.Attributes.classList []