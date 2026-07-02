module M3e.Cem.Html.ActionElementBase exposing ( actionElementBase )

{-|
Bottom layer for `<ActionElementBase>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs actionElementBase
-}


import Html


{-| The raw `<div>` element — a partial application of `Html.node`. -}
actionElementBase :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
actionElementBase =
    Html.node "div"