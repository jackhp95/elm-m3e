module Cem.M3e.Stepper exposing
    ( component, headerPosition, labelPosition, linear, orientation, selectedindex
    , onChange, onBeforeinput, onInput, stepSlot, panelSlot
    )

{-| Provides a wizard-like workflow by dividing content into logical steps.

@docs component, headerPosition, labelPosition, linear, orientation, selectedindex
@docs onChange, onBeforeinput, onInput, stepSlot, panelSlot

-}

import Cem.M3e.Common
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

**CSS Custom Properties:**

  - `--m3e-step-divider-thickness`: Thickness of the divider line between steps.
  - `--m3e-step-divider-color`: Color of the divider line between steps.
  - `--m3e-step-divider-inset`: Inset offset for divider alignment within step layout.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-stepper" attributes children


{-| The position of the step header, when oriented horizontally. (default: `"above"`)
-}
headerPosition :
    Cem.M3e.Common.Value
        { above : Cem.M3e.Common.Supported
        , below : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
headerPosition =
    Cem.M3e.Common.headerPosition


{-| The position of the step labels, when oriented horizontally. (default: `"end"`)
-}
labelPosition :
    Cem.M3e.Common.Value
        { below : Cem.M3e.Common.Supported
        , end : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
labelPosition =
    Cem.M3e.Common.labelPosition


{-| Whether the validity of previous steps should be checked or not. (default: `false`)
-}
linear : Bool -> Html.Attribute msg
linear val_ =
    Html.Attributes.property "linear" (Json.Encode.bool val_)


{-| The orientation of the stepper. (default: `"horizontal"`)
-}
orientation :
    Cem.M3e.Common.Value
        { auto : Cem.M3e.Common.Supported
        , horizontal : Cem.M3e.Common.Supported
        , vertical : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
orientation =
    Cem.M3e.Common.orientation


{-| The zero-based index of the selected step.
-}
selectedindex : Float -> Html.Attribute msg
selectedindex val_ =
    Html.Attributes.property "selectedIndex" (Json.Encode.float val_)


{-| Dispatched when the selected step changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched before the selected state of a step changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the selected state of a step changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

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
