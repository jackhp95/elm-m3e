module M3e.NavRailToggle exposing (component)

{-| 
An element, nested within a clickable element, used to toggle the expanded state of a navigation rail.

## Component

@docs component
-}


import Html


{-| An element, nested within a clickable element, used to toggle the expanded state of a navigation rail. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-nav-rail-toggle" attributes children