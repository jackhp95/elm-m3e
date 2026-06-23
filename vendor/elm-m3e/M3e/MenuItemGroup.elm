module M3e.MenuItemGroup exposing (component)

{-| 
Groups related items (such a radios) in a menu.

## Component

@docs component
-}


import Html


{-| Groups related items (such a radios) in a menu. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-menu-item-group" attributes children