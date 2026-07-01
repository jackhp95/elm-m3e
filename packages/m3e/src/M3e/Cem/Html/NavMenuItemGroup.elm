module M3e.Cem.Html.NavMenuItemGroup exposing (navMenuItemGroup)

{-| 
@docs navMenuItemGroup
-}


import Html


{-| The raw `<m3e-nav-menu-item-group>` element — a partial application of `Html.node`. -}
navMenuItemGroup :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
navMenuItemGroup =
    Html.node "m3e-nav-menu-item-group"