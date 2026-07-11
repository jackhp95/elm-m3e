module M3e.Raw.SliderThumb exposing
    ( sliderThumb, disabled, name, value, onValueChange, onBeforeinput
    , onInput, onChange, onClick
    )

{-| Bottom layer for `<m3e-slider-thumb>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs sliderThumb, disabled, name, value, onValueChange, onBeforeinput
@docs onInput, onChange, onClick

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-slider-thumb>` element — a partial application of `Html.node`.
-}
sliderThumb : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
sliderThumb =
    Html.node "m3e-slider-thumb"


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""

    else
        Html.Attributes.classList []


{-| The name that identifies the element when submitting the associated form.
-}
name : String -> Html.Attribute msg
name =
    Html.Attributes.attribute "name"


{-| The value of the thumb. (default: `null`)
-}
value : Float -> Html.Attribute msg
value val_ =
    Html.Attributes.attribute "value" (String.fromFloat val_)


{-| Listen for `value-change` events.
-}
onValueChange : Json.Decode.Decoder msg -> Html.Attribute msg
onValueChange =
    Html.Events.on "value-change"


{-| Listen for `beforeinput` events.
-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput =
    Html.Events.on "beforeinput"


{-| Listen for `input` events.
-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput =
    Html.Events.on "input"


{-| Listen for `change` events.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"


{-| Listen for `click` events.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"
