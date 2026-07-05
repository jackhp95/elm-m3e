module M3e.Build.RichTooltipAction exposing
    ( Builder, AttrCaps, SlotCaps, richTooltipAction, disableRestoreFocus
    )

{-|
The ⑤ Build shape for `<m3e-rich-tooltip-action>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.RichTooltipAction as RichTooltipAction`.

@docs Builder, AttrCaps, SlotCaps, richTooltipAction, disableRestoreFocus
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.RichTooltipAction
import M3e.Element
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-rich-tooltip-action>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | richTooltipAction : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disableRestoreFocus : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-rich-tooltip-action>` with the required fields. -}
richTooltipAction :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg kind
richTooltipAction req_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.RichTooltipAction.richTooltipAction
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             (List.map M3e.Cem.Attr.forget [])
             [ M3e.Element.toNode req_.content ]
        )


{-| Whether to focus should not be restored to the trigger when activated. (default: `false`) -}
disableRestoreFocus :
    Bool
    -> Builder { a
        | disableRestoreFocus : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { disableRestoreFocus : M3e.Build.Internal.Used } s msg kind
disableRestoreFocus v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.RichTooltipAction.disableRestoreFocus v_)
             )
             (M3e.Build.Internal.node_ b_)
        )