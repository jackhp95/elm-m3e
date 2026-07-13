module M3e.ExpandableListItem exposing
    ( view, disabled, open, onOpening, onOpened, onClosing
    , onClosed, leading, overline, supportingText, toggleIcon, items
    )

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

@docs view, disabled, open, onOpening, onOpened, onClosing
@docs onClosed, leading, overline, supportingText, toggleIcon, items

-}

import M3e.Html.ExpandableListItem
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-expandable-list-item>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
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
    ->
        List
            (Markup.Element.Element
                { sharedText : Markup.Kind.Shared
                , html : M3e.Kind.Brand
                }
                msg
            )
    -> Markup.Element.Element { s | expandableListItem : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.ExpandableListItem.expandableListItem
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.ExpandableListItem.disabled


{-| Whether the item is expanded. (default: `false`)
-}
open : Bool -> Markup.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    M3e.Html.ExpandableListItem.open


{-| Listen for `opening` events.
-}
onOpening : msg -> Markup.Html.Attr.Attr { c | onOpening : M3e.Token.Supported } msg
onOpening =
    M3e.Html.ExpandableListItem.onOpening


{-| Listen for `opened` events.
-}
onOpened : msg -> Markup.Html.Attr.Attr { c | onOpened : M3e.Token.Supported } msg
onOpened =
    M3e.Html.ExpandableListItem.onOpened


{-| Listen for `closing` events.
-}
onClosing : msg -> Markup.Html.Attr.Attr { c | onClosing : M3e.Token.Supported } msg
onClosing =
    M3e.Html.ExpandableListItem.onClosing


{-| Listen for `closed` events.
-}
onClosed : msg -> Markup.Html.Attr.Attr { c | onClosed : M3e.Token.Supported } msg
onClosed =
    M3e.Html.ExpandableListItem.onClosed


{-| Place content in the `leading` slot.
-}
leading :
    Markup.Element.Element
        { sharedIcon : Markup.Kind.Shared
        , avatar : M3e.Kind.Brand
        , sharedText : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
leading el =
    Markup.Element.Internal.placeSlot "leading" el


{-| Place content in the `overline` slot.
-}
overline :
    Markup.Element.Element
        { sharedText : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
overline el =
    Markup.Element.Internal.placeSlot "overline" el


{-| Place content in the `supporting-text` slot.
-}
supportingText :
    Markup.Element.Element
        { sharedText : Markup.Kind.Shared
        , html : M3e.Kind.Brand
        }
        msg
    -> Markup.Element.Element k msg
supportingText el =
    Markup.Element.Internal.placeSlot "supporting-text" el


{-| Place content in the `toggle-icon` slot.
-}
toggleIcon :
    Markup.Element.Element { sharedIcon : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
toggleIcon el =
    Markup.Element.Internal.placeSlot "toggle-icon" el


{-| Place content in the `items` slot.
-}
items : Markup.Element.Element any msg -> Markup.Element.Element k msg
items el =
    Markup.Element.Internal.placeSlot "items" el
