module Cem.M3e.Radio exposing
    ( component, checked, disabled, name, required, value
    , dirty, pristine, touched, untouched, onBeforeinput, onInput
    , onChange, onClick
    )

{-| A radio button that allows a user to select one option from a set of options.

@docs component, checked, disabled, name, required, value
@docs dirty, pristine, touched, untouched, onBeforeinput, onInput
@docs onChange, onClick

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A radio button that allows a user to select one option from a set of options.

**Events:**

  - `beforeinput`: Dispatched before the checked state changes.
  - `input`: Dispatched when the checked state changes.
  - `change`: Dispatched when the checked state changes.
  - `click`: Dispatched when the element is clicked.

**CSS Custom Properties:**

  - `--m3e-radio-container-size`: Base size of the radio button container.
  - `--m3e-radio-icon-size`: Size of the radio icon inside the wrapper.
  - `--m3e-radio-unselected-hover-color`: Hover state layer color when radio is not selected.
  - `--m3e-radio-unselected-focus-color`: Focus state layer color when radio is not selected.
  - `--m3e-radio-unselected-ripple-color`: Ripple color when radio is not selected.
  - `--m3e-radio-unselected-icon-color`: Icon color when radio is not selected.
  - `--m3e-radio-selected-hover-color`: Hover state layer color when radio is selected.
  - `--m3e-radio-selected-focus-color`: Focus state layer color when radio is selected.
  - `--m3e-radio-selected-ripple-color`: Ripple color when radio is selected.
  - `--m3e-radio-selected-icon-color`: Icon color when radio is selected.
  - `--m3e-radio-disabled-icon-color`: Icon color when radio is disabled.
  - `--m3e-radio-error-hover-color`: Fallback hover color used when the radio is invalid and touched.
  - `--m3e-radio-error-focus-color`: Fallback focus color used when the radio is invalid and touched.
  - `--m3e-radio-error-ripple-color`: Fallback ripple color used when the radio is invalid and touched.
  - `--m3e-radio-error-icon-color`: Fallback icon color used when the radio is invalid and touched.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-radio" attributes children


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


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| Whether the element is required.
-}
required : String -> Html.Attribute msg
required val_ =
    Html.Attributes.attribute "required" val_


{-| A string representing the value of the radio. (default: `"on"`)
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


{-| Dispatched when the element is clicked.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder
