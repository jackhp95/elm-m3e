module M3e.Cem.Html.MenuItemGroup exposing (menuItemGroup)

{-| 
@docs menuItemGroup
-}


import Html


{-| The raw `<m3e-menu-item-group>` element — a partial application of `Html.node`. -}
menuItemGroup :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
menuItemGroup =
    Html.node "m3e-menu-item-group"