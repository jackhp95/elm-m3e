module M3e.IconButton exposing (Shape(..), Size(..), Variant(..), Width(..), component, name, onBeforeinput, onChange, onClick, onInput, selectedSlot, shape, size, value, variant, width)

{-| 
An icon button users interact with to perform a supplementary action.

## Component

@docs component

### Attributes

@docs name, Shape, shape, Size, size, value, Variant, variant, Width, width

### Events

@docs onBeforeinput, onInput, onChange, onClick

### Slots

@docs selectedSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| An icon button users interact with to perform a supplementary action.

**Events:**
- `beforeinput`: Dispatched before a toggle button's selected state changes.
- `input`: Dispatched when a toggle button's selected state changes.
- `change`: Dispatched when a toggle button's selected state changes.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `selected`: Renders an icon, when selected.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-icon-button" attributes children


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form. -}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| Values for the `shape` attribute. -}
type Shape
    = Rounded
    | Square


{-| The shape of the button. (default: `"rounded"`) -}
shape : Shape -> Html.Attribute msg
shape val_ =
    Html.Attributes.attribute "shape" (shapeToString val_)


shapeToString : Shape -> String
shapeToString val_ =
    case val_ of
        Rounded ->
            "rounded"
    
        Square ->
            "square"


{-| Values for the `size` attribute. -}
type Size
    = ExtraLarge
    | ExtraSmall
    | Large
    | Medium
    | Small


{-| The size of the button. (default: `"small"`) -}
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


{-| The value associated with the element's name when it's submitted with form data. -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| Values for the `variant` attribute. -}
type Variant
    = Filled
    | Outlined
    | Standard
    | Tonal


{-| The appearance variant of the button. (default: `"standard"`) -}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Filled ->
            "filled"
    
        Outlined ->
            "outlined"
    
        Standard ->
            "standard"
    
        Tonal ->
            "tonal"


{-| Values for the `width` attribute. -}
type Width
    = Default
    | Narrow
    | Wide


{-| The width of the button. (default: `"default"`) -}
width : Width -> Html.Attribute msg
width val_ =
    Html.Attributes.attribute "width" (widthToString val_)


widthToString : Width -> String
widthToString val_ =
    case val_ of
        Default ->
            "default"
    
        Narrow ->
            "narrow"
    
        Wide ->
            "wide"


{-| Dispatched before a toggle button's selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when a toggle button's selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Dispatched when a toggle button's selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched when the element is clicked.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders an icon, when selected. -}
selectedSlot : Html.Attribute msg
selectedSlot =
    Html.Attributes.attribute "slot" "selected"