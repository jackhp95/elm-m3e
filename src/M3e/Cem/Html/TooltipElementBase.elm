module M3e.Cem.Html.TooltipElementBase exposing
    ( tooltipElementBase, disabled, showDelay, hideDelay, touchGestures, for
    )

{-|
Bottom layer for `<TooltipElementBase>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs tooltipElementBase, disabled, showDelay, hideDelay, touchGestures, for
-}


import Html
import Html.Attributes


{-| The raw `<div>` element — a partial application of `Html.node`. -}
tooltipElementBase :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
tooltipElementBase =
    Html.node "div"


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""
    
    else
        Html.Attributes.classList []


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay : Float -> Html.Attribute msg
showDelay val_ =
    Html.Attributes.attribute "show-delay" (String.fromFloat val_)


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay : Float -> Html.Attribute msg
hideDelay val_ =
    Html.Attributes.attribute "hide-delay" (String.fromFloat val_)


{-| The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGestures : String -> Html.Attribute msg
touchGestures =
    Html.Attributes.attribute "touch-gestures"


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"