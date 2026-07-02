module M3e.TreeItem exposing
    ( view, disabled, indeterminate, open, selected, onOpening
    , onOpened, onClosing, onClosed, onClick, child, icon, selectedIcon
    , toggleIcon, openToggleIcon, children
    )

{-|
An expandable item in a tree.

**Events:**
- `opening`: Dispatched when the item begins to open.
- `opened`: Dispatched when the item has opened.
- `closing`: Dispatched when the item begins to close.
- `closed`: Dispatched when the item has closed.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `label`: Renders the label of the item.
- `icon`: Renders the icon of the item.
- `selected-icon`: Renders the icon of the item when selected.
- `toggle-icon`: Renders the toggle icon.
- `open-toggle-icon`: Renders the toggle icon when selected.

@docs view, disabled, indeterminate, open, selected, onOpening
@docs onOpened, onClosing, onClosed, onClick, child, icon
@docs selectedIcon, toggleIcon, openToggleIcon, children
-}


import M3e.Cem.Attr
import M3e.Cem.TreeItem
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-tree-item>` element (lazy IR). -}
view :
    { label :
        M3e.Element.Element { text : M3e.Value.Supported
        , link : M3e.Value.Supported
        } msg
    }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , indeterminate : M3e.Value.Supported
    , open : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , selectedIcon : M3e.Value.Supported
    , toggleIcon : M3e.Value.Supported
    , openToggleIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | treeItem : M3e.Value.Supported } msg
view req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.TreeItem.treeItem
                      (List.map M3e.Cem.Attr.forget erased)
                      ch
             )
             (List.append
                  []
                  (List.append [] (List.map M3e.Cem.Attr.forget attributes))
             )
             (List.append
                  [ M3e.Element.toNode (M3e.Element.withSlot "label" req_.label)
                  ]
                  (List.map M3e.Content.toNode content_)
             )
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.TreeItem.disabled


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`) -}
indeterminate :
    Bool -> M3e.Cem.Attr.Attr { c | indeterminate : M3e.Value.Supported } msg
indeterminate =
    M3e.Cem.TreeItem.indeterminate


{-| Whether the item is expanded. (default: `false`) -}
open : Bool -> M3e.Cem.Attr.Attr { c | open : M3e.Value.Supported } msg
open =
    M3e.Cem.TreeItem.open


{-| Whether the item is selected. (default: `false`) -}
selected : Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
selected =
    M3e.Cem.TreeItem.selected


{-| Listen for `opening` events. -}
onOpening : msg -> M3e.Cem.Attr.Attr { c | onOpening : M3e.Value.Supported } msg
onOpening =
    M3e.Cem.TreeItem.onOpening


{-| Listen for `opened` events. -}
onOpened : msg -> M3e.Cem.Attr.Attr { c | onOpened : M3e.Value.Supported } msg
onOpened =
    M3e.Cem.TreeItem.onOpened


{-| Listen for `closing` events. -}
onClosing : msg -> M3e.Cem.Attr.Attr { c | onClosing : M3e.Value.Supported } msg
onClosing =
    M3e.Cem.TreeItem.onClosing


{-| Listen for `closed` events. -}
onClosed : msg -> M3e.Cem.Attr.Attr { c | onClosed : M3e.Value.Supported } msg
onClosed =
    M3e.Cem.TreeItem.onClosed


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick =
    M3e.Cem.TreeItem.onClick


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element { treeItem : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place content in the `icon` slot. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
icon el =
    M3e.Content.slot "icon" el


{-| Place content in the `selected-icon` slot. -}
selectedIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | selectedIcon : M3e.Value.Supported } msg
selectedIcon el =
    M3e.Content.slot "selected-icon" el


{-| Place content in the `toggle-icon` slot. -}
toggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | toggleIcon : M3e.Value.Supported } msg
toggleIcon el =
    M3e.Content.slot "toggle-icon" el


{-| Place content in the `open-toggle-icon` slot. -}
openToggleIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | openToggleIcon : M3e.Value.Supported } msg
openToggleIcon el =
    M3e.Content.slot "open-toggle-icon" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element { treeItem : M3e.Value.Supported } msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els