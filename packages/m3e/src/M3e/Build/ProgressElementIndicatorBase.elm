module M3e.Build.ProgressElementIndicatorBase exposing
    ( Builder, AttrCaps, SlotCaps, progressElementIndicatorBase, value, max
    , variant
    )

{-|
The ⑤ Build shape for `<ProgressElementIndicatorBase>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ProgressElementIndicatorBase as ProgressElementIndicatorBase`.

@docs Builder, AttrCaps, SlotCaps, progressElementIndicatorBase, value, max
@docs variant
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.ProgressElementIndicatorBase
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<ProgressElementIndicatorBase>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | progressElementIndicatorBase : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { value : M3e.Build.Internal.Available
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
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`) -}
value :
    Float
    -> Builder { a | value : M3e.Build.Internal.Available } s msg kind
    -> Builder { value : M3e.Build.Internal.Used } s msg kind
value v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.ProgressElementIndicatorBase.value v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| The maximum progress value. (default: `100`) -}
max :
    Float
    -> Builder { a | max : M3e.Build.Internal.Available } s msg kind
    -> Builder { max : M3e.Build.Internal.Used } s msg kind
max v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.ProgressElementIndicatorBase.max v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The appearance of the indicator. (default: `"flat"`) -}
variant :
    M3e.Value.Value { flat : M3e.Value.Supported, wavy : M3e.Value.Supported }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget
                  (M3e.Cem.ProgressElementIndicatorBase.variant v_)
             )
             (M3e.Build.Internal.node_ b_)
        )