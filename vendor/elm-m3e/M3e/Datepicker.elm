module M3e.Datepicker exposing (Variant(..), component, confirmLabel, dismissLabel, onBeforetoggle, onChange, onToggle, range, variant)

{-| 
Presents a date picker on a temporary surface.

## Component

@docs component

### Attributes

@docs Variant, variant, range, confirmLabel, dismissLabel

### Events

@docs onChange, onBeforetoggle, onToggle
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Presents a date picker on a temporary surface.

**Events:**
- `change`: Dispatched when the selected date changes.
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-datepicker" attributes children


{-| Values for the `variant` attribute. -}
type Variant
    = Auto
    | Docked
    | Modal


{-| The appearance variant of the picker. (default: `"docked"`) -}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Auto ->
            "auto"
    
        Docked ->
            "docked"
    
        Modal ->
            "modal"


{-| Whether a range of dates can be selected. (default: `false`) -}
range : Bool -> Html.Attribute msg
range val_ =
    Html.Attributes.property "range" (Json.Encode.bool val_)


{-| The label given to the button used apply the selected date and close the picker. (default: `"OK"`) -}
confirmLabel : String -> Html.Attribute msg
confirmLabel val_ =
    Html.Attributes.attribute "confirm-label" val_


{-| The label given to the button used discard the selected date and close the picker. (default: `"Cancel"`) -}
dismissLabel : String -> Html.Attribute msg
dismissLabel val_ =
    Html.Attributes.attribute "dismiss-label" val_


{-| Dispatched when the selected date changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


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