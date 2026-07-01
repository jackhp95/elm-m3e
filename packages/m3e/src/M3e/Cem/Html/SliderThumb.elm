module M3e.Cem.Html.SliderThumb exposing (disabled, name, onBeforeinput, onChange, onClick, onInput, onValueChange, sliderThumb, value)

{-| 
@docs sliderThumb, disabled, name, value, onValueChange, onBeforeinput, onInput, onChange, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-slider-thumb>` element — a partial application of `Html.node`. -}
sliderThumb : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
sliderThumb =
    Html.node "m3e-slider-thumb"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The name that identifies the element when submitting the associated form. -}
name : String -> Html.Attribute msg
name =
    Html.Attributes.attribute "name"


{-| The value of the thumb. (default: `null`) -}
value : Float -> Html.Attribute msg
value val_ =
    Html.Attributes.property "value" (Json.Encode.float val_)


{-| Listen for `value-change` events. -}
onValueChange : Json.Decode.Decoder msg -> Html.Attribute msg
onValueChange =
    Html.Events.on "value-change"


{-| Listen for `beforeinput` events. -}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput =
    Html.Events.on "beforeinput"


{-| Listen for `input` events. -}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput =
    Html.Events.on "input"


{-| Listen for `change` events. -}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"


{-| Listen for `click` events. -}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"