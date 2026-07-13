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

import M3e.Html.TreeItem
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-tree-item>` element (lazy IR).
-}
view :
    { label :
        Markup.Element.Element
            { sharedText : Markup.Kind.Shared
            , sharedLink : Markup.Kind.Shared
            }
            msg
    }
    ->
        List
            (Markup.Html.Attr.Attr
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
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | treeItem : M3e.Kind.Brand } msg
view req_ attributes content_ =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.TreeItem.treeItem
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.append
                [ Markup.Element.toNode
                    (Markup.Element.withSlot "label" req_.label)
                ]
                (List.map Markup.Element.toNode content_)
            )
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.TreeItem.disabled


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`)
-}
indeterminate :
    Bool
    -> Markup.Html.Attr.Attr { c | indeterminate : M3e.Token.Supported } msg
indeterminate =
    M3e.Html.TreeItem.indeterminate


{-| Whether the item is expanded. (default: `false`)
-}
open : Bool -> Markup.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    M3e.Html.TreeItem.open


{-| Whether the item is selected. (default: `false`)
-}
selected : Bool -> Markup.Html.Attr.Attr { c | selected : M3e.Token.Supported } msg
selected =
    M3e.Html.TreeItem.selected


{-| Listen for `opening` events.
-}
onOpening : msg -> Markup.Html.Attr.Attr { c | onOpening : M3e.Token.Supported } msg
onOpening =
    M3e.Html.TreeItem.onOpening


{-| Listen for `opened` events.
-}
onOpened : msg -> Markup.Html.Attr.Attr { c | onOpened : M3e.Token.Supported } msg
onOpened =
    M3e.Html.TreeItem.onOpened


{-| Listen for `closing` events.
-}
onClosing : msg -> Markup.Html.Attr.Attr { c | onClosing : M3e.Token.Supported } msg
onClosing =
    M3e.Html.TreeItem.onClosing


{-| Listen for `closed` events.
-}
onClosed : msg -> Markup.Html.Attr.Attr { c | onClosed : M3e.Token.Supported } msg
onClosed =
    M3e.Html.TreeItem.onClosed


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick =
    M3e.Html.TreeItem.onClick


{-| Place content in the `icon` slot.
-}
icon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
icon el =
    Markup.Element.Internal.placeSlot "icon" el


{-| Place content in the `selected-icon` slot.
-}
selectedIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
selectedIcon el =
    Markup.Element.Internal.placeSlot "selected-icon" el


{-| Place content in the `toggle-icon` slot.
-}
toggleIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
toggleIcon el =
    Markup.Element.Internal.placeSlot "toggle-icon" el


{-| Place content in the `open-toggle-icon` slot.
-}
openToggleIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
openToggleIcon el =
    Markup.Element.Internal.placeSlot "open-toggle-icon" el
