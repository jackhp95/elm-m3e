module M3e.TabPanel exposing (view)

{-| A panel presented for a tab.

**Component Info:**

  - **Extends:** `LitElement`

@docs view

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.TabPanel
import M3e.Node
import M3e.Token


{-| Build the `<m3e-tab-panel>` element (lazy IR).
-}
view :
    List (M3e.Html.Attr.Attr { slot : M3e.Token.Supported } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | tabPanel : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.TabPanel.tabPanel
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )
