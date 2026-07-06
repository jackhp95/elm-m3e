module M3e.Build.ProgressElementIndicatorBase exposing
    ( Builder, AttrCaps, SlotCaps, progressElementIndicatorBase, attr, value
    , max, variant, build
    )

{-|
The ⑤ Build shape for `<ProgressElementIndicatorBase>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ProgressElementIndicatorBase as ProgressElementIndicatorBase`.

@docs Builder, AttrCaps, SlotCaps, progressElementIndicatorBase, attr, value
@docs max, variant, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.ProgressElementIndicatorBase
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<ProgressElementIndicatorBase>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | progressElementIndicatorBase : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { valueFloat : M3e.Build.Internal.Available
    , max : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<ProgressElementIndicatorBase>`. -}
progressElementIndicatorBase : Builder AttrCaps SlotCaps msg kind
progressElementIndicatorBase =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ProgressElementIndicatorBase.progressElementIndicatorBase
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


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`) -}
value :
    Float
    -> Builder { a | valueFloat : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | valueFloat : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.ProgressElementIndicatorBase.value v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| The maximum progress value. (default: `100`) -}
max :
    Float
    -> Builder { a | max : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | max : M3e.Build.Internal.Used } s msg kind
max v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.ProgressElementIndicatorBase.max v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| The appearance of the indicator. (default: `"flat"`) -}
variant :
    M3e.Value.Value { flat : M3e.Value.Supported, wavy : M3e.Value.Supported }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.ProgressElementIndicatorBase.variant v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<ProgressElementIndicatorBase>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { progressElementIndicatorBase : M3e.Value.Supported
    } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)