module M3e.Build.FabMenuTrigger exposing ( Builder, AttrCaps, SlotCaps )

{-|
The ⑤ Build shape for `<m3e-fab-menu-trigger>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FabMenuTrigger as FabMenuTrigger`.

@docs Builder, AttrCaps, SlotCaps
-}



{-| Opaque builder for `<m3e-fab-menu-trigger>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder Fields


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields =
    {}