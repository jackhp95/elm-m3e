module Cem.M3e.SelectionList exposing (Variant(..), component, disabled, hideSelectionIndicator, multi, name, onBeforeinput, onChange, onInput, variant)

{-| 
A list of selectable options.

## Component

@docs component

### Attributes

@docs hideSelectionIndicator, multi, Variant, variant, name, disabled

### Events

@docs onChange, onBeforeinput, onInput
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A list of selectable options.

**Component Info:**
- **Extends:** `M3eListElement` from `/src/list/ListElement`

**Events:**
- `change`: Dispatched when the selected state of an option changes.
- `beforeinput`: Dispatched before the selected state of an option changes.
- `input`: Dispatched when the selected state of an option changes.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-selection-list" attributes children


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator : Bool -> Html.Attribute msg
hideSelectionIndicator val_ =
    Html.Attributes.property "hide-selection-indicator" (Json.Encode.bool val_)


{-| Whether multiple items can be selected. (default: `false`) -}
multi : Bool -> Html.Attribute msg
multi val_ =
    Html.Attributes.property "multi" (Json.Encode.bool val_)


{-| Values for the `variant` attribute. -}
type Variant
    = Segmented
    | Standard


{-| The appearance variant of the list. (default: `"standard"`) -}
variant : Variant -> Html.Attribute msg
variant val_ =
    Html.Attributes.attribute "variant" (variantToString val_)


variantToString : Variant -> String
variantToString val_ =
    case val_ of
        Segmented ->
            "segmented"
    
        Standard ->
            "standard"


{-| The name that identifies the element when submitting the associated form. -}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Dispatched when the selected state of an option changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched before the selected state of an option changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.
-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the selected state of an option changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.
-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder