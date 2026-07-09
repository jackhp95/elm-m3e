module M3e.Cem.Html.ButtonSegment exposing
    ( buttonSegment, checked, disabled, value, onBeforeinput, onInput
    , onChange, onClick
    )

{-|
Bottom layer for `<m3e-button-segment>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs buttonSegment, checked, disabled, value, onBeforeinput, onInput
@docs onChange, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-button-segment>` element — a partial application of `Html.node`. -}
buttonSegment :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
buttonSegment =
    Html.node "m3e-button-segment"


{-| Whether the element is checked. (default: `false`) -}
checked : Bool -> Html.Attribute msg
checked val_ =
    if val_ then
        Html.Attributes.attribute "checked" ""
    
    else
        Html.Attributes.classList []


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""
    
    else
        Html.Attributes.classList []


{-| A string representing the value of the segment. (default: `"on"`) -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.attribute "value"


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