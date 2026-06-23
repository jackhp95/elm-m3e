module M3e.SplitPane exposing (Orientation(..), component, endSlot, name, onBeforeinput, onChange, onInput, orientation, startSlot, value, wrapDetents)

{-| 
A dual-view layout that separates content with a movable drag handle.

## Component

@docs component

### Attributes

@docs Orientation, orientation, value, wrapDetents, name

### Events

@docs onChange, onBeforeinput, onInput

### Slots

@docs startSlot, endSlot

### Omitted Attributes

The following attribute setters were omitted because Elm cannot pass DOM element references:

- `detents`: string[]

-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A dual-view layout that separates content with a movable drag handle.

**Events:**
- `change`: Dispatched when the user finishes adjusting the drag handle.
- `beforeinput`: Dispatched continuously before the user adjusts the drag handle.
- `input`: Dispatched continuously while the user adjusts the drag handle.

**Slots:**
- `start`: Renders content at the logical start side of the pane.
- `end`: Renders content at the logical end side of the pane.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-split-pane" attributes children


{-| Values for the `orientation` attribute. -}
type Orientation
    = Auto
    | Horizontal
    | Vertical


{-| The orientation of the split. (default: `"horizontal"`) -}
orientation : Orientation -> Html.Attribute msg
orientation val_ =
    Html.Attributes.attribute "orientation" (orientationToString val_)


orientationToString : Orientation -> String
orientationToString val_ =
    case val_ of
        Auto ->
            "auto"
    
        Horizontal ->
            "horizontal"
    
        Vertical ->
            "vertical"


{-| A fractional value, between 0 and 100, indicating the size of the start pane. (default: `50`) -}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| Whether cycling through detents will wrap. (default: `false`) -}
wrapDetents : Bool -> Html.Attribute msg
wrapDetents val_ =
    Html.Attributes.property "wrap-detents" (Json.Encode.bool val_)


{-| The name that identifies the element when submitting the associated form. -}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| Dispatched when the user finishes adjusting the drag handle.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched continuously before the user adjusts the drag handle.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched continuously while the user adjusts the drag handle.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Renders content at the logical start side of the pane. -}
startSlot : Html.Attribute msg
startSlot =
    Html.Attributes.attribute "slot" "start"


{-| Renders content at the logical end side of the pane. -}
endSlot : Html.Attribute msg
endSlot =
    Html.Attributes.attribute "slot" "end"