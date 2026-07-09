module M3e.Cem.MenuItemGroup exposing ( menuItemGroup )

{-|
Middle layer for `<m3e-menu-item-group>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.MenuItemGroup` module for everyday use.

@docs menuItemGroup
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.MenuItemGroup
import M3e.Value


{-| Groups related items (such a radios) in a menu.

**Component Info:**
- **Extends:** `LitElement`
-}
menuItemGroup :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
menuItemGroup attributes children =
    M3e.Cem.Html.MenuItemGroup.menuItemGroup
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children