module M3e.Cem.Html.FilterChip exposing (disabled, disabledInteractive, filterChip, onBeforeinput, onChange, onClick, onInput, selected, value, variant)

{-| 
@docs filterChip, disabled, disabledInteractive, selected, value, variant, onBeforeinput, onInput, onChange, onClick
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| The raw `<m3e-filter-chip>` element — a partial application of `Html.node`. -}
filterChip : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
filterChip =
    Html.node "m3e-filter-chip"


{-| A value indicating whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| A value indicating whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive : Bool -> Html.Attribute msg
disabledInteractive val_ =
    Html.Attributes.property "disabledInteractive" (Json.Encode.bool val_)


{-| A value indicating whether the element is selected. (default: `false`) -}
selected : Bool -> Html.Attribute msg
selected val_ =
    Html.Attributes.property "selected" (Json.Encode.bool val_)


{-| A string representing the value of the chip. -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.attribute "value"


{-| The appearance variant of the chip. (default: `"outlined"`) -}
variant : String -> Html.Attribute msg
variant =
    Html.Attributes.attribute "variant"


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