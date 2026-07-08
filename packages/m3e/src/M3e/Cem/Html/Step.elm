module M3e.Cem.Html.Step exposing
    ( step, completed, disabled, editable, for, optional
    , selected, invalid, onBeforeinput, onInput, onChange, onClick
    )

{-|
Bottom layer for `<m3e-step>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs step, completed, disabled, editable, for, optional
@docs selected, invalid, onBeforeinput, onInput, onChange, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-step>` element — a partial application of `Html.node`. -}
step : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
step =
    Html.node "m3e-step"


{-| Whether the step has been completed. (default: `false`) -}
completed : Bool -> Html.Attribute msg
completed val_ =
    if val_ then
        Html.Attributes.attribute "completed" ""
    
    else
        Html.Attributes.classList []


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""
    
    else
        Html.Attributes.classList []


{-| Whether the step is editable and users can return to it after completion. (default: `false`) -}
editable : Bool -> Html.Attribute msg
editable val_ =
    if val_ then
        Html.Attributes.attribute "editable" ""
    
    else
        Html.Attributes.classList []


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"


{-| Whether the step is optional. (default: `false`) -}
optional : Bool -> Html.Attribute msg
optional val_ =
    if val_ then
        Html.Attributes.attribute "optional" ""
    
    else
        Html.Attributes.classList []


{-| Whether the element is selected. (default: `false`) -}
selected : Bool -> Html.Attribute msg
selected val_ =
    if val_ then
        Html.Attributes.attribute "selected" ""
    
    else
        Html.Attributes.classList []


{-| Whether the step has an error. (default: `false`) -}
invalid : Bool -> Html.Attribute msg
invalid val_ =
    if val_ then
        Html.Attributes.attribute "invalid" ""
    
    else
        Html.Attributes.classList []


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