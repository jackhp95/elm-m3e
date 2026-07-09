module M3e.DrawerToggle exposing ( view, for )

{-|
An element, nested within a clickable element, used to toggle the opened state of a drawer.

**Component Info:**
- **Extends:** `ActionElementBase`

@docs view, for
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.DrawerToggle
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-drawer-toggle>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | drawerToggle : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.DrawerToggle.drawerToggle
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.DrawerToggle.for