module M3e.Build.RichTooltipAction exposing
    ( Builder, AttrCaps, SlotCaps, richTooltipAction, attr, disableRestoreFocus
    , build
    )

{-| The Build form for `<m3e-rich-tooltip-action>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.RichTooltipAction as RichTooltipAction`.

@docs Builder, AttrCaps, SlotCaps, richTooltipAction, attr, disableRestoreFocus
@docs build

-}

import M3e.Build.Internal
import M3e.Html.RichTooltipAction
import M3e.Kind
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Phantom-typed opaque builder for `<m3e-rich-tooltip-action>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | richTooltipAction : M3e.Kind.Brand
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
    { content : Markup.Element.Element { sharedText : Markup.Kind.Shared } msg }
    -> Builder AttrCaps SlotCaps msg kind
richTooltipAction req_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.RichTooltipAction.richTooltipAction
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
        (Markup.Node.addAttr
            (Markup.Html.Attr.Internal.forget
                (M3e.Html.RichTooltipAction.disableRestoreFocus v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-rich-tooltip-action>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> Markup.Element.Element { richTooltipAction : M3e.Kind.Brand } msg
build b_ =
    Markup.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
