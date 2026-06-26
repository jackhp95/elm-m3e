module Cem.M3e.RichTooltip exposing (Position(..), TouchGestures(..), actionsSlot, component, disabled, for, hideDelay, onBeforetoggle, onToggle, position, showDelay, subheadSlot, touchGestures)

{-| 
Provides contextual details for a control, such as explaining the value or purpose of a feature.

## Component

@docs component

### Attributes

@docs disabled, for, hideDelay, Position, position, showDelay, TouchGestures, touchGestures

### Events

@docs onBeforetoggle, onToggle

### Slots

@docs subheadSlot, actionsSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Provides contextual details for a control, such as explaining the value or purpose of a feature.

**Component Info:**
- **Extends:** `TooltipElementBase` from `/src/tooltip/TooltipElementBase`

**Events:**
- `beforetoggle`: Dispatched before the toggle state changes.
- `toggle`: Dispatched after the toggle state has changed.

**Slots:**
- `subhead`: Optional subhead text displayed above the supporting content.
- `actions`: Optional action elements displayed at the bottom of the tooltip.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-rich-tooltip" attributes children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay : Float -> Html.Attribute msg
hideDelay val_ =
    Html.Attributes.property "hide-delay" (Json.Encode.float val_)


{-| Values for the `position` attribute. -}
type Position
    = Above
    | AboveAfter
    | AboveBefore
    | After
    | Before
    | Below
    | BelowAfter
    | BelowBefore


{-| The position of the tooltip. (default: `"below-after"`) -}
position : Position -> Html.Attribute msg
position val_ =
    Html.Attributes.attribute "position" (positionToString val_)


positionToString : Position -> String
positionToString val_ =
    case val_ of
        Above ->
            "above"
    
        AboveAfter ->
            "above-after"
    
        AboveBefore ->
            "above-before"
    
        After ->
            "after"
    
        Before ->
            "before"
    
        Below ->
            "below"
    
        BelowAfter ->
            "below-after"
    
        BelowBefore ->
            "below-before"


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay : Float -> Html.Attribute msg
showDelay val_ =
    Html.Attributes.property "show-delay" (Json.Encode.float val_)


{-| Values for the `touch-gestures` attribute. -}
type TouchGestures
    = Auto
    | Off
    | On


{-| The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGestures : TouchGestures -> Html.Attribute msg
touchGestures val_ =
    Html.Attributes.attribute "touch-gestures" (touchGesturesToString val_)


touchGesturesToString : TouchGestures -> String
touchGesturesToString val_ =
    case val_ of
        Auto ->
            "auto"
    
        Off ->
            "off"
    
        On ->
            "on"


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


{-| Optional subhead text displayed above the supporting content. -}
subheadSlot : Html.Attribute msg
subheadSlot =
    Html.Attributes.attribute "slot" "subhead"


{-| Optional action elements displayed at the bottom of the tooltip. -}
actionsSlot : Html.Attribute msg
actionsSlot =
    Html.Attributes.attribute "slot" "actions"