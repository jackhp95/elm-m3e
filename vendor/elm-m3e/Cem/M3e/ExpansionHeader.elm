module Cem.M3e.ExpansionHeader exposing (ToggleDirection(..), TogglePosition(..), component, disabled, hideToggle, onClick, toggleDirection, toggleIconSlot, togglePosition)

{-| 
A button used to toggle the expanded state of an expansion panel.

## Component

@docs component

### Attributes

@docs hideToggle, ToggleDirection, toggleDirection, TogglePosition, togglePosition, disabled

### Events

@docs onClick

### Slots

@docs toggleIconSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A button used to toggle the expanded state of an expansion panel.

**Events:**
- `click`: Dispatched when the element is clicked.

**Slots:**
- `toggle-icon`: Renders the icon of the expansion toggle.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-expansion-header" attributes children


{-| Whether to hide the expansion toggle. (default: `false`) -}
hideToggle : Bool -> Html.Attribute msg
hideToggle val_ =
    Html.Attributes.property "hide-toggle" (Json.Encode.bool val_)


{-| Values for the `toggle-direction` attribute. -}
type ToggleDirection
    = Horizontal
    | Vertical


{-| The direction of the expansion toggle. (default: `"vertical"`) -}
toggleDirection : ToggleDirection -> Html.Attribute msg
toggleDirection val_ =
    Html.Attributes.attribute "toggle-direction" (toggleDirectionToString val_)


toggleDirectionToString : ToggleDirection -> String
toggleDirectionToString val_ =
    case val_ of
        Horizontal ->
            "horizontal"
    
        Vertical ->
            "vertical"


{-| Values for the `toggle-position` attribute. -}
type TogglePosition
    = After
    | Before


{-| The position of the expansion toggle. (default: `"after"`) -}
togglePosition : TogglePosition -> Html.Attribute msg
togglePosition val_ =
    Html.Attributes.attribute "toggle-position" (togglePositionToString val_)


togglePositionToString : TogglePosition -> String
togglePositionToString val_ =
    case val_ of
        After ->
            "after"
    
        Before ->
            "before"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Dispatched when the element is clicked.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders the icon of the expansion toggle. -}
toggleIconSlot : Html.Attribute msg
toggleIconSlot =
    Html.Attributes.attribute "slot" "toggle-icon"