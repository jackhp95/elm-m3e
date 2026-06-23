module M3e.FilterChip exposing (Variant(..), component, iconSlot, onBeforeinput, onChange, onClick, onInput, trailingIconSlot, value, variant)

{-| 
A chip users interact with to select/deselect options.

## Component

@docs component

### Attributes

@docs value, Variant, variant

### Events

@docs onBeforeinput, onInput, onChange, onClick

### Slots

@docs iconSlot, trailingIconSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| A chip users interact with to select/deselect options.

**Component Info:**
- **Extends:** `M3eChipElement` from `/src/chips/ChipElement`

**Events:**
- `beforeinput`: Dispatched before the selected state changes.
- `input`: Dispatched when the selected state changes.
- `change`: Dispatched when the selected state changes.
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders an icon before the chip's label.
- `trailing-icon`: Renders an icon after the chip's label.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-filter-chip" attributes children


{-| A string representing the value of the chip. -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| Values for the `variant` attribute. -}
type Variant
    = Elevated
    | Outlined


{-| The appearance variant of the chip. (default: `"outlined"`) -}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Elevated ->
            "elevated"
    
        Outlined ->
            "outlined"


{-| Dispatched before the selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Dispatched when the selected state changes.

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


{-| Renders an icon before the chip's label. -}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders an icon after the chip's label. -}
trailingIconSlot : Html.Attribute msg
trailingIconSlot =
    Html.Attributes.attribute "slot" "trailing-icon"