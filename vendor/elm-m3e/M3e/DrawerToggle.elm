module M3e.DrawerToggle exposing (component)

{-| 
An element, nested within a clickable element, used to toggle the opened state of a drawer.

## Component

@docs component
-}


import Html


{-| An element, nested within a clickable element, used to toggle the opened state of a drawer. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-drawer-toggle" attributes children