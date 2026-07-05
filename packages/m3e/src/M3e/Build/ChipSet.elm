module M3e.Build.ChipSet exposing ( Builder, AttrCaps, SlotCaps, chipSet )

{-|
The ⑤ Build shape for `<m3e-chip-set>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ChipSet as ChipSet`.

@docs Builder, AttrCaps, SlotCaps, chipSet
-}


import M3e.Build.Internal
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
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")