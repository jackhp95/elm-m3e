module M3e.Fab exposing (Size(..), Variant(..), closeIconSlot, component, extended, labelSlot, lowered, name, onClick, size, value, variant)

{-| 
A floating action button (FAB) used to present important actions.

## Component

@docs component

### Attributes

@docs extended, lowered, name, Size, size, value, Variant, variant

### Events

@docs onClick

### Slots

@docs labelSlot, closeIconSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A floating action button (FAB) used to present important actions.

**Events:**
- `click`: Dispatched when the element is clicked.

**Slots:**
- `label`: Renders the label of an extended button.
- `close-icon`: Renders the close icon when used to open a FAB menu.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-fab" attributes children


{-| Whether the button is extended to show the label. (default: `false`) -}
extended : Bool -> Html.Attribute msg
extended val_ =
    Html.Attributes.property "extended" (Json.Encode.bool val_)


{-| Whether to present a lowered elevation. (default: `false`) -}
lowered : Bool -> Html.Attribute msg
lowered val_ =
    Html.Attributes.property "lowered" (Json.Encode.bool val_)


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form. -}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| Values for the `size` attribute. -}
type Size
    = Large
    | Medium
    | Small


{-| The size of the button. (default: `"medium"`) -}
size : Size -> Html.Attribute msg
size val_ =
    Html.Attributes.attribute "size" (sizeToString val_)


sizeToString : Size -> String
sizeToString val_ =
    case val_ of
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
    = Primary
    | PrimaryContainer
    | Secondary
    | SecondaryContainer
    | Surface
    | Tertiary
    | TertiaryContainer


{-| The appearance variant of the button. (default: `"primary-container"`) -}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Primary ->
            "primary"
    
        PrimaryContainer ->
            "primary-container"
    
        Secondary ->
            "secondary"
    
        SecondaryContainer ->
            "secondary-container"
    
        Surface ->
            "surface"
    
        Tertiary ->
            "tertiary"
    
        TertiaryContainer ->
            "tertiary-container"


{-| Dispatched when the element is clicked.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders the label of an extended button. -}
labelSlot : Html.Attribute msg
labelSlot =
    Html.Attributes.attribute "slot" "label"


{-| Renders the close icon when used to open a FAB menu. -}
closeIconSlot : Html.Attribute msg
closeIconSlot =
    Html.Attributes.attribute "slot" "close-icon"