module M3e.Stepper exposing
    ( component
    , labelPosition, linear
    , onChange, onBeforeinput, onInput
    , stepSlot, panelSlot
    )

{-| Provides a wizard-like workflow by dividing content into logical steps.


## Component

@docs component


### Attributes

@docs labelPosition, linear


### Events

@docs onChange, onBeforeinput, onInput


### Slots

@docs stepSlot, panelSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Provides a wizard-like workflow by dividing content into logical steps.

**Events:**

  - `change`: Dispatched when the selected step changes.
  - `beforeinput`: Dispatched before the selected state of a step changes.
  - `input`: Dispatched when the selected state of a step changes.

**Slots:**

  - `step`: Renders a step.
  - `panel`: Renders a panel.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-stepper" attributes children


{-| The position of the step labels, when oriented horizontally. (default: `"end"`)
-}
labelPosition : String -> Html.Attribute msg
labelPosition val_ =
    Html.Attributes.attribute "label-position" val_


{-| Whether the validity of previous steps should be checked or not. (default: `false`)
-}
linear : Bool -> Html.Attribute msg
linear val_ =
    Html.Attributes.property "linear" (Json.Encode.bool val_)


{-| Dispatched when the selected step changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched before the selected state of a step changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged M3e.Common.targetValue)`.

-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the selected state of a step changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged M3e.Common.targetValue)`.

-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Renders a step.
-}
stepSlot : Html.Attribute msg
stepSlot =
    Html.Attributes.attribute "slot" "step"


{-| Renders a panel.
-}
panelSlot : Html.Attribute msg
panelSlot =
    Html.Attributes.attribute "slot" "panel"
