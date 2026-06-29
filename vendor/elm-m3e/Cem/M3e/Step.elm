module Cem.M3e.Step exposing
    ( component, completed, disabled, editable, for, optional
    , selected, invalid, onBeforeinput, onInput, onChange, onClick
    , iconSlot, doneIconSlot, editIconSlot, errorIconSlot, hintSlot, errorSlot
    )

{-| A step in a wizard-like workflow.

@docs component, completed, disabled, editable, for, optional
@docs selected, invalid, onBeforeinput, onInput, onChange, onClick
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

**CSS Custom Properties:**

  - `--m3e-step-shape`: Border radius of the step container, defining its visual shape.
  - `--m3e-step-padding`: Internal padding of the step container, used for layout spacing.
  - `--m3e-step-icon-shape`: Border radius of the icon container, controlling its geometric form.
  - `--m3e-step-icon-size`: Width and height of the icon container and icon glyph.
  - `--m3e-step-selected-icon-container-color`: Background color of the icon when the step is selected.
  - `--m3e-step-selected-icon-color`: Foreground color of the icon when the step is selected.
  - `--m3e-step-completed-icon-container-color`: Background color of the icon when the step is completed.
  - `--m3e-step-completed-icon-color`: Foreground color of the icon when the step is completed.
  - `--m3e-step-unselected-icon-container-color`: Background color of the icon when the step is inactive.
  - `--m3e-step-unselected-icon-color`: Foreground color of the icon when the step is inactive.
  - `--m3e-step-icon-error-color`: Foreground color of the icon when the step is invalid.
  - `--m3e-step-disabled-icon-container-color`: Base color used to mix the disabled icon background.
  - `--m3e-step-disabled-icon-color`: Base color used to mix the disabled icon foreground.
  - `--m3e-step-label-color`: Text color of the step label in its default state.
  - `--m3e-step-label-error-color`: Text color of the step label when the step is invalid.
  - `--m3e-step-disabled-label-color`: Base color used to mix the disabled label foreground.
  - `--m3e-step-font-size`: Font size of the step label.
  - `--m3e-step-font-weight`: Font weight of the step label.
  - `--m3e-step-line-height`: Line height of the step label.
  - `--m3e-step-tracking`: Letter spacing of the step label.
  - `--m3e-step-icon-label-space`: Gap between icon and label.
  - `--m3e-step-hint-font-size`: Font size of hint and error messages.
  - `--m3e-step-hint-font-weight`: Font weight of hint and error messages.
  - `--m3e-step-hint-line-height`: Line height of hint and error messages.
  - `--m3e-step-hint-tracking`: Letter spacing of hint and error messages.
  - `--m3e-step-hint-color`: Text color of hint messages in valid state.
  - `--m3e-step-disabled-hint-color`: Base color used to mix the disabled hint foreground.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-step" attributes children


{-| Whether the step has been completed. (default: `false`)
-}
completed : Bool -> Html.Attribute msg
completed val_ =
    Html.Attributes.property "completed" (Json.Encode.bool val_)


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the step is editable and users can return to it after completion. (default: `false`)
-}
editable : Bool -> Html.Attribute msg
editable val_ =
    Html.Attributes.property "editable" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_


{-| Whether the step is optional. (default: `false`)
-}
optional : Bool -> Html.Attribute msg
optional val_ =
    Html.Attributes.property "optional" (Json.Encode.bool val_)


{-| Whether the element is selected. (default: `false`)
-}
selected : Bool -> Html.Attribute msg
selected =
    Html.Attributes.selected


{-| Whether the step has an error. (default: `false`)
-}
invalid : Bool -> Html.Attribute msg
invalid val_ =
    Html.Attributes.property "invalid" (Json.Encode.bool val_)


{-| Dispatched before the selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Dispatched when the selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

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


{-| Renders the icon of the step.
-}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders the icon of a completed step.
-}
doneIconSlot : Html.Attribute msg
doneIconSlot =
    Html.Attributes.attribute "slot" "done-icon"


{-| Renders the icon of a completed editable step.
-}
editIconSlot : Html.Attribute msg
editIconSlot =
    Html.Attributes.attribute "slot" "edit-icon"


{-| Renders icon of an invalid step.
-}
errorIconSlot : Html.Attribute msg
errorIconSlot =
    Html.Attributes.attribute "slot" "error-icon"


{-| Renders the hint text of the step.
-}
hintSlot : Html.Attribute msg
hintSlot =
    Html.Attributes.attribute "slot" "hint"


{-| Renders the error message for an invalid step.
-}
errorSlot : Html.Attribute msg
errorSlot =
    Html.Attributes.attribute "slot" "error"
