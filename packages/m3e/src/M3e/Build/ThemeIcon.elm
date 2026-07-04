module M3e.Build.ThemeIcon exposing
    ( Builder, AttrCaps, SlotCaps, themeIcon, color, scheme
    , variant
    )

{-|
The ⑤ Build shape for `<m3e-theme-icon>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ThemeIcon as ThemeIcon`.

@docs Builder, AttrCaps, SlotCaps, themeIcon, color, scheme
@docs variant
-}


import M3e.Build.Internal
import M3e.Value


{-| Opaque builder for `<m3e-theme-icon>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { color : M3e.Build.Internal.Available
    , scheme : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
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
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-theme-icon>`. -}
themeIcon : Builder AttrCaps SlotCaps msg
themeIcon =
    Builder
        { color = Nothing
        , scheme = Nothing
        , variant = Nothing
        , phantomMsg_ = Nothing
        }


{-| The hex color of the theme to preview (default: `"#6750A4"`) -}
color :
    String
    -> Builder { a | color : M3e.Build.Internal.Available } s msg
    -> Builder { a | color : M3e.Build.Internal.Used } s msg
color v_ (Builder f_) =
    Builder { f_ | color = Just v_ }


{-| The color scheme of the theme. (default: `"auto"`) -}
scheme :
    M3e.Value.Value { auto : M3e.Value.Supported
    , dark : M3e.Value.Supported
    , light : M3e.Value.Supported
    }
    -> Builder { a | scheme : M3e.Build.Internal.Available } s msg
    -> Builder { a | scheme : M3e.Build.Internal.Used } s msg
scheme v_ (Builder f_) =
    Builder { f_ | scheme = Just v_ }


{-| The color variant of the theme. (default: `"neutral"`) -}
variant :
    M3e.Value.Value { content : M3e.Value.Supported
    , expressive : M3e.Value.Supported
    , fidelity : M3e.Value.Supported
    , fruitSalad : M3e.Value.Supported
    , monochrome : M3e.Value.Supported
    , neutral : M3e.Value.Supported
    , rainbow : M3e.Value.Supported
    , tonalSpot : M3e.Value.Supported
    , vibrant : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }