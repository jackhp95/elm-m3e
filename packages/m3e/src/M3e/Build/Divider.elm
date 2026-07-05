module M3e.Build.Divider exposing ( Builder, AttrCaps, SlotCaps, divider )

{-|
The ⑤ Build shape for `<m3e-divider>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Divider as Divider`.

@docs Builder, AttrCaps, SlotCaps, divider
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-divider>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | divider : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { inset : M3e.Build.Internal.Available
    , insetStart : M3e.Build.Internal.Available
    , insetEnd : M3e.Build.Internal.Available
    , vertical : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-divider>`. -}
divider : Builder AttrCaps SlotCaps msg kind
divider =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")