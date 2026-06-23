module M3e.NavItem exposing (Orientation(..), component, iconSlot, onBeforeinput, onChange, onClick, onInput, orientation, selectedIconSlot)

{-| 
An item, placed in a navigation bar or rail, used to navigate to destinations in an application.

## Component

@docs component

### Attributes

@docs Orientation, orientation

### Events

@docs onBeforeinput, onInput, onChange, onClick

### Slots

@docs iconSlot, selectedIconSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| An item, placed in a navigation bar or rail, used to navigate to destinations in an application.

**Events:**
- `beforeinput`: Dispatched before the selected state changes.
- `input`: Dispatched when the selected state changes.
- `change`: Dispatched when the selected state changes.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders the icon of the item.
- `selected-icon`: Renders the icon of the item when selected.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-nav-item" attributes children


{-| Values for the `orientation` attribute. -}
type Orientation
    = Horizontal
    | Vertical


{-| The layout orientation of the item. (default: `"vertical"`) -}
orientation : Orientation -> Html.Attribute msg
orientation val_ =
    Html.Attributes.attribute "orientation" (orientationToString val_)


orientationToString : Orientation -> String
orientationToString val_ =
    case val_ of
        Horizontal ->
            "horizontal"
    
        Vertical ->
            "vertical"


{-| Dispatched before the selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Dispatched when the selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched when the element is clicked.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders the icon of the item. -}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders the icon of the item when selected. -}
selectedIconSlot : Html.Attribute msg
selectedIconSlot =
    Html.Attributes.attribute "slot" "selected-icon"