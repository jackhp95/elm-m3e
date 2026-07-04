module M3e.Build.InputChipSet exposing ( Builder, AttrCaps, SlotCaps, inputChipSet )

{-|
The ⑤ Build shape for `<m3e-input-chip-set>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.InputChipSet as InputChipSet`.

@docs Builder, AttrCaps, SlotCaps, inputChipSet
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-input-chip-set>`; see `.build` for the terminal. -}
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
    , name : Maybe String
    , required : Maybe Bool
    , vertical : Maybe Bool
    , onChange : Maybe (Json.Decode.Decoder msg)
    , input : Maybe (M3e.Element.Element {} msg)
    , default :
        List (M3e.Element.Element { inputChip : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-input-chip-set>`. -}
inputChipSet : Builder AttrCaps SlotCaps msg
inputChipSet =
    Builder
        { disabled = Nothing
        , name = Nothing
        , required = Nothing
        , vertical = Nothing
        , onChange = Nothing
        , input = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }