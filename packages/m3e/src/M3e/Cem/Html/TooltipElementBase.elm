module M3e.Cem.Html.TooltipElementBase exposing (disabled, for, hideDelay, showDelay, tooltipElementBase, touchGestures)

{-| 
@docs tooltipElementBase, disabled, showDelay, hideDelay, touchGestures, for
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<div>` element — a partial application of `Html.node`. -}
tooltipElementBase :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
tooltipElementBase =
    Html.node "div"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay : Float -> Html.Attribute msg
showDelay val_ =
    Html.Attributes.property "showDelay" (Json.Encode.float val_)


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay : Float -> Html.Attribute msg
hideDelay val_ =
    Html.Attributes.property "hideDelay" (Json.Encode.float val_)


{-| The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGestures : String -> Html.Attribute msg
touchGestures =
    Html.Attributes.attribute "touch-gestures"


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"