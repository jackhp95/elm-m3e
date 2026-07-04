module M3e.Build.YearView exposing ( Builder, AttrCaps, SlotCaps, yearView )

{-|
The ⑤ Build shape for `<m3e-year-view>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.YearView as YearView`.

@docs Builder, AttrCaps, SlotCaps, yearView
-}


import Json.Decode


{-| Opaque builder for `<m3e-year-view>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { active : Maybe Bool
    , today : Maybe String
    , date : Maybe String
    , activeDate : Maybe String
    , minDate : Maybe String
    , maxDate : Maybe String
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onActiveChange : Maybe (Json.Decode.Decoder msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-year-view>`. -}
yearView : Builder AttrCaps SlotCaps msg
yearView =
    Builder
        { active = Nothing
        , today = Nothing
        , date = Nothing
        , activeDate = Nothing
        , minDate = Nothing
        , maxDate = Nothing
        , onChange = Nothing
        , onActiveChange = Nothing
        , phantomMsg_ = Nothing
        }