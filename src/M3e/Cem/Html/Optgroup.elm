module M3e.Cem.Html.Optgroup exposing ( optgroup )

{-|
Bottom layer for `<m3e-optgroup>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs optgroup
-}


import Html


{-| The raw `<m3e-optgroup>` element — a partial application of `Html.node`. -}
optgroup : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
optgroup =
    Html.node "m3e-optgroup"