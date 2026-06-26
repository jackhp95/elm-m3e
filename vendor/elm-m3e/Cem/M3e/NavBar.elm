module Cem.M3e.NavBar exposing (Mode(..), component, mode, onBeforeinput, onChange, onInput)

{-| 
A horizontal bar, typically used on smaller devices, that allows a user to switch between 3-5 views.

## Component

@docs component

### Attributes

@docs Mode, mode

### Events

@docs onChange, onBeforeinput, onInput
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| A horizontal bar, typically used on smaller devices, that allows a user to switch between 3-5 views.

**Events:**
- `change`: Dispatched when the selected state of an item changes.
- `beforeinput`: Dispatched before the selected state of an item changes.
- `input`: Dispatched when the selected state of an item changes.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-nav-bar" attributes children


{-| Values for the `mode` attribute. -}
type Mode
    = Auto
    | Compact
    | Expanded


{-| The mode in which items in the bar are presented. (default: `"compact"`) -}
mode : Mode -> Html.Attribute msg
mode val_ =
    Html.Attributes.attribute "mode" (modeToString val_)


modeToString : Mode -> String
modeToString val_ =
    case val_ of
        Auto ->
            "auto"
    
        Compact ->
            "compact"
    
        Expanded ->
            "expanded"


{-| Dispatched when the selected state of an item changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched before the selected state of an item changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.
-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the selected state of an item changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.
-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder