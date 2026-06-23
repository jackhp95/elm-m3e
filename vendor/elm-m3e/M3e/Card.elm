module M3e.Card exposing (Orientation(..), Variant(..), actionable, actionsSlot, component, contentSlot, footerSlot, headerSlot, inline, name, onClick, orientation, value, variant)

{-| 
A content container for text, images (or other media), and actions in the context of a single subject.

## Component

@docs component

### Attributes

@docs actionable, inline, Orientation, orientation, Variant, variant, name, value

### Events

@docs onClick

### Slots

@docs headerSlot, contentSlot, actionsSlot, footerSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A content container for text, images (or other media), and actions in the context of a single subject.

**Events:**
- `click`: Dispatched when the element is clicked.

**Slots:**
- `header`: Renders the header of the card.
- `content`: Renders the content of the card with padding.
- `actions`: Renders the actions of the card.
- `footer`: Renders the footer of the card.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-card" attributes children


{-| Whether the card is "actionable" and will respond to use interaction. (default: `false`) -}
actionable : Bool -> Html.Attribute msg
actionable val_ =
    Html.Attributes.property "actionable" (Json.Encode.bool val_)


{-| Whether to present the card inline with surrounding content. (default: `false`) -}
inline : Bool -> Html.Attribute msg
inline val_ =
    Html.Attributes.property "inline" (Json.Encode.bool val_)


{-| Values for the `orientation` attribute. -}
type Orientation
    = Horizontal
    | Vertical


{-| The orientation of the card. (default: `"vertical"`) -}
orientation : Orientation -> Html.Attribute msg
orientation val_ =
    Html.Attributes.attribute "orientation" (orientationToString val_)


orientationToString : Orientation -> String
orientationToString val_ =
    case val_ of
        Horizontal ->
            "horizontal"
    
        Vertical ->
            "vertical"


{-| Values for the `variant` attribute. -}
type Variant
    = Elevated
    | Filled
    | Outlined


{-| The appearance variant of the card. (default: `"filled"`) -}
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


{-| The name of the element, submitted as a pair with the element's `value`
as part of form data, when the element is used to submit a form.
-}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| The value associated with the element's name when it's submitted with form data. -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| Dispatched when the element is clicked.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders the header of the card. -}
headerSlot : Html.Attribute msg
headerSlot =
    Html.Attributes.attribute "slot" "header"


{-| Renders the content of the card with padding. -}
contentSlot : Html.Attribute msg
contentSlot =
    Html.Attributes.attribute "slot" "content"


{-| Renders the actions of the card. -}
actionsSlot : Html.Attribute msg
actionsSlot =
    Html.Attributes.attribute "slot" "actions"


{-| Renders the footer of the card. -}
footerSlot : Html.Attribute msg
footerSlot =
    Html.Attributes.attribute "slot" "footer"