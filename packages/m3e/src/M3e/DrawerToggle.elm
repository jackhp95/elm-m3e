module M3e.DrawerToggle exposing (drawerToggle)

{-| 
@docs drawerToggle
-}


import M3e.Cem.Attr
import M3e.Cem.DrawerToggle
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-drawer-toggle>` element (lazy IR). -}
drawerToggle :
    List (M3e.Cem.Attr.Attr { for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | drawerToggle : M3e.Value.Supported } msg
drawerToggle attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.DrawerToggle.drawerToggle
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )