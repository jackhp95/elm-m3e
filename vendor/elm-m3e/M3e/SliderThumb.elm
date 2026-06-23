module M3e.SliderThumb exposing (component, name, onBeforeinput, onChange, onClick, onInput, onValueChange, value)

{-| 
A thumb used to select a value in a slider.

## Component

@docs component

### Attributes

@docs name, value

### Events

@docs onValueChange, onBeforeinput, onInput, onChange, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| A thumb used to select a value in a slider.

**Events:**
- `value-change`: No description
- `beforeinput`: Dispatched before the value changes.
- `input`: Dispatched when the value changes.
- `change`: Dispatched when the value changes.
- `click`: Dispatched when the element is clicked.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-slider-thumb" attributes children


{-| The name that identifies the element when submitting the associated form. -}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| The value of the thumb. (default: `null`) -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| Listen for `value-change` events.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onValueChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onValueChange : Json.Decode.Decoder msg -> Html.Attribute msg
onValueChange decoder =
    Html.Events.on "value-change" decoder


{-| Dispatched before the value changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the value changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Dispatched when the value changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched when the element is clicked.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder