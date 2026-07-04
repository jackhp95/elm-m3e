module M3e.Build.Select exposing ( Builder, AttrCaps, SlotCaps, select )

{-|
The ⑤ Build shape for `<m3e-select>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Select as Select`.

@docs Builder, AttrCaps, SlotCaps, select
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-select>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { disabled : Maybe Bool
    , hideSelectionIndicator : Maybe Bool
    , multi : Maybe Bool
    , name : Maybe String
    , panelClass : Maybe String
    , required : Maybe Bool
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onToggle : Maybe (Json.Decode.Decoder msg)
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , arrow : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , value : Maybe (M3e.Element.Element {} msg)
    , default : List (M3e.Element.Element { option : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-select>`. -}
select : Builder AttrCaps SlotCaps msg
select =
    Builder
        { disabled = Nothing
        , hideSelectionIndicator = Nothing
        , multi = Nothing
        , name = Nothing
        , panelClass = Nothing
        , required = Nothing
        , onChange = Nothing
        , onToggle = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , arrow = Nothing
        , value = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }