module M3e.Build.MultiYearView exposing ( Builder, AttrCaps, SlotCaps, multiYearView )

{-|
The ⑤ Build shape for `<m3e-multi-year-view>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.MultiYearView as MultiYearView`.

@docs Builder, AttrCaps, SlotCaps, multiYearView
-}


import Json.Decode


{-| Opaque builder for `<m3e-multi-year-view>`; see `.build` for the terminal. -}
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
    }


{-| Seed a `Builder` for `<m3e-multi-year-view>`. -}
multiYearView : Builder AttrCaps SlotCaps msg
multiYearView =
    Builder
        { active = Nothing
        , today = Nothing
        , date = Nothing
        , activeDate = Nothing
        , minDate = Nothing
        , maxDate = Nothing
        , onChange = Nothing
        , onActiveChange = Nothing
        }