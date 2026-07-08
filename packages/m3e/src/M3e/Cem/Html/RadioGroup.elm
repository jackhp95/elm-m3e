module M3e.Cem.Html.RadioGroup exposing
    ( radioGroup, ariaInvalid, disabled, name, required, onBeforeinput
    , onInput, onChange
    )

{-|
Bottom layer for `<m3e-radio-group>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs radioGroup, ariaInvalid, disabled, name, required, onBeforeinput
@docs onInput, onChange
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-radio-group>` element — a partial application of `Html.node`. -}
radioGroup : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
radioGroup =
    Html.node "m3e-radio-group"


{-| Set the `aria-invalid` attribute. -}
ariaInvalid : String -> Html.Attribute msg
ariaInvalid =
    Html.Attributes.attribute "aria-invalid"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""
    
    else
        Html.Attributes.classList []


{-| The name that identifies the element when submitting the associated form. -}
name : String -> Html.Attribute msg
name =
    Html.Attributes.attribute "name"


{-| Whether the element is required. (default: `false`) -}
required : Bool -> Html.Attribute msg
required val_ =
    if val_ then
        Html.Attributes.attribute "required" ""
    
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