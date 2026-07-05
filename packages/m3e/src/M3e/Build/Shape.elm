module M3e.Build.Shape exposing ( Builder, AttrCaps, SlotCaps, shape )

{-|
The ⑤ Build shape for `<m3e-shape>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Shape as Shape`.

@docs Builder, AttrCaps, SlotCaps, shape
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-shape>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | shape : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { name : M3e.Build.Internal.Available }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { default : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-shape>`. -}
shape : Builder AttrCaps SlotCaps msg kind
shape =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")