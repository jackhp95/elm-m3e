module M3e.Build.Slide exposing ( Builder, AttrCaps, SlotCaps, slide )

{-|
The ⑤ Build shape for `<m3e-slide>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Slide as Slide`.

@docs Builder, AttrCaps, SlotCaps, slide
-}


import M3e.Element


{-| Opaque builder for `<m3e-slide>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { selectedIndex : Maybe Float
    , default : List (M3e.Element.Element any_ msg)
    }


{-| Seed a `Builder` for `<m3e-slide>`. -}
slide : Builder AttrCaps SlotCaps msg
slide =
    Builder { selectedIndex = Nothing, default = [] }