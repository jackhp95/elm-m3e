module M3e.Cem.Html.InputChip exposing (disabled, disabledInteractive, inputChip, onClick, onRemove, removable, removeLabel, value, variant)

{-| 
@docs inputChip, disabled, disabledInteractive, removable, removeLabel, value, variant, onRemove, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-input-chip>` element — a partial application of `Html.node`. -}
inputChip : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
inputChip =
    Html.node "m3e-input-chip"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive : Bool -> Html.Attribute msg
disabledInteractive val_ =
    Html.Attributes.property "disabledInteractive" (Json.Encode.bool val_)


{-| Whether the chip is removable. (default: `false`) -}
removable : Bool -> Html.Attribute msg
removable val_ =
    Html.Attributes.property "removable" (Json.Encode.bool val_)


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`) -}
removeLabel : String -> Html.Attribute msg
removeLabel =
    Html.Attributes.attribute "remove-label"


{-| A string representing the value of the chip. -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.attribute "value"


{-| The appearance variant of the chip. (default: `"outlined"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


{-| Listen for `remove` events. -}
onRemove : Json.Decode.Decoder msg -> Html.Attribute msg
onRemove =
    Html.Events.on "remove"


{-| Listen for `click` events. -}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick =
    Html.Events.on "click"