module M3e.Cem.Html.SelectionList exposing
    ( selectionList, hideSelectionIndicator, multi, variant, name, disabled
    , onChange, onBeforeinput, onInput
    )

{-|
Bottom layer for `<m3e-selection-list>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs selectionList, hideSelectionIndicator, multi, variant, name, disabled
@docs onChange, onBeforeinput, onInput
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-selection-list>` element — a partial application of `Html.node`. -}
selectionList :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
selectionList =
    Html.node "m3e-selection-list"


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator : Bool -> Html.Attribute msg
hideSelectionIndicator val_ =
    if val_ then
        Html.Attributes.attribute "hide-selection-indicator" ""
    
    else
        Html.Attributes.classList []


{-| Whether multiple items can be selected. (default: `false`) -}
multi : Bool -> Html.Attribute msg
multi val_ =
    if val_ then
        Html.Attributes.attribute "multi" ""
    
    else
        Html.Attributes.classList []


{-| The appearance variant of the list. (default: `"standard"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


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