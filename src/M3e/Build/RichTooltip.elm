module M3e.Build.RichTooltip exposing
    ( Builder, AttrCaps, SlotCaps, richTooltip, attr, disabled
    , for, hideDelay, position, showDelay, touchGestures, onBeforetoggle
    , onToggle, subhead, actions, build
    )

{-| The Build form for `<m3e-rich-tooltip>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.RichTooltip as RichTooltip`.

@docs Builder, AttrCaps, SlotCaps, richTooltip, attr, disabled
@docs for, hideDelay, position, showDelay, touchGestures, onBeforetoggle
@docs onToggle, subhead, actions, build

-}

import M3e.Build.Internal
import M3e.Html.RichTooltip
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-rich-tooltip>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | richTooltip : M3e.Kind.Brand
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , hideDelay : M3e.Build.Internal.Available
    , position : M3e.Build.Internal.Available
    , showDelay : M3e.Build.Internal.Available
    , touchGestures : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { subhead : M3e.Build.Internal.Available
    , actions : M3e.Build.Internal.Available
    }


{-| Seed a `Builder` for `<m3e-rich-tooltip>` with the required fields.
-}
richTooltip :
    { content : Markup.Element.Element { text : Markup.Kind.Shared } msg }
    -> Builder AttrCaps SlotCaps msg kind
richTooltip req_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.RichTooltip.richTooltip
                    (List.map Markup.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            [ Markup.Element.toNode req_.content ]
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    Markup.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled. (default: `false`)
-}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.RichTooltip.disabled v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | for : M3e.Build.Internal.Used } s msg kind
for v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget (M3e.Html.RichTooltip.for v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`)
-}
hideDelay :
    Float
    -> Builder { a | hideDelay : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | hideDelay : M3e.Build.Internal.Used } s msg kind
hideDelay v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.RichTooltip.hideDelay v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


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
    -> Builder { a | position : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | position : M3e.Build.Internal.Used } s msg kind
position v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.RichTooltip.position v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`)
-}
showDelay :
    Float
    -> Builder { a | showDelay : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | showDelay : M3e.Build.Internal.Used } s msg kind
showDelay v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.RichTooltip.showDelay v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| The mode in which to handle touch gestures. (default: `"auto"`)
-}
touchGestures :
    M3e.Token.Value
        { auto : M3e.Token.Supported
        , off : M3e.Token.Supported
        , on : M3e.Token.Supported
        }
    -> Builder { a | touchGestures : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | touchGestures : M3e.Build.Internal.Used } s msg kind
touchGestures v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.RichTooltip.touchGestures v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched before the toggle state changes.
-}
onBeforetoggle :
    msg
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onBeforetoggle : M3e.Build.Internal.Used } s msg kind
onBeforetoggle v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.RichTooltip.onBeforetoggle v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched after the toggle state has changed.
-}
onToggle :
    msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onToggle : M3e.Build.Internal.Used } s msg kind
onToggle v_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.RichTooltip.onToggle v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `subhead` slot.
-}
subhead :
    Markup.Element.Element { text : Markup.Kind.Shared } msg
    -> Builder a { s | subhead : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | subhead : M3e.Build.Internal.Used } msg kind
subhead el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "subhead" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `actions` slot.
-}
actions :
    Markup.Element.Element any msg
    -> Builder a { s | actions : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | actions : M3e.Build.Internal.Used } msg kind
actions el_ b_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (Markup.Element.toNode (Markup.Element.withSlot "actions" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-rich-tooltip>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { richTooltip : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
