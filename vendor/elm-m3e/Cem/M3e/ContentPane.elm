module Cem.M3e.ContentPane exposing (component)

{-| 
A shaped surface for vertically scrollable content.

## Component

@docs component
-}


import Html


{-| A shaped surface for vertically scrollable content. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-content-pane" attributes children