module M3e.Html.ListItem exposing (listItem)

{-| Middle layer for `<m3e-list-item>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ListItem` module for everyday use.

@docs listItem

-}

import Html
import M3e.Raw.ListItem
import M3e.Token
import Markup.Html.Attr


{-| An item in a list.

**Component Info:**

  - **Extends:** `LitElement`

**Slots:**

  - `leading`: Renders the leading content of the list item.
  - `overline`: Renders the overline of the list item.
  - `supporting-text`: Renders the supporting text of the list item.
  - `trailing`: Renders the trailing content of the list item.

-}
listItem :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
listItem attributes children =
    M3e.Raw.ListItem.listItem
        (List.map Markup.Html.Attr.toAttribute attributes)
        children
