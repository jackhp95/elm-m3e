module M3e.Cem.Tooltip exposing (disabled, for, hideDelay, position, showDelay, tooltip, touchGestures)

{-| 
@docs tooltip, disabled, for, hideDelay, position, showDelay, touchGestures
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.Tooltip
import M3e.Value


{-| Adds additional context to a button or other UI element.

**Component Info:**
- **Extends:** `TooltipElementBase` from `/src/tooltip/TooltipElementBase`
-}
tooltip :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , hideDelay : M3e.Value.Supported
    , position : M3e.Value.Supported
    , showDelay : M3e.Value.Supported
    , touchGestures : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
tooltip attributes children =
    M3e.Cem.Html.Tooltip.tooltip
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Tooltip.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Tooltip.for


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay :
    Float -> M3e.Cem.Attr.Attr { c | hideDelay : M3e.Value.Supported } msg
hideDelay =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Tooltip.hideDelay


{-| The position of the tooltip. (default: `"below"`) -}
position :
    M3e.Value.Value { above : M3e.Value.Supported
    , after : M3e.Value.Supported
    , before : M3e.Value.Supported
    , below : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | position : M3e.Value.Supported } msg
position v_ =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Tooltip.position (M3e.Value.toString v_)


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay :
    Float -> M3e.Cem.Attr.Attr { c | showDelay : M3e.Value.Supported } msg
showDelay =
    M3e.Cem.Attr.attribute M3e.Cem.Html.Tooltip.showDelay


{-| The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGestures :
    M3e.Value.Value { auto : M3e.Value.Supported
    , off : M3e.Value.Supported
    , on : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | touchGestures : M3e.Value.Supported } msg
touchGestures v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.Tooltip.touchGestures
        (M3e.Value.toString v_)