module M3e.Cem.NavMenuItemGroup exposing (navMenuItemGroup)

{-| 
@docs navMenuItemGroup
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.NavMenuItemGroup
import M3e.Value


{-| A top-level semantic grouping of items in a navigation menu.

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