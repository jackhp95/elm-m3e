module M3e.Cem.Html.Stepper exposing (headerPosition, labelPosition, linear, onBeforeinput, onChange, onInput, orientation, stepper)

{-| 
@docs stepper, headerPosition, labelPosition, linear, orientation, onChange, onBeforeinput, onInput
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-stepper>` element — a partial application of `Html.node`. -}
stepper : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
stepper =
    Html.node "m3e-stepper"


{-| The position of the step header, when oriented horizontally. (default: `"above"`) -}
headerPosition : String -> Html.Attribute msg
headerPosition =
    Html.Attributes.attribute "header-position"


{-| The position of the step labels, when oriented horizontally. (default: `"end"`) -}
labelPosition : String -> Html.Attribute msg
labelPosition =
    Html.Attributes.attribute "label-position"


{-| Whether the validity of previous steps should be checked or not. (default: `false`) -}
linear : Bool -> Html.Attribute msg
linear val_ =
    Html.Attributes.property "linear" (Json.Encode.bool val_)


{-| The orientation of the stepper. (default: `"horizontal"`) -}
orientation : String -> Html.Attribute msg
orientation =
    Html.Attributes.attribute "orientation"


{-| Listen for `change` events. -}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"


{-| Listen for `beforeinput` events. -}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput =
    Html.Events.on "beforeinput"


{-| Listen for `input` events. -}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput =
    Html.Events.on "input"