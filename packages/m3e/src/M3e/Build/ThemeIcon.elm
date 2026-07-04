module M3e.Build.ThemeIcon exposing ( Builder, AttrCaps, SlotCaps, themeIcon )

{-|
The ⑤ Build shape for `<m3e-theme-icon>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ThemeIcon as ThemeIcon`.

@docs Builder, AttrCaps, SlotCaps, themeIcon
-}


import M3e.Value


{-| Opaque builder for `<m3e-theme-icon>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields =
    { color : Maybe String
    , scheme :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , dark : M3e.Value.Supported
        , light : M3e.Value.Supported
        })
    , variant :
        Maybe (M3e.Value.Value { content : M3e.Value.Supported
        , expressive : M3e.Value.Supported
        , fidelity : M3e.Value.Supported
        , fruitSalad : M3e.Value.Supported
        , monochrome : M3e.Value.Supported
        , neutral : M3e.Value.Supported
        , rainbow : M3e.Value.Supported
        , tonalSpot : M3e.Value.Supported
        , vibrant : M3e.Value.Supported
        })
    }


{-| Seed a `Builder` for `<m3e-theme-icon>`. -}
themeIcon : Builder AttrCaps SlotCaps msg
themeIcon =
    Builder { color = Nothing, scheme = Nothing, variant = Nothing }