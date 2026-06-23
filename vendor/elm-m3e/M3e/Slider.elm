module M3e.Slider exposing (Size(..), component, discrete, labelled, onBeforeinput, onChange, onInput, size)

{-| 
Allows for the selection of numeric values from a range.

## Component

@docs component

### Attributes

@docs discrete, labelled, Size, size

### Events

@docs onBeforeinput, onInput, onChange
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Allows for the selection of numeric values from a range.

**Events:**
- `beforeinput`: Dispatched before the value of a thumb changes.
- `input`: Dispatched when the value of a thumb changes.
- `change`: Dispatched when the value of a thumb changes.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-slider" attributes children


{-| Whether to show tick marks. (default: `false`) -}
discrete : Bool -> Html.Attribute msg
discrete val_ =
    Html.Attributes.property "discrete" (Json.Encode.bool val_)


{-| Whether to show value labels when activated. (default: `false`) -}
labelled : Bool -> Html.Attribute msg
labelled val_ =
    Html.Attributes.property "labelled" (Json.Encode.bool val_)


{-| Values for the `size` attribute. -}
type Size
    = ExtraLarge
    | ExtraSmall
    | Large
    | Medium
    | Small


{-| The size of the slider. (default: `"extra-small"`) -}
size : Size -> Html.Attribute msg
size val_ =
    Html.Attributes.attribute "size" (sizeToString val_)


sizeToString : Size -> String
sizeToString val_ =
    case val_ of
        ExtraLarge ->
            "extra-large"
    
        ExtraSmall ->
            "extra-small"
    
        Large ->
            "large"
    
        Medium ->
            "medium"
    
        Small ->
            "small"


{-| Dispatched before the value of a thumb changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the value of a thumb changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Dispatched when the value of a thumb changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder