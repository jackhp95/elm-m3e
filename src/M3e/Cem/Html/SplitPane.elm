module M3e.Cem.Html.SplitPane exposing
    ( splitPane, label, max, min, orientation, overshootLimit
    , step, value, wrapDetents, name, disabled, onChange, onBeforeinput
    , onInput
    )

{-|
Bottom layer for `<m3e-split-pane>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs splitPane, label, max, min, orientation, overshootLimit
@docs step, value, wrapDetents, name, disabled, onChange
@docs onBeforeinput, onInput
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-split-pane>` element — a partial application of `Html.node`. -}
splitPane : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
splitPane =
    Html.node "m3e-split-pane"


{-| The accessible label given to the movable drag handle. (default: `"Resize panes"`) -}
label : String -> Html.Attribute msg
label =
    Html.Attributes.attribute "label"


{-| A fractional value, between 0 and 100, indicating the maximum size of the start pane. (default: `100`) -}
max : Float -> Html.Attribute msg
max val_ =
    Html.Attributes.attribute "max" (String.fromFloat val_)


{-| A fractional value, between 0 and 100, indicating the minimum size of the start pane. (default: `0`) -}
min : Float -> Html.Attribute msg
min val_ =
    Html.Attributes.attribute "min" (String.fromFloat val_)


{-| The orientation of the split. (default: `"horizontal"`) -}
orientation : String -> Html.Attribute msg
orientation =
    Html.Attributes.attribute "orientation"


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`) -}
overshootLimit : Float -> Html.Attribute msg
overshootLimit val_ =
    Html.Attributes.attribute "overshoot-limit" (String.fromFloat val_)


{-| A fractional value, between 0 and 100, indicating the increment by which to adjust the value when resized via keyboard. (default: `1`) -}
step : Float -> Html.Attribute msg
step val_ =
    Html.Attributes.attribute "step" (String.fromFloat val_)


{-| A fractional value, between 0 and 100, indicating the size of the start pane. (default: `50`) -}
value : Float -> Html.Attribute msg
value val_ =
    Html.Attributes.attribute "value" (String.fromFloat val_)


{-| Whether cycling through detents will wrap. (default: `false`) -}
wrapDetents : Bool -> Html.Attribute msg
wrapDetents val_ =
    if val_ then
        Html.Attributes.attribute "wrap-detents" ""
    
    else
        Html.Attributes.classList []


{-| The name that identifies the element when submitting the associated form. -}
name : String -> Html.Attribute msg
name =
    Html.Attributes.attribute "name"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""
    
    else
        Html.Attributes.classList []


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