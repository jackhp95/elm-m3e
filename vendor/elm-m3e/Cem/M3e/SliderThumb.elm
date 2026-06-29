module Cem.M3e.SliderThumb exposing
    ( component, disabled, name, value, formvalue, dirty
    , pristine, touched, untouched, onValueChange, onBeforeinput, onInput
    , onChange, onClick
    )

{-| A thumb used to select a value in a slider.

@docs component, disabled, name, value, formvalue, dirty
@docs pristine, touched, untouched, onValueChange, onBeforeinput, onInput
@docs onChange, onClick

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A thumb used to select a value in a slider.

**Events:**

  - `value-change`: No description
  - `beforeinput`: Dispatched before the value changes.
  - `input`: Dispatched when the value changes.
  - `change`: Dispatched when the value changes.
  - `click`: Dispatched when the element is clicked.

**CSS Custom Properties:**

  - `--m3e-slider-thumb-width`: Width of the slider thumb.
  - `--m3e-slider-thumb-padding`: Horizontal padding around the thumb.
  - `--m3e-slider-thumb-color`: Active color of the slider thumb when enabled.
  - `--m3e-slider-thumb-pressed-width`: Width of the thumb when pressed.
  - `--m3e-slider-thumb-disabled-color`: Color of the thumb when disabled.
  - `--m3e-slider-thumb-disabled-opacity`: Opacity of the thumb when disabled.
  - `--m3e-slider-label-width`: Width of the floating label above the thumb.
  - `--m3e-slider-label-container-color`: Background color of the label container.
  - `--m3e-slider-label-color`: Text color of the label.
  - `--m3e-slider-label-font-size`: Font size of the label text.
  - `--m3e-slider-label-font-weight`: Font weight of the label text.
  - `--m3e-slider-label-line-height`: Line height of the label text.
  - `--m3e-slider-label-tracking`: Letter spacing of the label text.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-slider-thumb" attributes children


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


{-| The value of the thumb. (default: `null`)
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| Set the `[formValue]` property.
-}
formvalue :
    Cem.M3e.Common.Value
        { file : Cem.M3e.Common.Supported
        , formdata : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
formvalue val_ =
    Html.Attributes.property
        "[formValue]"
        (Json.Encode.string (Cem.M3e.Common.toString val_))


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


{-| Listen for `value-change` events.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onValueChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onValueChange : Json.Decode.Decoder msg -> Html.Attribute msg
onValueChange decoder =
    Html.Events.on "value-change" decoder


{-| Dispatched before the value changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the value changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Dispatched when the value changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

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
