module Cem.M3e.RadioGroup exposing
    ( component, ariaInvalid, disabled, name, required, value
    , dirty, pristine, touched, untouched, willvalidate, validationmessage
    , onBeforeinput, onInput, onChange
    )

{-| A container for a set of radio buttons.

@docs component, ariaInvalid, disabled, name, required, value
@docs dirty, pristine, touched, untouched, willvalidate, validationmessage
@docs onBeforeinput, onInput, onChange

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A container for a set of radio buttons.

**Events:**

  - `beforeinput`: Dispatched before the checked state of a radio button changes.
  - `input`: Dispatched when the checked state of a radio button changes.
  - `change`: Dispatched when the checked state of a radio button changes.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-radio-group" attributes children


{-| Set the `aria-invalid` attribute.
-}
ariaInvalid : String -> Html.Attribute msg
ariaInvalid val_ =
    Html.Attributes.attribute "aria-invalid" val_


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


{-| Whether the element is required. (default: `false`)
-}
required : Bool -> Html.Attribute msg
required val_ =
    Html.Attributes.property "required" (Json.Encode.bool val_)


{-| The selected value of the radio group.
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


{-| Dispatched before the checked state of a radio button changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the checked state of a radio button changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Dispatched when the checked state of a radio button changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder
