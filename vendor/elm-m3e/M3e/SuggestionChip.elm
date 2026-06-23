module M3e.SuggestionChip exposing (Variant(..), component, iconSlot, name, onClick, trailingIconSlot, value, variant)

{-| 
A chip used to help narrow a user's intent by presenting dynamically generated suggestions, such as
suggested responses or search filters.

## Component

@docs component

### Attributes

@docs name, value, Variant, variant

### Events

@docs onClick

### Slots

@docs iconSlot, trailingIconSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| A chip used to help narrow a user's intent by presenting dynamically generated suggestions, such as
suggested responses or search filters.

**Component Info:**
- **Extends:** `M3eChipElement` from `/src/chips/ChipElement`

**Events:**
- `click`: Dispatched when the element is clicked.

**Slots:**
- `icon`: Renders an icon before the chip's label.
- `trailing-icon`: Renders an icon after the chip's label.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-suggestion-chip" attributes children


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form. -}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


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