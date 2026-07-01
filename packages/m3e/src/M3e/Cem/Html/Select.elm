module M3e.Cem.Html.Select exposing (disabled, hideSelectionIndicator, multi, name, onBeforeinput, onChange, onInput, onToggle, panelClass, required, select)

{-| 
@docs select, disabled, hideSelectionIndicator, multi, name, panelClass, required, onChange, onToggle, onBeforeinput, onInput
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-select>` element — a partial application of `Html.node`. -}
select : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
select =
    Html.node "m3e-select"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether to hide the selection indicator for single select options. (default: `false`) -}
hideSelectionIndicator : Bool -> Html.Attribute msg
hideSelectionIndicator val_ =
    Html.Attributes.property "hideSelectionIndicator" (Json.Encode.bool val_)


{-| Whether multiple options can be selected. (default: `false`) -}
multi : Bool -> Html.Attribute msg
multi val_ =
    Html.Attributes.property "multi" (Json.Encode.bool val_)


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
    Html.Attributes.property "required" (Json.Encode.bool val_)


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