module M3e.Cem.Html.Button exposing (button)

{-| 
@docs button
-}


import Html


{-| The raw `<m3e-button>` element — plain `elm/html`, no typed attributes or slots. -}
button : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
button attributes children =
    Html.node "m3e-button" attributes children