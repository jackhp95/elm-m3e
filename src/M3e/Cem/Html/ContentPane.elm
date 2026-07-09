module M3e.Cem.Html.ContentPane exposing ( contentPane )

{-|
Bottom layer for `<m3e-content-pane>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs contentPane
-}


import Html


{-| The raw `<m3e-content-pane>` element — a partial application of `Html.node`. -}
contentPane : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
contentPane =
    Html.node "m3e-content-pane"