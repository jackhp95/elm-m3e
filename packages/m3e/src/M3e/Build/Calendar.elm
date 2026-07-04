module M3e.Build.Calendar exposing ( Builder, AttrCaps, SlotCaps, calendar )

{-|
The ⑤ Build shape for `<m3e-calendar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Calendar as Calendar`.

@docs Builder, AttrCaps, SlotCaps, calendar
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-calendar>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { date : Maybe String
    , maxDate : Maybe String
    , minDate : Maybe String
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
    , onChange : Maybe (Json.Decode.Decoder msg)
    , header : Maybe (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-calendar>`. -}
calendar : Builder AttrCaps SlotCaps msg
calendar =
    Builder
        { date = Nothing
        , maxDate = Nothing
        , minDate = Nothing
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
        , onChange = Nothing
        , header = Nothing
        , phantomMsg_ = Nothing
        }