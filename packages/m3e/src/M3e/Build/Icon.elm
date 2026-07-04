module M3e.Build.Icon exposing ( Builder, AttrCaps, SlotCaps, icon )

{-|
The ⑤ Build shape for `<m3e-icon>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Icon as Icon`.

@docs Builder, AttrCaps, SlotCaps, icon
-}


import M3e.Value


{-| Opaque builder for `<m3e-icon>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { filled : Maybe Bool
    , grade :
        Maybe (M3e.Value.Value { high : M3e.Value.Supported
        , low : M3e.Value.Supported
        , medium : M3e.Value.Supported
        })
    , opticalSize : Maybe Float
    , name : Maybe String
    , variant :
        Maybe (M3e.Value.Value { outlined : M3e.Value.Supported
        , rounded : M3e.Value.Supported
        , sharp : M3e.Value.Supported
        })
    , weight : Maybe String
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-icon>`. -}
icon : Builder AttrCaps SlotCaps msg
icon =
    Builder
        { filled = Nothing
        , grade = Nothing
        , opticalSize = Nothing
        , name = Nothing
        , variant = Nothing
        , weight = Nothing
        , phantomMsg_ = Nothing
        }