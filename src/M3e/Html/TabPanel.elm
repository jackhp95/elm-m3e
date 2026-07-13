module M3e.Html.TabPanel exposing (tabPanel)

{-| Middle layer for `<m3e-tab-panel>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.TabPanel` module for everyday use.

@docs tabPanel

-}

import Html
import M3e.Raw.TabPanel
import M3e.Token
import Markup.Html.Attr


{-| A panel presented for a tab.

**Component Info:**

  - **Extends:** `LitElement`

-}
tabPanel :
    List (Markup.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
tabPanel attributes children =
    M3e.Raw.TabPanel.tabPanel
        (List.map Markup.Html.Attr.toAttribute attributes)
        children
