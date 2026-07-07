module M3e.MenuItemGroup exposing ( view )

{-|
Groups related items (such a radios) in a menu.

**Component Info:**
- **Extends:** `LitElement`

@docs view
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.MenuItemGroup
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-menu-item-group>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (M3e.Element.Element { menuItem : M3e.Value.Supported
    , menuItemCheckbox : M3e.Value.Supported
    , menuItemRadio : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | menuItemGroup : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.MenuItemGroup.menuItemGroup
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )