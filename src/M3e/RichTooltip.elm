module M3e.RichTooltip exposing
    ( view, disabled, for, hideDelay, position, showDelay
    , touchGestures, onBeforetoggle, onToggle, subhead, actions
    )

{-| Provides contextual details for a control, such as explaining the value or purpose of a feature.

**Component Info:**

  - **Extends:** `TooltipElementBase` from `/src/tooltip/TooltipElementBase`

**Events:**

  - `beforetoggle`: Dispatched before the toggle state changes.
  - `toggle`: Dispatched after the toggle state has changed.

**Slots:**

  - `subhead`: Optional subhead text displayed above the supporting content.
  - `actions`: Optional action elements displayed at the bottom of the tooltip.

@docs view, disabled, for, hideDelay, position, showDelay
@docs touchGestures, onBeforetoggle, onToggle, subhead, actions

-}

import M3e.Html.RichTooltip
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-rich-tooltip>` element (lazy IR).
-}
view :
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
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | richTooltip : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.RichTooltip.richTooltip
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Markup.Html.Attr.Attr { c | disabled : M3e.Token.Supported } msg
disabled =
    M3e.Html.RichTooltip.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Markup.Html.Attr.Attr { c | for : M3e.Token.Supported } msg
for =
    M3e.Html.RichTooltip.for


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`)
-}
hideDelay : Float -> Markup.Html.Attr.Attr { c | hideDelay : M3e.Token.Supported } msg
hideDelay =
    M3e.Html.RichTooltip.hideDelay


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
position =
    M3e.Html.RichTooltip.position


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`)
-}
showDelay : Float -> Markup.Html.Attr.Attr { c | showDelay : M3e.Token.Supported } msg
showDelay =
    M3e.Html.RichTooltip.showDelay


{-| The mode in which to handle touch gestures. (default: `"auto"`)
-}
touchGestures :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , off : M3e.Token.Supported
        , on : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | touchGestures : M3e.Token.Supported } msg
touchGestures =
    M3e.Html.RichTooltip.touchGestures


{-| Listen for `beforetoggle` events.
-}
onBeforetoggle :
    msg
    -> Markup.Html.Attr.Attr { c | onBeforetoggle : M3e.Token.Supported } msg
onBeforetoggle =
    M3e.Html.RichTooltip.onBeforetoggle


{-| Listen for `toggle` events.
-}
onToggle : msg -> Markup.Html.Attr.Attr { c | onToggle : M3e.Token.Supported } msg
onToggle =
    M3e.Html.RichTooltip.onToggle


{-| Place content in the `subhead` slot.
-}
subhead :
    Markup.Element.Element { text : Markup.Kind.Shared } msg
    -> Markup.Element.Element k msg
subhead el =
    Markup.Element.Internal.placeSlot "subhead" el


{-| Place content in the `actions` slot.
-}
actions : Markup.Element.Element any msg -> Markup.Element.Element k msg
actions el =
    Markup.Element.Internal.placeSlot "actions" el
