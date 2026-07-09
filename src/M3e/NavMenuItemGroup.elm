module M3e.NavMenuItemGroup exposing ( view, label )

{-|
A top-level semantic grouping of items in a navigation menu.

**Component Info:**
- **Extends:** `LitElement`

**Slots:**
- `label`: Renders the label of the group.

@docs view, label
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.NavMenuItemGroup
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-nav-menu-item-group>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Element.Element { navMenuItem : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | navMenuItemGroup : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.NavMenuItemGroup.navMenuItemGroup
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Place content in the `label` slot. -}
label :
    M3e.Element.Element { text : M3e.Value.Supported
    , heading : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
label el =
    M3e.Element.Internal.placeSlot "label" el