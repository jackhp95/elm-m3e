module M3e.Build.Ripple exposing ( Builder, AttrCaps, SlotCaps, ripple )

{-|
The ⑤ Build shape for `<m3e-ripple>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Ripple as Ripple`.

@docs Builder, AttrCaps, SlotCaps, ripple
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-ripple>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | ripple : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { centered : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , radius : M3e.Build.Internal.Available
    , unbounded : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-ripple>`. -}
ripple : Builder AttrCaps SlotCaps msg kind
ripple =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")