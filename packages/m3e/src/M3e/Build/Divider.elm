module M3e.Build.Divider exposing ( Builder, AttrCaps, SlotCaps, divider )

{-|
The ⑤ Build shape for `<m3e-divider>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Divider as Divider`.

@docs Builder, AttrCaps, SlotCaps, divider
-}



{-| Opaque builder for `<m3e-divider>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { inset : Maybe Bool
    , insetStart : Maybe Bool
    , insetEnd : Maybe Bool
    , vertical : Maybe Bool
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-divider>`. -}
divider : Builder AttrCaps SlotCaps msg
divider =
    Builder
        { inset = Nothing
        , insetStart = Nothing
        , insetEnd = Nothing
        , vertical = Nothing
        , phantomMsg_ = Nothing
        }