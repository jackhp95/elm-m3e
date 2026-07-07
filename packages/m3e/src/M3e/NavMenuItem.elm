module M3e.NavMenuItem exposing
    ( view, disabled, open, selected, onOpening, onOpened
    , onClosing, onClosed, onClick, label, icon, badge, selectedIcon
    , toggleIcon
    )

{-|
An expandable item, selectable item within a navigation menu.

**Component Info:**
- **Extends:** `LitElement`

**Events:**
- `opening`: Dispatched when the item begins to open.
- `opened`: Dispatched when the item has opened.
- `closing`: Dispatched when the item begins to close.
- `closed`: Dispatched when the item has closed.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `label`: Renders the label of the item.
- `icon`: Renders the icon of the item.
- `badge`: Renders the badge of the item.
- `selected-icon`: Renders the icon of the item when selected.
- `toggle-icon`: Renders the toggle icon.

@docs view, disabled, open, selected, onOpening, onOpened
@docs onClosing, onClosed, onClick, label, icon, badge
@docs selectedIcon, toggleIcon
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.NavMenuItem
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-nav-menu-item>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , open : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element { navMenuItem : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | navMenuItem : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.NavMenuItem.navMenuItem
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.NavMenuItem.disabled


{-| Whether the item is expanded. (default: `false`) -}
open : Bool -> M3e.Cem.Attr.Attr { c | open : M3e.Value.Supported } msg
open =
    M3e.Cem.NavMenuItem.open


{-| Whether the item is selected. (default: `false`) -}
selected : Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
selected =
    M3e.Cem.NavMenuItem.selected


{-| Listen for `opening` events. -}
onOpening : msg -> M3e.Cem.Attr.Attr { c | onOpening : M3e.Value.Supported } msg
onOpening =
    M3e.Cem.NavMenuItem.onOpening


{-| Listen for `opened` events. -}
onOpened : msg -> M3e.Cem.Attr.Attr { c | onOpened : M3e.Value.Supported } msg
onOpened =
    M3e.Cem.NavMenuItem.onOpened


{-| Listen for `closing` events. -}
onClosing : msg -> M3e.Cem.Attr.Attr { c | onClosing : M3e.Value.Supported } msg
onClosing =
    M3e.Cem.NavMenuItem.onClosing


{-| Listen for `closed` events. -}
onClosed : msg -> M3e.Cem.Attr.Attr { c | onClosed : M3e.Value.Supported } msg
onClosed =
    M3e.Cem.NavMenuItem.onClosed


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.NavMenuItem.onClick


{-| Place content in the `label` slot. -}
label :
    M3e.Element.Element { text : M3e.Value.Supported
    , link : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
label el =
    M3e.Element.Internal.placeSlot "label" el


{-| Place content in the `icon` slot. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
icon el =
    M3e.Element.Internal.placeSlot "icon" el


{-| Place content in the `badge` slot. -}
badge :
    M3e.Element.Element { text : M3e.Value.Supported
    , badge : M3e.Value.Supported
    } msg
    -> M3e.Element.Element k msg
badge el =
    M3e.Element.Internal.placeSlot "badge" el


{-| Place content in the `selected-icon` slot. -}
selectedIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
selectedIcon el =
    M3e.Element.Internal.placeSlot "selected-icon" el


{-| Place content in the `toggle-icon` slot. -}
toggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Element.Element k msg
toggleIcon el =
    M3e.Element.Internal.placeSlot "toggle-icon" el