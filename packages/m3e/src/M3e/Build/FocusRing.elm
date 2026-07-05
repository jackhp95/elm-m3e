module M3e.Build.FocusRing exposing ( Builder, AttrCaps, SlotCaps, focusRing )

{-|
The ⑤ Build shape for `<m3e-focus-ring>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FocusRing as FocusRing`.

@docs Builder, AttrCaps, SlotCaps, focusRing
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-focus-ring>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | focusRing : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , inward : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-focus-ring>`. -}
focusRing : Builder AttrCaps SlotCaps msg kind
focusRing =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")