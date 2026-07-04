module M3e.Build.FilterChipSet exposing ( Builder, AttrCaps, SlotCaps, filterChipSet )

{-|
The ⑤ Build shape for `<m3e-filter-chip-set>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FilterChipSet as FilterChipSet`.

@docs Builder, AttrCaps, SlotCaps, filterChipSet
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-filter-chip-set>`; see `.build` for the terminal. -}
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
    , vertical : Maybe Bool
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , default :
        List (M3e.Element.Element { filterChip : M3e.Value.Supported } msg)
    }


{-| Seed a `Builder` for `<m3e-filter-chip-set>`. -}
filterChipSet : Builder AttrCaps SlotCaps msg
filterChipSet =
    Builder
        { disabled = Nothing
        , hideSelectionIndicator = Nothing
        , multi = Nothing
        , name = Nothing
        , vertical = Nothing
        , onChange = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , default = []
        }