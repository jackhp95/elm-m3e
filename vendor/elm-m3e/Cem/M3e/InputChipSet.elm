module Cem.M3e.InputChipSet exposing
    ( component, disabled, name, required, vertical, shouldlabelfloat
    , willvalidate, validationmessage, dirty, pristine, touched, untouched
    , onChange, inputSlot
    )

{-| A container that transforms user input into a cohesive set of interactive chips, supporting entry, editing, and removal of discrete values.

@docs component, disabled, name, required, vertical, shouldlabelfloat
@docs willvalidate, validationmessage, dirty, pristine, touched, untouched
@docs onChange, inputSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A container that transforms user input into a cohesive set of interactive chips, supporting entry, editing, and removal of discrete values.

**Component Info:**

  - **Extends:** `M3eChipSetElement` from `/src/chips/ChipSetElement`

**Events:**

  - `change`: Dispatched when a chip is added to, or removed from, the set.

**Slots:**

  - `input`: Renders the input element used to add new chips to the set.

**CSS Custom Properties:**

  - `--m3e-chip-set-spacing`: The spacing (gap) between chips in the set.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-input-chip-set" attributes children


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


{-| Whether a value is required for the element. (default: `false`)
-}
required : Bool -> Html.Attribute msg
required val_ =
    Html.Attributes.property "required" (Json.Encode.bool val_)


{-| Whether the element is oriented vertically. (default: `false`)
-}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    Html.Attributes.property "vertical" (Json.Encode.bool val_)


{-| Set the `shouldLabelFloat` property.
-}
shouldlabelfloat : Bool -> Html.Attribute msg
shouldlabelfloat val_ =
    Html.Attributes.property "shouldLabelFloat" (Json.Encode.bool val_)


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


{-| Dispatched when a chip is added to, or removed from, the set.

**Payload type:** `CustomEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Renders the input element used to add new chips to the set.
-}
inputSlot : Html.Attribute msg
inputSlot =
    Html.Attributes.attribute "slot" "input"
