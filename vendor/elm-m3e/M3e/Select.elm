module M3e.Select exposing
    ( component
    , required
    , onChange, onToggle, onBeforeinput, onInput
    , arrowSlot, valueSlot
    )

{-| A form control that allows users to select a value from a set of predefined options.


## Component

@docs component


### Attributes

@docs required


### Events

@docs onChange, onToggle, onBeforeinput, onInput


### Slots

@docs arrowSlot, valueSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A form control that allows users to select a value from a set of predefined options.

**Events:**

  - `change`: Dispatched when the selected state changes.
  - `toggle`: No description
  - `beforeinput`: Dispatched before the selected state changes.
  - `input`: Dispatched when the selected state changes.

**Slots:**

  - `arrow`: Renders the dropdown arrow.
  - `value`: Renders the selected value(s).

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-select" attributes children


{-| Whether the element is required. (default: `false`)
-}
required : Bool -> Html.Attribute msg
required val_ =
    Html.Attributes.property "required" (Json.Encode.bool val_)


{-| Dispatched when the selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Listen for `toggle` events.

**Payload type:** `ToggleEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle decoder =
    Html.Events.on "toggle" decoder


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


{-| Renders the dropdown arrow.
-}
arrowSlot : Html.Attribute msg
arrowSlot =
    Html.Attributes.attribute "slot" "arrow"


{-| Renders the selected value(s).
-}
valueSlot : Html.Attribute msg
valueSlot =
    Html.Attributes.attribute "slot" "value"
