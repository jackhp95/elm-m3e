module M3e.Cem.Html.Icon exposing (icon)

import Html exposing (Html)

icon : List (Html.Attribute msg) -> List (Html msg) -> Html msg
icon = Html.node "m3e-icon"
