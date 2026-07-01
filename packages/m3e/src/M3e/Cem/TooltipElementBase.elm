module M3e.Cem.TooltipElementBase exposing (disabled, for, hideDelay, showDelay, tooltipElementBase, touchGestures)

{-| 
@docs tooltipElementBase, disabled, showDelay, hideDelay, touchGestures, for
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.TooltipElementBase
import M3e.Value


{-| Provides a base implementation for a tooltip. This class must be inherited. -}
tooltipElementBase :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , showDelay : M3e.Value.Supported
    , hideDelay : M3e.Value.Supported
    , touchGestures : M3e.Value.Supported
    , for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
tooltipElementBase attributes children =
    M3e.Cem.Html.TooltipElementBase.tooltipElementBase
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.TooltipElementBase.disabled


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay :
    Float -> M3e.Cem.Attr.Attr { c | showDelay : M3e.Value.Supported } msg
showDelay =
    M3e.Cem.Attr.attribute M3e.Cem.Html.TooltipElementBase.showDelay


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay :
    Float -> M3e.Cem.Attr.Attr { c | hideDelay : M3e.Value.Supported } msg
hideDelay =
    M3e.Cem.Attr.attribute M3e.Cem.Html.TooltipElementBase.hideDelay


{-| The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGestures :
    M3e.Value.Value { auto : M3e.Value.Supported
    , off : M3e.Value.Supported
    , on : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | touchGestures : M3e.Value.Supported } msg
touchGestures v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.TooltipElementBase.touchGestures
        (M3e.Value.toString v_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.attribute M3e.Cem.Html.TooltipElementBase.for