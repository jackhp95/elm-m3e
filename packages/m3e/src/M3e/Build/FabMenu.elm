module M3e.Build.FabMenu exposing ( Builder, AttrCaps, SlotCaps, fabMenu )

{-|
The ⑤ Build shape for `<m3e-fab-menu>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FabMenu as FabMenu`.

@docs Builder, AttrCaps, SlotCaps, fabMenu
-}


import M3e.Build.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-fab-menu>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | fabMenu : M3e.Value.Supported
    } attrCaps slotCaps msg


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { variant : M3e.Build.Internal.Available
    , onBeforetoggle : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


{-| Seed a `Builder` for `<m3e-fab-menu>`. -}
fabMenu : Builder AttrCaps SlotCaps msg kind
fabMenu =
    M3e.Build.Internal.wrap_ (M3e.Node.text "<stub — Task 3 replaces>")