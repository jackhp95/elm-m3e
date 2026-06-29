module Cem.M3e.Select exposing
    ( component, disabled, hideSelectionIndicator, multi, name, panelClass
    , required, shouldlabelfloat, dirty, pristine, touched, untouched
    , willvalidate, validationmessage, onChange, onToggle, onBeforeinput, onInput
    , arrowSlot, valueSlot
    )

{-| A form control that allows users to select a value from a set of predefined options.

@docs component, disabled, hideSelectionIndicator, multi, name, panelClass
@docs required, shouldlabelfloat, dirty, pristine, touched, untouched
@docs willvalidate, validationmessage, onChange, onToggle, onBeforeinput, onInput
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

**CSS Custom Properties:**

  - `--m3e-form-field-font-size`: The font size of the select control.
  - `--m3e-form-field-font-weight`: The font weight of the select control.
  - `--m3e-form-field-line-height`: The line height of the select control.
  - `--m3e-form-field-tracking`: The letter spacing of the select control.
  - `--m3e-select-container-shape`: The corner radius of the select container.
  - `--m3e-select-disabled-color`: The text color when the select is disabled.
  - `--m3e-select-disabled-color-opacity`: The opacity level applied to the disabled text color.
  - `--m3e-select-icon-size`: The size of the dropdown arrow icon.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-select" attributes children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether to hide the selection indicator for single select options. (default: `false`)
-}
hideSelectionIndicator : Bool -> Html.Attribute msg
hideSelectionIndicator val_ =
    Html.Attributes.property "hide-selection-indicator" (Json.Encode.bool val_)


{-| Whether multiple options can be selected. (default: `false`)
-}
multi : Bool -> Html.Attribute msg
multi val_ =
    Html.Attributes.property "multi" (Json.Encode.bool val_)


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| Class or list of classes to be applied to the select's overlay panel. (default: `""`)
-}
panelClass : String -> Html.Attribute msg
panelClass val_ =
    Html.Attributes.attribute "panel-class" val_


{-| Whether the element is required. (default: `false`)
-}
required : Bool -> Html.Attribute msg
required val_ =
    Html.Attributes.property "required" (Json.Encode.bool val_)


{-| Set the `shouldLabelFloat` property.
-}
shouldlabelfloat : Bool -> Html.Attribute msg
shouldlabelfloat val_ =
    Html.Attributes.property "shouldLabelFloat" (Json.Encode.bool val_)


{-| Whether the user has modified the value of the element.
-}
dirty : Bool -> Html.Attribute msg
dirty val_ =
    Html.Attributes.property "dirty" (Json.Encode.bool val_)


{-| Whether the user has not modified the value of the element.
-}
pristine : Bool -> Html.Attribute msg
pristine val_ =
    Html.Attributes.property "pristine" (Json.Encode.bool val_)


{-| Whether the user has interacted when the element.
-}
touched : Bool -> Html.Attribute msg
touched val_ =
    Html.Attributes.property "touched" (Json.Encode.bool val_)


{-| Whether the user has not interacted when the element.
-}
untouched : Bool -> Html.Attribute msg
untouched val_ =
    Html.Attributes.property "untouched" (Json.Encode.bool val_)


{-| Whether the element is a submittable element that is a candidate for constraint validation.
-}
willvalidate : Bool -> Html.Attribute msg
willvalidate val_ =
    Html.Attributes.property "willValidate" (Json.Encode.bool val_)


{-| The error message that would be displayed if the user submits the form, or an empty string if no error message.
-}
validationmessage : String -> Html.Attribute msg
validationmessage val_ =
    Html.Attributes.property "validationMessage" (Json.Encode.string val_)


{-| Dispatched when the selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

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
