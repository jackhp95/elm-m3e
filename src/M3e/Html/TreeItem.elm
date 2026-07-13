module M3e.Html.TreeItem exposing
    ( treeItem, disabled, indeterminate, open, selected, onOpening
    , onOpened, onClosing, onClosed, onClick
    )

{-| Middle layer for `<m3e-tree-item>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.TreeItem` module for everyday use.

@docs treeItem, disabled, indeterminate, open, selected, onOpening
@docs onOpened, onClosing, onClosed, onClick

-}

import Html
import Json.Decode
import M3e.Raw.TreeItem
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


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

-}
treeItem :
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
    -> List (Html.Html msg)
    -> Html.Html msg
treeItem attributes children =
    M3e.Raw.TreeItem.treeItem
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.TreeItem.disabled


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`)
-}
indeterminate :
    Bool
    -> Markup.Html.Attr.Attr { c | indeterminate : M3e.Token.Supported } msg
indeterminate =
    Markup.Html.Attr.Internal.attribute M3e.Raw.TreeItem.indeterminate


{-| Whether the item is expanded. (default: `false`)
-}
open : Bool -> Markup.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    Markup.Html.Attr.Internal.attribute M3e.Raw.TreeItem.open


{-| Whether the item is selected. (default: `false`)
-}
selected : Bool -> Markup.Html.Attr.Attr { c | selected : M3e.Token.Supported } msg
selected =
    Markup.Html.Attr.Internal.attribute M3e.Raw.TreeItem.selected


{-| Listen for `opening` events.
-}
onOpening : msg -> Markup.Html.Attr.Attr { c | onOpening : M3e.Token.Supported } msg
onOpening f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.TreeItem.onOpening
        (Json.Decode.succeed f_)


{-| Listen for `opened` events.
-}
onOpened : msg -> Markup.Html.Attr.Attr { c | onOpened : M3e.Token.Supported } msg
onOpened f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.TreeItem.onOpened
        (Json.Decode.succeed f_)


{-| Listen for `closing` events.
-}
onClosing : msg -> Markup.Html.Attr.Attr { c | onClosing : M3e.Token.Supported } msg
onClosing f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.TreeItem.onClosing
        (Json.Decode.succeed f_)


{-| Listen for `closed` events.
-}
onClosed : msg -> Markup.Html.Attr.Attr { c | onClosed : M3e.Token.Supported } msg
onClosed f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.TreeItem.onClosed
        (Json.Decode.succeed f_)


{-| Listen for `click` events.
-}
onClick : msg -> Markup.Html.Attr.Attr { c | onClick : M3e.Token.Supported } msg
onClick f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.TreeItem.onClick
        (Json.Decode.succeed f_)
