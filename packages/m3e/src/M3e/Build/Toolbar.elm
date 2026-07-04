module M3e.Build.Toolbar exposing ( Builder, AttrCaps, SlotCaps, toolbar )

{-|
The ⑤ Build shape for `<m3e-toolbar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Toolbar as Toolbar`.

@docs Builder, AttrCaps, SlotCaps, toolbar
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-toolbar>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { elevated : Maybe Bool
    , shape :
        Maybe (M3e.Value.Value { rounded : M3e.Value.Supported
        , square : M3e.Value.Supported
        })
    , variant :
        Maybe (M3e.Value.Value { standard : M3e.Value.Supported
        , vibrant : M3e.Value.Supported
        })
    , vertical : Maybe Bool
    , default : List (M3e.Element.Element any_ msg)
    }


{-| Seed a `Builder` for `<m3e-toolbar>`. -}
toolbar : Builder AttrCaps SlotCaps msg
toolbar =
    Builder
        { elevated = Nothing
        , shape = Nothing
        , variant = Nothing
        , vertical = Nothing
        , default = []
        }