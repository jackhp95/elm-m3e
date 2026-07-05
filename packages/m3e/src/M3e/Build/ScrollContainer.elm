module M3e.Build.ScrollContainer exposing ( Builder, AttrCaps, SlotCaps, scrollContainer )

{-|
The ⑤ Build shape for `<m3e-scroll-container>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ScrollContainer as ScrollContainer`.

@docs Builder, AttrCaps, SlotCaps, scrollContainer
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-scroll-container>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | scrollContainer : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { dividers : M3e.Build.Internal.Available
    , thin : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-scroll-container>`. -}
scrollContainer : Builder AttrCaps SlotCaps msg kind
scrollContainer =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")