module M3e.Build.Theme exposing
    ( Builder, AttrCaps, SlotCaps, theme, color, contrast
    , density, scheme, strongFocus, variant, motion, onChange
    )

{-|
The ⑤ Build shape for `<m3e-theme>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Theme as Theme`.

@docs Builder, AttrCaps, SlotCaps, theme, color, contrast
@docs density, scheme, strongFocus, variant, motion, onChange
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-theme>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { color : M3e.Build.Internal.Available
    , contrast : M3e.Build.Internal.Available
    , density : M3e.Build.Internal.Available
    , scheme : M3e.Build.Internal.Available
    , strongFocus : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , motion : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


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


{-| The hex color from which to derive dynamic color palettes. (default: `"#6750A4"`) -}
color :
    String
    -> Builder { a | color : M3e.Build.Internal.Available } s msg
    -> Builder { a | color : M3e.Build.Internal.Used } s msg
color v_ (Builder f_) =
    Builder { f_ | color = Just v_ }


{-| The contrast level of the theme. (default: `"standard"`) -}
contrast :
    M3e.Value.Value { high : M3e.Value.Supported
    , medium : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> Builder { a | contrast : M3e.Build.Internal.Available } s msg
    -> Builder { a | contrast : M3e.Build.Internal.Used } s msg
contrast v_ (Builder f_) =
    Builder { f_ | contrast = Just v_ }


{-| The density scale (0, -1, -2). (default: `0`) -}
density :
    Float
    -> Builder { a | density : M3e.Build.Internal.Available } s msg
    -> Builder { a | density : M3e.Build.Internal.Used } s msg
density v_ (Builder f_) =
    Builder { f_ | density = Just v_ }


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


{-| Whether to enable strong focus indicators. (default: `false`) -}
strongFocus :
    Bool
    -> Builder { a | strongFocus : M3e.Build.Internal.Available } s msg
    -> Builder { a | strongFocus : M3e.Build.Internal.Used } s msg
strongFocus v_ (Builder f_) =
    Builder { f_ | strongFocus = Just v_ }


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


{-| The motion scheme. (default: `"standard"`) -}
motion :
    M3e.Value.Value { expressive : M3e.Value.Supported
    , standard : M3e.Value.Supported
    }
    -> Builder { a | motion : M3e.Build.Internal.Available } s msg
    -> Builder { a | motion : M3e.Build.Internal.Used } s msg
motion v_ (Builder f_) =
    Builder { f_ | motion = Just v_ }


{-| Dispatched when the theme changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }