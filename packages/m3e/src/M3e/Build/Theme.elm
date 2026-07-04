module M3e.Build.Theme exposing ( Builder, AttrCaps, SlotCaps, theme )

{-|
The ⑤ Build shape for `<m3e-theme>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Theme as Theme`.

@docs Builder, AttrCaps, SlotCaps, theme
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-theme>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { color : Maybe String
    , contrast :
        Maybe (M3e.Value.Value { high : M3e.Value.Supported
        , medium : M3e.Value.Supported
        , standard : M3e.Value.Supported
        })
    , density : Maybe Float
    , scheme :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , dark : M3e.Value.Supported
        , light : M3e.Value.Supported
        })
    , strongFocus : Maybe Bool
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
    , motion :
        Maybe (M3e.Value.Value { expressive : M3e.Value.Supported
        , standard : M3e.Value.Supported
        })
    , onChange : Maybe (Json.Decode.Decoder msg)
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-theme>`. -}
theme : Builder AttrCaps SlotCaps msg
theme =
    Builder
        { color = Nothing
        , contrast = Nothing
        , density = Nothing
        , scheme = Nothing
        , strongFocus = Nothing
        , variant = Nothing
        , motion = Nothing
        , onChange = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }