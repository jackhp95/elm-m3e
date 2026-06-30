module Sl.Cem.Html.Alert exposing (alert)

{-| 
@docs alert
-}


import Html


{-| The raw `<sl-alert>` element — plain `elm/html`, no typed attributes or slots. -}
alert : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
alert attributes children =
    Html.node "sl-alert" attributes children