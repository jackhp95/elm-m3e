module M3e.TreeItem exposing
    ( component
    , open
    , onOpening, onOpened, onClosing, onClosed, onClick
    , labelSlot, iconSlot, selectedIconSlot, toggleIconSlot, openToggleIconSlot
    )

{-| An expandable item in a tree.


## Component

@docs component


### Attributes

@docs open


### Events

@docs onOpening, onOpened, onClosing, onClosed, onClick


### Slots

@docs labelSlot, iconSlot, selectedIconSlot, toggleIconSlot, openToggleIconSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| An expandable item in a tree.

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
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-tree-item" attributes children


{-| Whether the item is expanded. (default: `false`)
-}
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


{-| Dispatched when the element is clicked.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders the label of the item.
-}
labelSlot : Html.Attribute msg
labelSlot =
    Html.Attributes.attribute "slot" "label"


{-| Renders the icon of the item.
-}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders the icon of the item when selected.
-}
selectedIconSlot : Html.Attribute msg
selectedIconSlot =
    Html.Attributes.attribute "slot" "selected-icon"


{-| Renders the toggle icon.
-}
toggleIconSlot : Html.Attribute msg
toggleIconSlot =
    Html.Attributes.attribute "slot" "toggle-icon"


{-| Renders the toggle icon when selected.
-}
openToggleIconSlot : Html.Attribute msg
openToggleIconSlot =
    Html.Attributes.attribute "slot" "open-toggle-icon"
