module M3e.Build.ChipSet exposing
    ( Builder, AttrCaps, SlotCaps, chipSet, vertical
    )

{-|
The ⑤ Build shape for `<m3e-chip-set>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ChipSet as ChipSet`.

@docs Builder, AttrCaps, SlotCaps, chipSet, vertical
-}


import M3e.Build.Internal
import M3e.Cem.Attr
import M3e.Cem.ChipSet
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-chip-set>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | chipSet : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { vertical : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-chip-set>`. -}
chipSet : Builder AttrCaps SlotCaps msg kind
chipSet =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.ChipSet.chipSet
                      (List.map M3e.Cem.Attr.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical :
    Bool
    -> Builder { a | vertical : M3e.Build.Internal.Available } s msg kind
    -> Builder { vertical : M3e.Build.Internal.Used } s msg kind
vertical v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.forget (M3e.Cem.ChipSet.vertical v_))
             (M3e.Build.Internal.node_ b_)
        )