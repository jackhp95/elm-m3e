module M3e.Tooltip exposing (Position(..), component, position)

{-| 
Adds additional context to a button or other UI element.

## Component

@docs component

### Attributes

@docs Position, position
-}


import Html
import Html.Attributes


{-| Adds additional context to a button or other UI element.

**Component Info:**
- **Extends:** `TooltipElementBase` from `/src/tooltip/TooltipElementBase`
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-tooltip" attributes children


{-| Values for the `position` attribute. -}
type Position
    = Above
    | After
    | Before
    | Below


{-| The position of the tooltip. (default: `"below"`) -}
position : Position -> Html.Attribute msg
position val_ =
    Html.Attributes.attribute "position" (positionToString val_)


positionToString : Position -> String
positionToString val_ =
    case val_ of
        Above ->
            "above"
    
        After ->
            "after"
    
        Before ->
            "before"
    
        Below ->
            "below"