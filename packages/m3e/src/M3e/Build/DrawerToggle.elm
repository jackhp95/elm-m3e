module M3e.Build.DrawerToggle exposing ( Builder, AttrCaps, SlotCaps, drawerToggle )

{-|
The ⑤ Build shape for `<m3e-drawer-toggle>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.DrawerToggle as DrawerToggle`.

@docs Builder, AttrCaps, SlotCaps, drawerToggle
-}


import M3e.Element


{-| Opaque builder for `<m3e-drawer-toggle>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { for : Maybe String
    , default : Maybe (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-drawer-toggle>`. -}
drawerToggle : Builder AttrCaps SlotCaps msg
drawerToggle =
    Builder { for = Nothing, default = Nothing, phantomMsg_ = Nothing }