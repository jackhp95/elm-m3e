module M3e.Cem.Html.Slider exposing
    ( slider, disabled, discrete, labelled, max, min
    , step, size, onBeforeinput, onInput, onChange
    )

{-|
Bottom layer for `<m3e-slider>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs slider, disabled, discrete, labelled, max, min
@docs step, size, onBeforeinput, onInput, onChange
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-slider>` element — a partial application of `Html.node`. -}
slider : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
slider =
    Html.node "m3e-slider"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether to show tick marks. (default: `false`) -}
discrete : Bool -> Html.Attribute msg
discrete val_ =
    Html.Attributes.property "discrete" (Json.Encode.bool val_)


{-| Whether to show value labels when activated. (default: `false`) -}
labelled : Bool -> Html.Attribute msg
labelled val_ =
    Html.Attributes.property "labelled" (Json.Encode.bool val_)


{-| The maximum allowable value. (default: `100`) -}
max : Float -> Html.Attribute msg
max val_ =
    Html.Attributes.property "max" (Json.Encode.float val_)


{-| The minimum allowable value. (default: `0`) -}
min : Float -> Html.Attribute msg
min val_ =
    Html.Attributes.property "min" (Json.Encode.float val_)


{-| The value at which the thumb will snap. (default: `1`) -}
step : Float -> Html.Attribute msg
step val_ =
    Html.Attributes.property "step" (Json.Encode.float val_)


{-| The size of the slider. (default: `"extra-small"`) -}
size : String -> Html.Attribute msg
size =
    Html.Attributes.attribute "size"


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