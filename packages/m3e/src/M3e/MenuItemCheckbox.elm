module M3e.MenuItemCheckbox exposing
    ( view, disabled, checked, onClick, icon, trailingIcon
    )

{-|
An item of a menu which supports a checkable state.

**Component Info:**
- **Extends:** `MenuItemElementBase` from `/src/menu/MenuItemElementBase`

**Events:**
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders an icon before the items's label.
- `trailing-icon`: Renders an icon after the item's label.

@docs view, disabled, checked, onClick, icon, trailingIcon
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.MenuItemCheckbox
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-menu-item-checkbox>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , checked : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element { text : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | menuItemCheckbox : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.MenuItemCheckbox.menuItemCheckbox
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.MenuItemCheckbox.disabled


{-| Whether the element is checked. (default: `false`) -}
checked : Bool -> M3e.Cem.Attr.Attr { c | checked : M3e.Value.Supported } msg
checked =
    M3e.Cem.MenuItemCheckbox.checked


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.MenuItemCheckbox.onClick


{-| Place content in the `icon` slot. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
icon el =
    M3e.Element.Internal.placeSlot "icon" el


{-| Place content in the `trailing-icon` slot. -}
trailingIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
trailingIcon el =
    M3e.Element.Internal.placeSlot "trailing-icon" el