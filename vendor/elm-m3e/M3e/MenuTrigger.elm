module M3e.MenuTrigger exposing (component)

{-| 
An element, nested within a clickable element, used to open a menu.

## Component

@docs component
-}


import Html


{-| An element, nested within a clickable element, used to open a menu. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-menu-trigger" attributes children