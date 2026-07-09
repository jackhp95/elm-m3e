module M3e.Cem.RichTooltip exposing
    ( richTooltip, disabled, for, hideDelay, position, showDelay
    , touchGestures, onBeforetoggle, onToggle
    )

{-|
Middle layer for `<m3e-rich-tooltip>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.RichTooltip` module for everyday use.

@docs richTooltip, disabled, for, hideDelay, position, showDelay
@docs touchGestures, onBeforetoggle, onToggle
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.Html.RichTooltip
import M3e.Value


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
richTooltip :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , hideDelay : M3e.Value.Supported
    , position : M3e.Value.Supported
    , showDelay : M3e.Value.Supported
    , touchGestures : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
richTooltip attributes children =
    M3e.Cem.Html.RichTooltip.richTooltip
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.RichTooltip.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.RichTooltip.for


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay :
    Float -> M3e.Cem.Attr.Attr { c | hideDelay : M3e.Value.Supported } msg
hideDelay =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.RichTooltip.hideDelay


{-| The position of the tooltip. (default: `"below-after"`) -}
position :
    M3e.Value.Value { above : M3e.Value.Supported
    , aboveAfter : M3e.Value.Supported
    , aboveBefore : M3e.Value.Supported
    , after : M3e.Value.Supported
    , before : M3e.Value.Supported
    , below : M3e.Value.Supported
    , belowAfter : M3e.Value.Supported
    , belowBefore : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | position : M3e.Value.Supported } msg
position v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.RichTooltip.position
        (M3e.Value.toString v_)


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay :
    Float -> M3e.Cem.Attr.Attr { c | showDelay : M3e.Value.Supported } msg
showDelay =
    M3e.Cem.Attr.Internal.attribute M3e.Cem.Html.RichTooltip.showDelay


{-| The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGestures :
    M3e.Value.Value { auto : M3e.Value.Supported
    , off : M3e.Value.Supported
    , on : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | touchGestures : M3e.Value.Supported } msg
touchGestures v_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.RichTooltip.touchGestures
        (M3e.Value.toString v_)


{-| Listen for `beforetoggle` events. -}
onBeforetoggle :
    msg -> M3e.Cem.Attr.Attr { c | onBeforetoggle : M3e.Value.Supported } msg
onBeforetoggle f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.RichTooltip.onBeforetoggle
        (Json.Decode.succeed f_)


{-| Listen for `toggle` events. -}
onToggle : msg -> M3e.Cem.Attr.Attr { c | onToggle : M3e.Value.Supported } msg
onToggle f_ =
    M3e.Cem.Attr.Internal.attribute
        M3e.Cem.Html.RichTooltip.onToggle
        (Json.Decode.succeed f_)