module M3e.Html.RichTooltip exposing
    ( richTooltip, disabled, for, hideDelay, position, showDelay
    , touchGestures, onBeforetoggle, onToggle
    )

{-| Middle layer for `<m3e-rich-tooltip>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.RichTooltip` module for everyday use.

@docs richTooltip, disabled, for, hideDelay, position, showDelay
@docs touchGestures, onBeforetoggle, onToggle

-}

import Html
import Json.Decode
import M3e.Raw.RichTooltip
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


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
    List
        (Markup.Html.Attr.Attr
            { disabled : M3e.Token.Supported
            , for : M3e.Token.Supported
            , hideDelay : M3e.Token.Supported
            , position : M3e.Token.Supported
            , showDelay : M3e.Token.Supported
            , touchGestures : M3e.Token.Supported
            , onBeforetoggle : M3e.Token.Supported
            , onToggle : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
richTooltip attributes children =
    M3e.Raw.RichTooltip.richTooltip
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    Markup.Html.Attr.Internal.attribute M3e.Raw.RichTooltip.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    Markup.Html.Attr.Internal.attribute M3e.Raw.RichTooltip.for


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`)
-}
hideDelay : Float -> Markup.Html.Attr.Attr { c | hideDelay : M3e.Token.Supported } msg
hideDelay =
    Markup.Html.Attr.Internal.attribute M3e.Raw.RichTooltip.hideDelay


{-| The position of the tooltip. (default: `"below-after"`)
-}
position :
    M3e.Token.Value
        { above : M3e.Token.Supported
        , aboveAfter : M3e.Token.Supported
        , aboveBefore : M3e.Token.Supported
        , after : M3e.Token.Supported
        , before : M3e.Token.Supported
        , below : M3e.Token.Supported
        , belowAfter : M3e.Token.Supported
        , belowBefore : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | position : M3e.Token.Supported } msg
position v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.RichTooltip.position
        (M3e.Token.toString v_)


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`)
-}
showDelay : Float -> Markup.Html.Attr.Attr { c | showDelay : M3e.Token.Supported } msg
showDelay =
    Markup.Html.Attr.Internal.attribute M3e.Raw.RichTooltip.showDelay


{-| The mode in which to handle touch gestures. (default: `"auto"`)
-}
touchGestures :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , off : M3e.Token.Supported
        , on : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | touchGestures : M3e.Token.Supported } msg
touchGestures v_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.RichTooltip.touchGestures
        (M3e.Token.toString v_)


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle :
    msg
    -> Markup.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.RichTooltip.onBeforetoggle
        (Json.Decode.succeed f_)


{-| Listen for `toggle` events.
-}
onToggle : msg -> Markup.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle f_ =
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.RichTooltip.onToggle
        (Json.Decode.succeed f_)
