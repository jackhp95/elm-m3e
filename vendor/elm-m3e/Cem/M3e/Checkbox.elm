module Cem.M3e.Checkbox exposing
    ( component, checked, disabled, indeterminate, name, required
    , value, dirty, pristine, touched, untouched, willvalidate
    , validationmessage, onBeforeinput, onInput, onChange, onInvalid, onClick
    )

{-| A checkbox that allows a user to select one or more options from a limited number of choices.

@docs component, checked, disabled, indeterminate, name, required
@docs value, dirty, pristine, touched, untouched, willvalidate
@docs validationmessage, onBeforeinput, onInput, onChange, onInvalid, onClick

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A checkbox that allows a user to select one or more options from a limited number of choices.

**Events:**

  - `beforeinput`: Dispatched before the checked state changes.
  - `input`: Dispatched when the checked state changes.
  - `change`: Dispatched when the checked state changes.
  - `invalid`: Dispatched when a form is submitted and the element fails constraint validation.
  - `click`: Dispatched when the element is clicked.

**CSS Custom Properties:**

  - `--m3e-checkbox-icon-size`: Size of the checkbox icon inside the container.
  - `--m3e-checkbox-container-size`: Base size of the checkbox container.
  - `--m3e-checkbox-container-shape`: Border radius of the icon container.
  - `--m3e-checkbox-unselected-outline-thickness`: Border thickness for unselected state.
  - `--m3e-checkbox-unselected-outline-color`: Border color for unselected state.
  - `--m3e-checkbox-unselected-hover-outline-color`: Border color on hover when unselected.
  - `--m3e-checkbox-unselected-disabled-outline-color`: Base color for disabled unselected outline.
  - `--m3e-checkbox-unselected-disabled-outline-opacity`: Opacity for disabled unselected outline.
  - `--m3e-checkbox-unselected-error-outline-color`: Border color for invalid unselected state.
  - `--m3e-checkbox-selected-container-color`: Background color for selected container.
  - `--m3e-checkbox-selected-icon-color`: Icon color for selected state.
  - `--m3e-checkbox-selected-disabled-container-color`: Base color for disabled selected container.
  - `--m3e-checkbox-selected-disabled-container-opacity`: Opacity for disabled selected container.
  - `--m3e-checkbox-selected-disabled-icon-color`: Base color for disabled selected icon.
  - `--m3e-checkbox-selected-disabled-icon-opacity`: Opacity for disabled selected icon.
  - `--m3e-checkbox-unselected-hover-color`: Ripple hover color for unselected state.
  - `--m3e-checkbox-unselected-focus-color`: Ripple focus color for unselected state.
  - `--m3e-checkbox-unselected-ripple-color`: Ripple base color for unselected state.
  - `--m3e-checkbox-selected-hover-color`: Ripple hover color for selected state.
  - `--m3e-checkbox-selected-focus-color`: Ripple focus color for selected state.
  - `--m3e-checkbox-selected-ripple-color`: Ripple base color for selected state.
  - `--m3e-checkbox-unselected-error-hover-color`: Ripple hover color for invalid unselected state.
  - `--m3e-checkbox-unselected-error-focus-color`: Ripple focus color for invalid unselected state.
  - `--m3e-checkbox-unselected-error-ripple-color`: Ripple base color for invalid unselected state.
  - `--m3e-checkbox-selected-error-hover-color`: Ripple hover color for invalid selected state.
  - `--m3e-checkbox-selected-error-focus-color`: Ripple focus color for invalid selected state.
  - `--m3e-checkbox-selected-error-ripple-color`: Ripple base color for invalid selected state.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-checkbox" attributes children


{-| Whether the element is checked. (default: `false`)
-}
checked : Bool -> Html.Attribute msg
checked =
    Html.Attributes.checked


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the element's checked state is indeterminate. (default: `false`)
-}
indeterminate : Bool -> Html.Attribute msg
indeterminate val_ =
    Html.Attributes.property "indeterminate" (Json.Encode.bool val_)


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| Whether the element is required. (default: `false`)
-}
required : Bool -> Html.Attribute msg
required val_ =
    Html.Attributes.property "required" (Json.Encode.bool val_)


{-| A string representing the value of the checkbox. (default: `"on"`)
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


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


{-| Dispatched before the checked state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the checked state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Dispatched when the checked state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched when a form is submitted and the element fails constraint validation.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onInvalid : Json.Decode.Decoder msg -> Html.Attribute msg
onInvalid decoder =
    Html.Events.on "invalid" decoder


{-| Dispatched when the element is clicked.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder
