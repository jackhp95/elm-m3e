module M3e.ExpandableListItem exposing (component, disabled, itemsSlot, leadingSlot, onClosed, onClosing, onOpened, onOpening, open, overlineSlot, supportingTextSlot, toggleIconSlot, trailingSlot)

{-| 
An item in a list that can be expanded to show more items.

## Component

@docs component

### Attributes

@docs disabled, open

### Events

@docs onOpening, onOpened, onClosing, onClosed

### Slots

@docs leadingSlot, overlineSlot, supportingTextSlot, toggleIconSlot, itemsSlot, trailingSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


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
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-expandable-list-item" attributes children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the item is expanded. (default: `false`) -}
open : Bool -> Html.Attribute msg
open val_ =
    Html.Attributes.property "open" (Json.Encode.bool val_)


{-| Dispatched when the item begins to open.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onOpening : Json.Decode.Decoder msg -> Html.Attribute msg
onOpening decoder =
    Html.Events.on "opening" decoder


{-| Dispatched when the item has opened.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onOpened : Json.Decode.Decoder msg -> Html.Attribute msg
onOpened decoder =
    Html.Events.on "opened" decoder


{-| Dispatched when the item begins to close.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClosing : Json.Decode.Decoder msg -> Html.Attribute msg
onClosing decoder =
    Html.Events.on "closing" decoder


{-| Dispatched when the item has closed.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClosed : Json.Decode.Decoder msg -> Html.Attribute msg
onClosed decoder =
    Html.Events.on "closed" decoder


{-| Renders the leading content of the list item. -}
leadingSlot : Html.Attribute msg
leadingSlot =
    Html.Attributes.attribute "slot" "leading"


{-| Renders the overline of the list item. -}
overlineSlot : Html.Attribute msg
overlineSlot =
    Html.Attributes.attribute "slot" "overline"


{-| Renders the supporting text of the list item. -}
supportingTextSlot : Html.Attribute msg
supportingTextSlot =
    Html.Attributes.attribute "slot" "supporting-text"


{-| Renders a custom icon for the expand/collapse toggle. -}
toggleIconSlot : Html.Attribute msg
toggleIconSlot =
    Html.Attributes.attribute "slot" "toggle-icon"


{-| Container for child list items displayed when expanded. -}
itemsSlot : Html.Attribute msg
itemsSlot =
    Html.Attributes.attribute "slot" "items"


{-| This component does not expose the base trailing slot. -}
trailingSlot : Html.Attribute msg
trailingSlot =
    Html.Attributes.attribute "slot" "trailing"