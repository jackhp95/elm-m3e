module M3e.Build.Ripple exposing ( Builder, AttrCaps, SlotCaps, ripple )

{-|
The ⑤ Build shape for `<m3e-ripple>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Ripple as Ripple`.

@docs Builder, AttrCaps, SlotCaps, ripple
-}



{-| Opaque builder for `<m3e-ripple>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { centered : Maybe Bool
    , disabled : Maybe Bool
    , for : Maybe String
    , radius : Maybe Float
    , unbounded : Maybe Bool
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-ripple>`. -}
ripple : Builder AttrCaps SlotCaps msg
ripple =
    Builder
        { centered = Nothing
        , disabled = Nothing
        , for = Nothing
        , radius = Nothing
        , unbounded = Nothing
        , phantomMsg_ = Nothing
        }