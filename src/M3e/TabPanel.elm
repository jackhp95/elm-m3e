module M3e.TabPanel exposing ( view )

{-|
A panel presented for a tab.

**Component Info:**
- **Extends:** `LitElement`

@docs view
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.TabPanel
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-tab-panel>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | tabPanel : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.TabPanel.tabPanel
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )