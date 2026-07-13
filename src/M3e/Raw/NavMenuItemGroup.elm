module M3e.Raw.NavMenuItemGroup exposing (navMenuItemGroup)

{-| Bottom layer for `<m3e-nav-menu-item-group>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs navMenuItemGroup

-}

import Html


{-| The raw `<m3e-nav-menu-item-group>` element — a partial application of `Html.node`.
-}
navMenuItemGroup : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
navMenuItemGroup =
    Html.node "m3e-nav-menu-item-group"
