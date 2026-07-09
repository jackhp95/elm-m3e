module M3e.Cem.NavMenuItemGroup exposing ( navMenuItemGroup )

{-|
Middle layer for `<m3e-nav-menu-item-group>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.NavMenuItemGroup` module for everyday use.

@docs navMenuItemGroup
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.NavMenuItemGroup
import M3e.Value


{-| A top-level semantic grouping of items in a navigation menu.

**Component Info:**
- **Extends:** `LitElement`

**Slots:**
- `label`: Renders the label of the group.
-}
navMenuItemGroup :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
navMenuItemGroup attributes children =
    M3e.Cem.Html.NavMenuItemGroup.navMenuItemGroup
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children