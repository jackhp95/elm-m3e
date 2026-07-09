module M3e.Cem.Html.Select exposing
    ( select, disabled, hideSelectionIndicator, multi, name, panelClass
    , required, onChange, onToggle, onBeforeinput, onInput
    )

{-|
Bottom layer for `<m3e-select>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs select, disabled, hideSelectionIndicator, multi, name, panelClass
@docs required, onChange, onToggle, onBeforeinput, onInput
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-select>` element — a partial application of `Html.node`. -}
select : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
select =
    Html.node "m3e-select"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""
    
    else
        Html.Attributes.classList []


{-| Whether to hide the selection indicator for single select options. (default: `false`) -}
hideSelectionIndicator : Bool -> Html.Attribute msg
hideSelectionIndicator val_ =
    if val_ then
        Html.Attributes.attribute "hide-selection-indicator" ""
    
    else
        Html.Attributes.classList []


{-| Whether multiple options can be selected. (default: `false`) -}
multi : Bool -> Html.Attribute msg
multi val_ =
    if val_ then
        Html.Attributes.attribute "multi" ""
    
    else
        Html.Attributes.classList []


{-| The name that identifies the element when submitting the associated form. -}
name : String -> Html.Attribute msg
name =
    Html.Attributes.attribute "name"


{-| Class or list of classes to be applied to the select's overlay panel. (default: `""`) -}
panelClass : String -> Html.Attribute msg
panelClass =
    Html.Attributes.attribute "panel-class"


{-| Whether the element is required. (default: `false`) -}
required : Bool -> Html.Attribute msg
required val_ =
    if val_ then
        Html.Attributes.attribute "required" ""
    
    else
        Html.Attributes.classList []


{-| Listen for `change` events. -}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"


{-| Listen for `toggle` events. -}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle =
    Html.Events.on "toggle"


{-| Listen for `beforeinput` events. -}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput =
    Html.Events.on "beforeinput"


{-| Listen for `input` events. -}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput =
    Html.Events.on "input"