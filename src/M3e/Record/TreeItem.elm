module M3e.Record.TreeItem exposing
    ( view, disabled, indeterminate, open, selected, onOpening
    , onOpened, onClosing, onClosed, onClick, icon, selectedIcon
    , toggleIcon, openToggleIcon
    )

{-| An expandable item in a tree.

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
  - `selected-icon`: Renders the icon of the item when selected.
  - `toggle-icon`: Renders the toggle icon.
  - `open-toggle-icon`: Renders the toggle icon when selected.

@docs view, disabled, indeterminate, open, selected, onOpening
@docs onOpened, onClosing, onClosed, onClick, icon, selectedIcon
@docs toggleIcon, openToggleIcon

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.TreeItem
import M3e.Node
import M3e.Token


{-| Build the `<m3e-tree-item>` element (lazy IR).
-}
view :
    { label :
        M3e.Element.Element
            { text : M3e.Token.Supported
            , link : M3e.Token.Supported
            }
            msg
    }
    ->
        List
            (M3e.Html.Attr.Attr
                { disabled : M3e.Token.Supported
                , indeterminate : M3e.Token.Supported
                , open : M3e.Token.Supported
                , selected : M3e.Token.Supported
                , onOpening : M3e.Token.Supported
                , onOpened : M3e.Token.Supported
                , onClosing : M3e.Token.Supported
                , onClosed : M3e.Token.Supported
                , onClick : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | treeItem : M3e.Token.Supported } msg
view req_ attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.TreeItem.treeItem
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.append
                [ M3e.Element.toNode (M3e.Element.withSlot "label" req_.label)
                ]
                (List.map M3e.Element.toNode content_)
            )
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.TreeItem.disabled


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`)
-}
indeterminate : Bool -> M3e.Html.Attr.Attr { c | indeterminate : M3e.Token.Supported } msg
indeterminate =
    M3e.Html.TreeItem.indeterminate


{-| Whether the item is expanded. (default: `false`)
-}
open : Bool -> M3e.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    M3e.Html.TreeItem.open


{-| Whether the item is selected. (default: `false`)
-}
selected : Bool -> M3e.Html.Attr.Attr { c | selected : M3e.Token.Supported } msg
selected =
    M3e.Html.TreeItem.selected


{-| Listen for `opening` events.
-}
onOpening : msg -> M3e.Html.Attr.Attr { c | onOpening : M3e.Token.Supported } msg
onOpening =
    M3e.Html.TreeItem.onOpening


{-| Listen for `opened` events.
-}
onOpened : msg -> M3e.Html.Attr.Attr { c | onOpened : M3e.Token.Supported } msg
onOpened =
    M3e.Html.TreeItem.onOpened


{-| Listen for `closing` events.
-}
onClosing : msg -> M3e.Html.Attr.Attr { c | onClosing : M3e.Token.Supported } msg
onClosing =
    M3e.Html.TreeItem.onClosing


{-| Listen for `closed` events.
-}
onClosed : msg -> M3e.Html.Attr.Attr { c | onClosed : M3e.Token.Supported } msg
onClosed =
    M3e.Html.TreeItem.onClosed


{-| Listen for `click` events.
-}
onClick : msg -> M3e.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.TreeItem.onClick


{-| Place content in the `icon` slot.
-}
icon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
icon el =
    M3e.Element.Internal.placeSlot "icon" el


{-| Place content in the `selected-icon` slot.
-}
selectedIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
selectedIcon el =
    M3e.Element.Internal.placeSlot "selected-icon" el


{-| Place content in the `toggle-icon` slot.
-}
toggleIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
toggleIcon el =
    M3e.Element.Internal.placeSlot "toggle-icon" el


{-| Place content in the `open-toggle-icon` slot.
-}
openToggleIcon :
    M3e.Element.Element { icon : M3e.Token.Supported } msg
    -> M3e.Element.Element k msg
openToggleIcon el =
    M3e.Element.Internal.placeSlot "open-toggle-icon" el
