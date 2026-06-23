module M3e.NavMenuItem exposing (badgeSlot, component, disabled, iconSlot, labelSlot, onClick, onClosed, onClosing, onOpened, onOpening, open, selected, selectedIconSlot, toggleIconSlot)

{-| 
An expandable item, selectable item within a navigation menu.

## Component

@docs component

### Attributes

@docs disabled, open, selected

### Events

@docs onOpening, onOpened, onClosing, onClosed, onClick

### Slots

@docs labelSlot, iconSlot, badgeSlot, selectedIconSlot, toggleIconSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


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
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-nav-menu-item" attributes children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the item is expanded. (default: `false`) -}
open : Bool -> Html.Attribute msg
open val_ =
    Html.Attributes.property "open" (Json.Encode.bool val_)


{-| Whether the item is selected. (default: `false`) -}
selected : Bool -> Html.Attribute msg
selected =
    Html.Attributes.selected


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


{-| Dispatched when the element is clicked.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders the label of the item. -}
labelSlot : Html.Attribute msg
labelSlot =
    Html.Attributes.attribute "slot" "label"


{-| Renders the icon of the item. -}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders the badge of the item. -}
badgeSlot : Html.Attribute msg
badgeSlot =
    Html.Attributes.attribute "slot" "badge"


{-| Renders the icon of the item when selected. -}
selectedIconSlot : Html.Attribute msg
selectedIconSlot =
    Html.Attributes.attribute "slot" "selected-icon"


{-| Renders the toggle icon. -}
toggleIconSlot : Html.Attribute msg
toggleIconSlot =
    Html.Attributes.attribute "slot" "toggle-icon"