module Cem.M3e.Chip exposing (Variant(..), component, iconSlot, trailingIconSlot, value, variant)

{-| 
A non-interactive chip used to convey small pieces of information.

## Component

@docs component

### Attributes

@docs value, Variant, variant

### Slots

@docs iconSlot, trailingIconSlot
-}


import Html
import Html.Attributes


{-| A non-interactive chip used to convey small pieces of information.

**Slots:**
- `icon`: Renders an icon before the chip's label.
- `trailing-icon`: Renders an icon after the chip's label.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-chip" attributes children


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


{-| Renders an icon before the chip's label. -}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders an icon after the chip's label. -}
trailingIconSlot : Html.Attribute msg
trailingIconSlot =
    Html.Attributes.attribute "slot" "trailing-icon"