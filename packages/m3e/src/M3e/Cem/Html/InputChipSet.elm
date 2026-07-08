module M3e.Cem.Html.InputChipSet exposing
    ( inputChipSet, disabled, name, required, vertical, onChange
    )

{-|
Bottom layer for `<m3e-input-chip-set>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs inputChipSet, disabled, name, required, vertical, onChange
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| The raw `<m3e-input-chip-set>` element, with the library's fixed host attribute (role="group") stamped ahead of the caller's attributes. -}
inputChipSet :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
inputChipSet attributes children =
    Html.node
        "m3e-input-chip-set"
        (Html.Attributes.attribute "role" "group" :: attributes)
        children


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


{-| Whether a value is required for the element. (default: `false`) -}
required : Bool -> Html.Attribute msg
required val_ =
    if val_ then
        Html.Attributes.attribute "required" ""
    
    else
        Html.Attributes.classList []


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    if val_ then
        Html.Attributes.attribute "vertical" ""
    
    else
        Html.Attributes.classList []


{-| Listen for `change` events. -}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange =
    Html.Events.on "change"