module M3e.Cem.Html.SelectionList exposing (disabled, hideSelectionIndicator, multi, name, onBeforeinput, onChange, onInput, selectionList, variant)

{-| 
@docs selectionList, hideSelectionIndicator, multi, variant, name, disabled, onChange, onBeforeinput, onInput
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-selection-list>` element — a partial application of `Html.node`. -}
selectionList :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
selectionList =
    Html.node "m3e-selection-list"


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator : Bool -> Html.Attribute msg
hideSelectionIndicator val_ =
    Html.Attributes.property "hideSelectionIndicator" (Json.Encode.bool val_)


{-| Whether multiple items can be selected. (default: `false`) -}
multi : Bool -> Html.Attribute msg
multi val_ =
    Html.Attributes.property "multi" (Json.Encode.bool val_)


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
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


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