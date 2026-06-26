module Cem.M3e.FabMenu exposing (Variant(..), component, onBeforetoggle, onToggle, variant)

{-| 
A menu, opened from a floating action button (FAB), used to display multiple related actions.

## Component

@docs component

### Attributes

@docs Variant, variant

### Events

@docs onBeforetoggle, onToggle
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| A menu, opened from a floating action button (FAB), used to display multiple related actions.

**Events:**
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-fab-menu" attributes children


{-| Values for the `variant` attribute. -}
type Variant
    = Primary
    | Secondary
    | Tertiary


{-| The appearance variant of the menu. (default: `"primary"`) -}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Primary ->
            "primary"
    
        Secondary ->
            "secondary"
    
        Tertiary ->
            "tertiary"


{-| Dispatched before the toggle state changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onBeforetoggle : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforetoggle decoder =
    Html.Events.on "beforetoggle" decoder


{-| Dispatched after the toggle state has changed.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle decoder =
    Html.Events.on "toggle" decoder