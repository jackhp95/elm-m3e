module M3e.Cem.Html.ContentPane exposing (contentPane)

{-| 
@docs contentPane
-}


import Html


{-| The raw `<m3e-content-pane>` element — a partial application of `Html.node`. -}
contentPane : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
contentPane =
    Html.node "m3e-content-pane"