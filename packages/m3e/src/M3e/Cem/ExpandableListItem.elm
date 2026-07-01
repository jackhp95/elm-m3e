module M3e.Cem.ExpandableListItem exposing (disabled, expandableListItem, onClosed, onClosing, onOpened, onOpening, open)

{-| 
@docs expandableListItem, disabled, open, onOpening, onOpened, onClosing, onClosed
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.ExpandableListItem
import M3e.Value


{-| An item in a list that can be expanded to show more items.

**Component Info:**
- **Extends:** `M3eListItemElement` from `/src/list/ListItemElement`

**Events:**
- `opening`: Dispatched when the item begins to open.
- `opened`: Dispatched when the item has opened.
- `closing`: Dispatched when the item begins to close.
- `closed`: Dispatched when the item has closed.

**Slots:**
- `leading`: Renders the leading content of the list item.
- `overline`: Renders the overline of the list item.
- `supporting-text`: Renders the supporting text of the list item.
- `toggle-icon`: Renders a custom icon for the expand/collapse toggle.
- `items`: Container for child list items displayed when expanded.
- `trailing`: This component does not expose the base trailing slot.
-}
expandableListItem :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , open : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
expandableListItem attributes children =
    M3e.Cem.Html.ExpandableListItem.expandableListItem
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ExpandableListItem.disabled


{-| Whether the item is expanded. (default: `false`) -}
open : Bool -> M3e.Cem.Attr.Attr { c | open : M3e.Value.Supported } msg
open =
    M3e.Cem.Attr.attribute M3e.Cem.Html.ExpandableListItem.open


{-| Listen for `opening` events. -}
onOpening : msg -> M3e.Cem.Attr.Attr { c | onOpening : M3e.Value.Supported } msg
onOpening f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.ExpandableListItem.onOpening
        (Json.Decode.succeed f_)


{-| Listen for `opened` events. -}
onOpened : msg -> M3e.Cem.Attr.Attr { c | onOpened : M3e.Value.Supported } msg
onOpened f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.ExpandableListItem.onOpened
        (Json.Decode.succeed f_)


{-| Listen for `closing` events. -}
onClosing : msg -> M3e.Cem.Attr.Attr { c | onClosing : M3e.Value.Supported } msg
onClosing f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.ExpandableListItem.onClosing
        (Json.Decode.succeed f_)


{-| Listen for `closed` events. -}
onClosed : msg -> M3e.Cem.Attr.Attr { c | onClosed : M3e.Value.Supported } msg
onClosed f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.ExpandableListItem.onClosed
        (Json.Decode.succeed f_)