module M3e.ListOption exposing (component, leadingSlot, onBeforeinput, onChange, onClick, onInput, overlineSlot, supportingTextSlot, trailingSlot, value)

{-| 
A selectable option in a list.

## Component

@docs component

### Attributes

@docs value

### Events

@docs onBeforeinput, onInput, onChange, onClick

### Slots

@docs leadingSlot, overlineSlot, supportingTextSlot, trailingSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| A selectable option in a list.

**Component Info:**
- **Extends:** `M3eListItemElement` from `/src/list/ListItemElement`

**Events:**
- `beforeinput`: Dispatched before the selected state changes.
- `input`: Dispatched when the selected state changes.
- `change`: Dispatched when the selected state changes.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `leading`: Renders the leading content of the list item.
- `overline`: Renders the overline of the list item.
- `supporting-text`: Renders the supporting text of the list item.
- `trailing`: Renders the trailing content of the list item.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-list-option" attributes children


{-| A string representing the value of the option. -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


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


{-| Renders the trailing content of the list item. -}
trailingSlot : Html.Attribute msg
trailingSlot =
    Html.Attributes.attribute "slot" "trailing"