module M3e.TooltipElementBase exposing (TouchGestures(..), component, disabled, for, hideDelay, showDelay, touchGestures)

{-| 
Provides a base implementation for a tooltip. This class must be inherited.

## Component

@docs component

### Attributes

@docs disabled, showDelay, hideDelay, TouchGestures, touchGestures, for
-}


import Html
import Html.Attributes
import Json.Encode


{-| Provides a base implementation for a tooltip. This class must be inherited. -}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "div" attributes children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay : Float -> Html.Attribute msg
showDelay val_ =
    Html.Attributes.property "show-delay" (Json.Encode.float val_)


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay : Float -> Html.Attribute msg
hideDelay val_ =
    Html.Attributes.property "hide-delay" (Json.Encode.float val_)


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


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_