module M3e.Html.ExpandableListItem exposing
    ( expandableListItem, disabled, open, onOpening, onOpened, onClosing
    , onClosed
    )

{-| Middle layer for `<m3e-expandable-list-item>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.ExpandableListItem` module for everyday use.

@docs expandableListItem, disabled, open, onOpening, onOpened, onClosing
@docs onClosed

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.ExpandableListItem
import M3e.Token


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
    List
        (M3e.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , open : M3e.Token.Supported
            , onOpening : M3e.Token.Supported
            , onOpened : M3e.Token.Supported
            , onClosing : M3e.Token.Supported
            , onClosed : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
expandableListItem attributes children =
    M3e.Raw.ExpandableListItem.expandableListItem
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> M3e.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.Attr.Internal.attribute M3e.Raw.ExpandableListItem.disabled


{-| Whether the item is expanded. (default: `false`)
-}
open : Bool -> M3e.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    M3e.Html.Attr.Internal.attribute M3e.Raw.ExpandableListItem.open


{-| Listen for `opening` events.
-}
onOpening : msg -> M3e.Html.Attr.Attr { c | onOpening : M3e.Token.Supported } msg
onOpening f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.ExpandableListItem.onOpening
        (Json.Decode.succeed f_)


{-| Listen for `opened` events.
-}
onOpened : msg -> M3e.Html.Attr.Attr { c | onOpened : M3e.Token.Supported } msg
onOpened f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.ExpandableListItem.onOpened
        (Json.Decode.succeed f_)


{-| Listen for `closing` events.
-}
onClosing : msg -> M3e.Html.Attr.Attr { c | onClosing : M3e.Token.Supported } msg
onClosing f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.ExpandableListItem.onClosing
        (Json.Decode.succeed f_)


{-| Listen for `closed` events.
-}
onClosed : msg -> M3e.Html.Attr.Attr { c | onClosed : M3e.Token.Supported } msg
onClosed f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.ExpandableListItem.onClosed
        (Json.Decode.succeed f_)
