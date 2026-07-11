module M3e.Build.RichTooltipAction exposing
    ( Builder, AttrCaps, SlotCaps, richTooltipAction, attr, disableRestoreFocus
    , build
    )

{-| The Build form for `<m3e-rich-tooltip-action>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.RichTooltipAction as RichTooltipAction`.

@docs Builder, AttrCaps, SlotCaps, richTooltipAction, attr, disableRestoreFocus
@docs build

-}

import M3e.Build.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr.Internal
import M3e.Html.RichTooltipAction
import M3e.Node
import M3e.Token


{-| Phantom-typed opaque builder for `<m3e-rich-tooltip-action>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | richTooltipAction : M3e.Token.Supported
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { disableRestoreFocus : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-rich-tooltip-action>` with the required fields.
-}
richTooltipAction :
    { content : M3e.Element.Element { text : M3e.Token.Supported } msg }
    -> Builder AttrCaps SlotCaps msg kind
richTooltipAction req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.RichTooltipAction.richTooltipAction
                    (List.map M3e.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            [ M3e.Element.toNode req_.content ]
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    M3e.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether to focus should not be restored to the trigger when activated. (default: `false`)
-}
disableRestoreFocus :
    Bool
    ->
        Builder
            { a
                | disableRestoreFocus : M3e.Build.Internal.Available
            }
            s
            msg
            kind
    -> Builder { a | disableRestoreFocus : M3e.Build.Internal.Used } s msg kind
disableRestoreFocus v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.RichTooltipAction.disableRestoreFocus v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-rich-tooltip-action>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> M3e.Element.Element { richTooltipAction : M3e.Token.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
