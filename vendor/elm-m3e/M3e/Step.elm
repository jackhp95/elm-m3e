module M3e.Step exposing (completed, component, doneIconSlot, editIconSlot, editable, errorIconSlot, errorSlot, hintSlot, iconSlot, invalid, onBeforeinput, onChange, onClick, onInput, optional)

{-| 
A step in a wizard-like workflow.

## Component

@docs component

### Attributes

@docs completed, editable, optional, invalid

### Events

@docs onBeforeinput, onInput, onChange, onClick

### Slots

@docs iconSlot, doneIconSlot, editIconSlot, errorIconSlot, hintSlot, errorSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A step in a wizard-like workflow.

**Events:**
- `beforeinput`: Dispatched before the selected state changes.
- `input`: Dispatched when the selected state changes.
- `change`: Dispatched when the selected state changes.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders the icon of the step.
- `done-icon`: Renders the icon of a completed step.
- `edit-icon`: Renders the icon of a completed editable step.
- `error-icon`: Renders icon of an invalid step.
- `hint`: Renders the hint text of the step.
- `error`: Renders the error message for an invalid step.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-step" attributes children


{-| Whether the step has been completed. (default: `false`) -}
completed : Bool -> Html.Attribute msg
completed val_ =
    Html.Attributes.property "completed" (Json.Encode.bool val_)


{-| Whether the step is editable and users can return to it after completion. (default: `false`) -}
editable : Bool -> Html.Attribute msg
editable val_ =
    Html.Attributes.property "editable" (Json.Encode.bool val_)


{-| Whether the step is optional. (default: `false`) -}
optional : Bool -> Html.Attribute msg
optional val_ =
    Html.Attributes.property "optional" (Json.Encode.bool val_)


{-| Whether the step has an error. (default: `false`) -}
invalid : Bool -> Html.Attribute msg
invalid val_ =
    Html.Attributes.property "invalid" (Json.Encode.bool val_)


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


{-| Renders the icon of the step. -}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders the icon of a completed step. -}
doneIconSlot : Html.Attribute msg
doneIconSlot =
    Html.Attributes.attribute "slot" "done-icon"


{-| Renders the icon of a completed editable step. -}
editIconSlot : Html.Attribute msg
editIconSlot =
    Html.Attributes.attribute "slot" "edit-icon"


{-| Renders icon of an invalid step. -}
errorIconSlot : Html.Attribute msg
errorIconSlot =
    Html.Attributes.attribute "slot" "error-icon"


{-| Renders the hint text of the step. -}
hintSlot : Html.Attribute msg
hintSlot =
    Html.Attributes.attribute "slot" "hint"


{-| Renders the error message for an invalid step. -}
errorSlot : Html.Attribute msg
errorSlot =
    Html.Attributes.attribute "slot" "error"