module Cem.M3e.Tooltip exposing
    ( component
    , disabled, for, hideDelay, Position(..), position, showDelay, TouchGestures(..), touchGestures
    , positionToString, touchGesturesToString
    )

{-| Adds additional context to a button or other UI element.


## Component

@docs component


### Attributes

@docs disabled, for, hideDelay, Position, position, showDelay, TouchGestures, touchGestures

-}

import Html
import Html.Attributes
import Json.Encode


{-| Adds additional context to a button or other UI element.

**Component Info:**

  - **Extends:** `TooltipElementBase` from `/src/tooltip/TooltipElementBase`

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-tooltip" attributes children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`)
-}
hideDelay : Float -> Html.Attribute msg
hideDelay val_ =
    Html.Attributes.property "hideDelay" (Json.Encode.float val_)


{-| Values for the `position` attribute.
-}
type Position
    = Above
    | After
    | Before
    | Below


{-| The position of the tooltip. (default: `"below"`)
-}
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


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`)
-}
showDelay : Float -> Html.Attribute msg
showDelay val_ =
    Html.Attributes.property "showDelay" (Json.Encode.float val_)


{-| Values for the `touch-gestures` attribute.
-}
type TouchGestures
    = Auto
    | Off
    | On


{-| The mode in which to handle touch gestures. (default: `"auto"`)
-}
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
