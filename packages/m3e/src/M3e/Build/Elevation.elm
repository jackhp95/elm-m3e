module M3e.Build.Elevation exposing ( Builder, AttrCaps, SlotCaps, elevation )

{-|
The ⑤ Build shape for `<m3e-elevation>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Elevation as Elevation`.

@docs Builder, AttrCaps, SlotCaps, elevation
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-elevation>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | elevation : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , level : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-elevation>`. -}
elevation : Builder AttrCaps SlotCaps msg kind
elevation =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")