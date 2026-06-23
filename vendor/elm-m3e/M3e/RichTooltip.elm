module M3e.RichTooltip exposing (Position(..), actionsSlot, component, onBeforetoggle, onToggle, position, subheadSlot)

{-| 
Provides contextual details for a control, such as explaining the value or purpose of a feature.

## Component

@docs component

### Attributes

@docs Position, position

### Events

@docs onBeforetoggle, onToggle

### Slots

@docs subheadSlot, actionsSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode


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