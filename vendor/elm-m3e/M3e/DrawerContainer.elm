module M3e.DrawerContainer exposing (EndMode(..), StartMode(..), component, end, endDivider, endMode, endSlot, onChange, start, startDivider, startMode, startSlot)

{-| 
A container for one or two sliding drawers.

## Component

@docs component

### Attributes

@docs end, EndMode, endMode, endDivider, start, StartMode, startMode, startDivider

### Events

@docs onChange

### Slots

@docs startSlot, endSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A container for one or two sliding drawers.

**Events:**
- `change`: Dispatched when the state of the start or end drawers change.

**Slots:**
- `start`: Renders the start drawer.
- `end`: Renders the end drawer.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-drawer-container" attributes children


{-| Whether the end drawer is open. (default: `false`) -}
end : Bool -> Html.Attribute msg
end val_ =
    Html.Attributes.property "end" (Json.Encode.bool val_)


{-| Values for the `end-mode` attribute. -}
type EndMode
    = EndModeAuto
    | EndModeOver
    | EndModePush
    | EndModeSide


{-| The behavior mode of the end drawer. (default: `"side"`) -}
endMode : EndMode -> Html.Attribute msg
endMode val_ =
    Html.Attributes.attribute "end-mode" (endModeToString val_)


endModeToString : EndMode -> String
endModeToString val_ =
    case val_ of
        EndModeAuto ->
            "auto"
    
        EndModeOver ->
            "over"
    
        EndModePush ->
            "push"
    
        EndModeSide ->
            "side"


{-| Whether to show a divider between the end drawer and content for `side` mode. (default: `false`) -}
endDivider : Bool -> Html.Attribute msg
endDivider val_ =
    Html.Attributes.property "end-divider" (Json.Encode.bool val_)


{-| Whether the start drawer is open. (default: `false`) -}
start : Bool -> Html.Attribute msg
start val_ =
    Html.Attributes.property "start" (Json.Encode.bool val_)


{-| Values for the `start-mode` attribute. -}
type StartMode
    = StartModeAuto
    | StartModeOver
    | StartModePush
    | StartModeSide


{-| The behavior mode of the start drawer. (default: `"side"`) -}
startMode : StartMode -> Html.Attribute msg
startMode val_ =
    Html.Attributes.attribute "start-mode" (startModeToString val_)


startModeToString : StartMode -> String
startModeToString val_ =
    case val_ of
        StartModeAuto ->
            "auto"
    
        StartModeOver ->
            "over"
    
        StartModePush ->
            "push"
    
        StartModeSide ->
            "side"


{-| Whether to show a divider between the start drawer and content for `side` mode. (default: `false`) -}
startDivider : Bool -> Html.Attribute msg
startDivider val_ =
    Html.Attributes.property "start-divider" (Json.Encode.bool val_)


{-| Dispatched when the state of the start or end drawers change.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.
-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Renders the start drawer. -}
startSlot : Html.Attribute msg
startSlot =
    Html.Attributes.attribute "slot" "start"


{-| Renders the end drawer. -}
endSlot : Html.Attribute msg
endSlot =
    Html.Attributes.attribute "slot" "end"