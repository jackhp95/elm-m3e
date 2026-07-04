module M3e.Build.Datepicker exposing ( Builder, AttrCaps, SlotCaps, datepicker )

{-|
The ⑤ Build shape for `<m3e-datepicker>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Datepicker as Datepicker`.

@docs Builder, AttrCaps, SlotCaps, datepicker
-}


import Json.Decode
import M3e.Value


{-| Opaque builder for `<m3e-datepicker>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { variant :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , docked : M3e.Value.Supported
        , modal : M3e.Value.Supported
        })
    , clearable : Maybe Bool
    , date : Maybe String
    , maxDate : Maybe String
    , minDate : Maybe String
    , range : Maybe Bool
    , rangeEnd : Maybe String
    , rangeStart : Maybe String
    , startAt : Maybe String
    , startView :
        Maybe (M3e.Value.Value { month : M3e.Value.Supported
        , multiYear : M3e.Value.Supported
        , year : M3e.Value.Supported
        })
    , previousMonthLabel : Maybe String
    , nextMonthLabel : Maybe String
    , previousYearLabel : Maybe String
    , nextYearLabel : Maybe String
    , previousMultiYearLabel : Maybe String
    , nextMultiYearLabel : Maybe String
    , clearLabel : Maybe String
    , confirmLabel : Maybe String
    , dismissLabel : Maybe String
    , label : Maybe String
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onBeforetoggle : Maybe (Json.Decode.Decoder msg)
    , onToggle : Maybe (Json.Decode.Decoder msg)
    }


{-| Seed a `Builder` for `<m3e-datepicker>`. -}
datepicker : Builder AttrCaps SlotCaps msg
datepicker =
    Builder
        { variant = Nothing
        , clearable = Nothing
        , date = Nothing
        , maxDate = Nothing
        , minDate = Nothing
        , range = Nothing
        , rangeEnd = Nothing
        , rangeStart = Nothing
        , startAt = Nothing
        , startView = Nothing
        , previousMonthLabel = Nothing
        , nextMonthLabel = Nothing
        , previousYearLabel = Nothing
        , nextYearLabel = Nothing
        , previousMultiYearLabel = Nothing
        , nextMultiYearLabel = Nothing
        , clearLabel = Nothing
        , confirmLabel = Nothing
        , dismissLabel = Nothing
        , label = Nothing
        , onChange = Nothing
        , onBeforetoggle = Nothing
        , onToggle = Nothing
        }