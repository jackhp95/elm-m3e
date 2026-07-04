module M3e.Build.Switch exposing ( Builder, AttrCaps, SlotCaps, switch )

{-|
The ⑤ Build shape for `<m3e-switch>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Switch as Switch`.

@docs Builder, AttrCaps, SlotCaps, switch
-}


import Json.Decode
import M3e.Value


{-| Opaque builder for `<m3e-switch>`; see `.build` for the terminal. -}
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
    , icons :
        Maybe (M3e.Value.Value { both : M3e.Value.Supported
        , none : M3e.Value.Supported
        , selected : M3e.Value.Supported
        })
    , name : Maybe String
    , value : Maybe String
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onClick : Maybe (Json.Decode.Decoder msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-switch>`. -}
switch : Builder AttrCaps SlotCaps msg
switch =
    Builder
        { checked = Nothing
        , disabled = Nothing
        , icons = Nothing
        , name = Nothing
        , value = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , onChange = Nothing
        , onClick = Nothing
        , phantomMsg_ = Nothing
        }