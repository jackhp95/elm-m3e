module M3e.Build.Radio exposing ( Builder, AttrCaps, SlotCaps, radio )

{-|
The ⑤ Build shape for `<m3e-radio>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Radio as Radio`.

@docs Builder, AttrCaps, SlotCaps, radio
-}


import Json.Decode


{-| Opaque builder for `<m3e-radio>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { checked : Maybe Bool
    , disabled : Maybe Bool
    , name : Maybe String
    , required : Maybe String
    , value : Maybe String
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onClick : Maybe (Json.Decode.Decoder msg)
    }


{-| Seed a `Builder` for `<m3e-radio>`. -}
radio : Builder AttrCaps SlotCaps msg
radio =
    Builder
        { checked = Nothing
        , disabled = Nothing
        , name = Nothing
        , required = Nothing
        , value = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , onChange = Nothing
        , onClick = Nothing
        }