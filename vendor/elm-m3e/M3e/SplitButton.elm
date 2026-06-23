module M3e.SplitButton exposing (Size(..), Variant(..), component, leadingButtonSlot, size, trailingButtonSlot, variant)

{-| 
A button used to show an action with a menu of related actions.

## Component

@docs component

### Attributes

@docs Variant, variant, Size, size

### Slots

@docs leadingButtonSlot, trailingButtonSlot
-}


import Html
import Html.Attributes


{-| A button used to show an action with a menu of related actions.

**Slots:**
- `leading-button`: The leading button used to perform the primary action.
- `trailing-button`: The trailing icon button used to open a menu of related actions.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-split-button" attributes children


{-| Values for the `variant` attribute. -}
type Variant
    = Elevated
    | Filled
    | Outlined
    | Tonal


{-| The appearance variant of the button. (default: `"filled"`) -}
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
    
        Tonal ->
            "tonal"


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


{-| The leading button used to perform the primary action. -}
leadingButtonSlot : Html.Attribute msg
leadingButtonSlot =
    Html.Attributes.attribute "slot" "leading-button"


{-| The trailing icon button used to open a menu of related actions. -}
trailingButtonSlot : Html.Attribute msg
trailingButtonSlot =
    Html.Attributes.attribute "slot" "trailing-button"