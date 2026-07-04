module M3e.Build.MenuTrigger exposing ( Builder, AttrCaps, SlotCaps, menuTrigger )

{-|
The ⑤ Build shape for `<m3e-menu-trigger>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MenuTrigger as MenuTrigger`.

@docs Builder, AttrCaps, SlotCaps, menuTrigger
-}


import M3e.Element


{-| Opaque builder for `<m3e-menu-trigger>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { for : Maybe String, default : Maybe (M3e.Element.Element any_ msg) }


{-| Seed a `Builder` for `<m3e-menu-trigger>`. -}
menuTrigger : Builder AttrCaps SlotCaps msg
menuTrigger =
    Builder { for = Nothing, default = Nothing }