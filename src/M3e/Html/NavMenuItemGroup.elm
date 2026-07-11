module M3e.Html.NavMenuItemGroup exposing (navMenuItemGroup)

{-| Middle layer for `<m3e-nav-menu-item-group>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.NavMenuItemGroup` module for everyday use.

@docs navMenuItemGroup

-}

import Html
import M3e.Html.Attr
import M3e.Raw.NavMenuItemGroup
import M3e.Token


{-| A top-level semantic grouping of items in a navigation menu.

**Component Info:**

  - **Extends:** `LitElement`

**Slots:**

  - `label`: Renders the label of the group.

-}
navMenuItemGroup :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
navMenuItemGroup attributes children =
    M3e.Raw.NavMenuItemGroup.navMenuItemGroup
        (List.map M3e.Html.Attr.toAttribute attributes)
        children
