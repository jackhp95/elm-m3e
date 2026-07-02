module M3e.Cem.Html.MenuItemGroup exposing ( menuItemGroup )

{-|
Bottom layer for `<m3e-menu-item-group>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs menuItemGroup
-}


import Html


{-| The raw `<m3e-menu-item-group>` element — a partial application of `Html.node`. -}
menuItemGroup :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
menuItemGroup =
    Html.node "m3e-menu-item-group"