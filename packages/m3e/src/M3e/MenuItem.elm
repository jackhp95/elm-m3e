module M3e.MenuItem exposing
    ( view, disabled, download, href, rel, target
    , onClick, icon, trailingIcon
    )

{-|
An item of a menu.

**Component Info:**
- **Extends:** `MenuItemElementBase` from `/src/menu/MenuItemElementBase`

**Events:**
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders an icon before the items's label.
- `trailing-icon`: Renders an icon after the item's label.

@docs view, disabled, download, href, rel, target
@docs onClick, icon, trailingIcon
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.MenuItem
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-menu-item>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , download : M3e.Value.Supported
    , href : M3e.Value.Supported
    , rel : M3e.Value.Supported
    , target : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element { text : M3e.Value.Supported
    , dialogTrigger : M3e.Value.Supported
    , dialogAction : M3e.Value.Supported
    , menuTrigger : M3e.Value.Supported
    , fabMenuTrigger : M3e.Value.Supported
    , bottomSheetTrigger : M3e.Value.Supported
    , bottomSheetAction : M3e.Value.Supported
    , stepperPrevious : M3e.Value.Supported
    , stepperReset : M3e.Value.Supported
    , richTooltipAction : M3e.Value.Supported
    , drawerToggle : M3e.Value.Supported
    , datepickerToggle : M3e.Value.Supported
    , navRailToggle : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | menuItem : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.MenuItem.menuItem
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.MenuItem.disabled


{-| Whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`) -}
download :
    String -> M3e.Cem.Attr.Attr { c | download : M3e.Value.Supported } msg
download =
    M3e.Cem.MenuItem.download


{-| The URL to which the link button points. (default: `""`) -}
href : String -> M3e.Cem.Attr.Attr { c | href : M3e.Value.Supported } msg
href =
    M3e.Cem.MenuItem.href


{-| The relationship between the `target` of the link button and the document. (default: `""`) -}
rel : String -> M3e.Cem.Attr.Attr { c | rel : M3e.Value.Supported } msg
rel =
    M3e.Cem.MenuItem.rel


{-| The target of the link button. (default: `""`) -}
target : String -> M3e.Cem.Attr.Attr { c | target : M3e.Value.Supported } msg
target =
    M3e.Cem.MenuItem.target


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.MenuItem.onClick


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