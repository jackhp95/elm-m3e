module M3e.Cem.NavMenuItem exposing (disabled, navMenuItem, onClick, onClosed, onClosing, onOpened, onOpening, open, selected)

{-| 
@docs navMenuItem, disabled, open, selected, onOpening, onOpened, onClosing, onClosed, onClick
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.NavMenuItem
import M3e.Value


{-| An expandable item, selectable item within a navigation menu.

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
-}
navMenuItem :
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
    -> List (Html.Html msg)
    -> Html.Html msg
navMenuItem attributes children =
    M3e.Cem.Html.NavMenuItem.navMenuItem
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.NavMenuItem.disabled


{-| Whether the item is expanded. (default: `false`) -}
open : Bool -> M3e.Cem.Attr.Attr { c | open : M3e.Value.Supported } msg
open =
    M3e.Cem.Attr.attribute M3e.Cem.Html.NavMenuItem.open


{-| Whether the item is selected. (default: `false`) -}
selected : Bool -> M3e.Cem.Attr.Attr { c | selected : M3e.Value.Supported } msg
selected =
    M3e.Cem.Attr.attribute M3e.Cem.Html.NavMenuItem.selected


{-| Listen for `opening` events. -}
onOpening : msg -> M3e.Cem.Attr.Attr { c | onOpening : M3e.Value.Supported } msg
onOpening f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.NavMenuItem.onOpening
        (Json.Decode.succeed f_)


{-| Listen for `opened` events. -}
onOpened : msg -> M3e.Cem.Attr.Attr { c | onOpened : M3e.Value.Supported } msg
onOpened f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.NavMenuItem.onOpened
        (Json.Decode.succeed f_)


{-| Listen for `closing` events. -}
onClosing : msg -> M3e.Cem.Attr.Attr { c | onClosing : M3e.Value.Supported } msg
onClosing f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.NavMenuItem.onClosing
        (Json.Decode.succeed f_)


{-| Listen for `closed` events. -}
onClosed : msg -> M3e.Cem.Attr.Attr { c | onClosed : M3e.Value.Supported } msg
onClosed f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.NavMenuItem.onClosed
        (Json.Decode.succeed f_)


{-| Listen for `click` events. -}
onClick : msg -> M3e.Cem.Attr.Attr { c | onClick : M3e.Value.Supported } msg
onClick f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.NavMenuItem.onClick
        (Json.Decode.succeed f_)