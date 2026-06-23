module M3e.Accordion exposing (component)

{-| 
Combines multiple expansion panels in to an accordion.

## Component

@docs component
-}


import Html


{-| Combines multiple expansion panels in to an accordion. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-accordion" attributes children