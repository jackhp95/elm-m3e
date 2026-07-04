module M3e.Build.FabMenuTrigger exposing ( Builder, AttrCaps, SlotCaps, fabMenuTrigger )

{-|
The ⑤ Build shape for `<m3e-fab-menu-trigger>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FabMenuTrigger as FabMenuTrigger`.

@docs Builder, AttrCaps, SlotCaps, fabMenuTrigger
-}


import M3e.Element


{-| Opaque builder for `<m3e-fab-menu-trigger>`; see `.build` for the terminal. -}
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


{-| Seed a `Builder` for `<m3e-fab-menu-trigger>`. -}
fabMenuTrigger : Builder AttrCaps SlotCaps msg
fabMenuTrigger =
    Builder { for = Nothing, default = Nothing, phantomMsg_ = Nothing }