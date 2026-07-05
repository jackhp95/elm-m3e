module M3e.Build.Skeleton exposing ( Builder, AttrCaps, SlotCaps, skeleton )

{-|
The ⑤ Build shape for `<m3e-skeleton>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Skeleton as Skeleton`.

@docs Builder, AttrCaps, SlotCaps, skeleton
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-skeleton>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | skeleton : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { animation : M3e.Build.Internal.Available
    , shape : M3e.Build.Internal.Available
    , loaded : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-skeleton>`. -}
skeleton : Builder AttrCaps SlotCaps msg kind
skeleton =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")