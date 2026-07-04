module M3e.Build.MonthView exposing ( Builder, AttrCaps, SlotCaps, monthView )

{-|
The ⑤ Build shape for `<m3e-month-view>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MonthView as MonthView`.

@docs Builder, AttrCaps, SlotCaps, monthView
-}


import Json.Decode


{-| Opaque builder for `<m3e-month-view>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { rangeStart : Maybe String
    , rangeEnd : Maybe String
    , active : Maybe Bool
    , today : Maybe String
    , date : Maybe String
    , activeDate : Maybe String
    , minDate : Maybe String
    , maxDate : Maybe String
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onActiveChange : Maybe (Json.Decode.Decoder msg)
    }


{-| Seed a `Builder` for `<m3e-month-view>`. -}
monthView : Builder AttrCaps SlotCaps msg
monthView =
    Builder
        { rangeStart = Nothing
        , rangeEnd = Nothing
        , active = Nothing
        , today = Nothing
        , date = Nothing
        , activeDate = Nothing
        , minDate = Nothing
        , maxDate = Nothing
        , onChange = Nothing
        , onActiveChange = Nothing
        }