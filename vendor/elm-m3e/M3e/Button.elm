module M3e.Button exposing (Shape(..), Size(..), Variant(..), component, iconSlot, name, onBeforeinput, onChange, onClick, onInput, selectedIconSlot, selectedSlot, shape, size, trailingIconSlot, value, variant)

{-| 
A button users interact with to perform an action.

## Component

@docs component

### Attributes

@docs name, Shape, shape, Size, size, value, Variant, variant

### Events

@docs onBeforeinput, onInput, onChange, onClick

### Slots

@docs iconSlot, selectedSlot, selectedIconSlot, trailingIconSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| A button users interact with to perform an action.

**Events:**
- `beforeinput`: Dispatched before a toggle button's selected state changes.
- `input`: Dispatched when a toggle button's selected state changes.
- `change`: Dispatched when a toggle button's selected state changes.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders an icon before the button's label.
- `selected`: Renders the label of the button, when selected.
- `selected-icon`: Renders an icon before the button's label, when selected.
- `trailing-icon`: Renders an icon after the button's label.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-button" attributes children


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
    = Elevated
    | Filled
    | Outlined
    | Text
    | Tonal


{-| The appearance variant of the button. (default: `"text"`) -}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Elevated ->
            "elevated"
    
        Filled ->
            "filled"
    
        Outlined ->
            "outlined"
    
        Text ->
            "text"
    
        Tonal ->
            "tonal"


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


{-| Renders an icon before the button's label. -}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders the label of the button, when selected. -}
selectedSlot : Html.Attribute msg
selectedSlot =
    Html.Attributes.attribute "slot" "selected"


{-| Renders an icon before the button's label, when selected. -}
selectedIconSlot : Html.Attribute msg
selectedIconSlot =
    Html.Attributes.attribute "slot" "selected-icon"


{-| Renders an icon after the button's label. -}
trailingIconSlot : Html.Attribute msg
trailingIconSlot =
    Html.Attributes.attribute "slot" "trailing-icon"