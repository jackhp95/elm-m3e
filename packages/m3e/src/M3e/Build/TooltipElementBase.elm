module M3e.Build.TooltipElementBase exposing
    ( Builder, AttrCaps, SlotCaps, tooltipElementBase, attr, disabled
    , showDelay, hideDelay, touchGestures, for, build
    )

{-|
The ⑤ Build shape for `<TooltipElementBase>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.TooltipElementBase as TooltipElementBase`.

@docs Builder, AttrCaps, SlotCaps, tooltipElementBase, attr, disabled
@docs showDelay, hideDelay, touchGestures, for, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.TooltipElementBase
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<TooltipElementBase>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | tooltipElementBase : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , showDelay : M3e.Build.Internal.Available
    , hideDelay : M3e.Build.Internal.Available
    , touchGestures : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<TooltipElementBase>`. -}
tooltipElementBase : Builder AttrCaps SlotCaps msg kind
tooltipElementBase =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.TooltipElementBase.tooltipElementBase
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times. -}
attr :
    M3e.Cem.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget a_)
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg kind
disabled v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.TooltipElementBase.disabled v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`) -}
showDelay :
    Float
    -> Builder { a | showDelay : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | showDelay : M3e.Build.Internal.Used } s msg kind
showDelay v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.TooltipElementBase.showDelay v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`) -}
hideDelay :
    Float
    -> Builder { a | hideDelay : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | hideDelay : M3e.Build.Internal.Used } s msg kind
hideDelay v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.TooltipElementBase.hideDelay v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| The mode in which to handle touch gestures. (default: `"auto"`) -}
touchGestures :
    M3e.Value.Value { auto : M3e.Value.Supported
    , off : M3e.Value.Supported
    , on : M3e.Value.Supported
    }
    -> Builder { a | touchGestures : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | touchGestures : M3e.Build.Internal.Used } s msg kind
touchGestures v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.TooltipElementBase.touchGestures v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | for : M3e.Build.Internal.Used } s msg kind
for v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.TooltipElementBase.for v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<TooltipElementBase>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { tooltipElementBase : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)