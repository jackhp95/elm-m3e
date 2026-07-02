module M3e.Cem.ListItem exposing ( listItem )

{-|
Middle layer for `<m3e-list-item>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ListItem` module for everyday use.

@docs listItem
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.ListItem
import M3e.Value


{-| An item in a list.

**Slots:**
- `leading`: Renders the leading content of the list item.
- `overline`: Renders the overline of the list item.
- `supporting-text`: Renders the supporting text of the list item.
- `trailing`: Renders the trailing content of the list item.
-}
listItem :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
listItem attributes children =
    M3e.Cem.Html.ListItem.listItem
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children