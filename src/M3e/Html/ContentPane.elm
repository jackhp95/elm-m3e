module M3e.Html.ContentPane exposing (contentPane)

{-| Middle layer for `<m3e-content-pane>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ContentPane` module for everyday use.

@docs contentPane

-}

import Html
import M3e.Html.Attr
import M3e.Raw.ContentPane
import M3e.Token


{-| A shaped surface for vertically scrollable content.

**Component Info:**

  - **Extends:** `LitElement`

-}
contentPane :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
contentPane attributes children =
    M3e.Raw.ContentPane.contentPane
        (List.map M3e.Html.Attr.toAttribute attributes)
        children
