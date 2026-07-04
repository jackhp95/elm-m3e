module M3e.Build.Checkbox exposing ( Builder, AttrCaps, SlotCaps, checkbox )

{-|
The ⑤ Build shape for `<m3e-checkbox>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Checkbox as Checkbox`.

@docs Builder, AttrCaps, SlotCaps, checkbox
-}


import Json.Decode


{-| Opaque builder for `<m3e-checkbox>`; see `.build` for the terminal. -}
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
    , indeterminate : Maybe Bool
    , name : Maybe String
    , required : Maybe Bool
    , value : Maybe String
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onInvalid : Maybe (Json.Decode.Decoder msg)
    , onClick : Maybe (Json.Decode.Decoder msg)
    }


{-| Seed a `Builder` for `<m3e-checkbox>`. -}
checkbox : Builder AttrCaps SlotCaps msg
checkbox =
    Builder
        { checked = Nothing
        , disabled = Nothing
        , indeterminate = Nothing
        , name = Nothing
        , required = Nothing
        , value = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , onChange = Nothing
        , onInvalid = Nothing
        , onClick = Nothing
        }