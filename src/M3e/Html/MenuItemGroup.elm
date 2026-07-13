module M3e.Html.MenuItemGroup exposing (menuItemGroup)

{-| Middle layer for `<m3e-menu-item-group>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.MenuItemGroup` module for everyday use.

@docs menuItemGroup

-}

import Html
import M3e.Raw.MenuItemGroup
import M3e.Token
import Markup.Html.Attr


{-| Groups related items (such a radios) in a menu.

**Component Info:**

  - **Extends:** `LitElement`

-}
menuItemGroup :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
menuItemGroup attributes children =
    M3e.Raw.MenuItemGroup.menuItemGroup
        (List.map Markup.Html.Attr.toAttribute attributes)
        children
