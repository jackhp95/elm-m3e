module M3e.Build.Autocomplete exposing ( Builder, AttrCaps, SlotCaps, autocomplete )

{-|
The ⑤ Build shape for `<m3e-autocomplete>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Autocomplete as Autocomplete`.

@docs Builder, AttrCaps, SlotCaps, autocomplete
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-autocomplete>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { autoActivate : Maybe Bool
    , caseSensitive : Maybe Bool
    , filter :
        Maybe (M3e.Value.Value { contains : M3e.Value.Supported
        , endsWith : M3e.Value.Supported
        , none : M3e.Value.Supported
        , startsWith : M3e.Value.Supported
        })
    , hideSelectionIndicator : Maybe Bool
    , hideLoading : Maybe Bool
    , hideNoData : Maybe Bool
    , loading : Maybe Bool
    , loadingLabel : Maybe String
    , noDataLabel : Maybe String
    , panelClass : Maybe String
    , required : Maybe Bool
    , for : Maybe String
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onQuery : Maybe (Json.Decode.Decoder msg)
    , onToggle : Maybe (Json.Decode.Decoder msg)
    , loadingSlot : Maybe (M3e.Element.Element any_ msg)
    , noData : Maybe (M3e.Element.Element any_ msg)
    , default :
        List (M3e.Element.Element { option : M3e.Value.Supported
        , optgroup : M3e.Value.Supported
        } msg)
    }


{-| Seed a `Builder` for `<m3e-autocomplete>`. -}
autocomplete : Builder AttrCaps SlotCaps msg
autocomplete =
    Builder
        { autoActivate = Nothing
        , caseSensitive = Nothing
        , filter = Nothing
        , hideSelectionIndicator = Nothing
        , hideLoading = Nothing
        , hideNoData = Nothing
        , loading = Nothing
        , loadingLabel = Nothing
        , noDataLabel = Nothing
        , panelClass = Nothing
        , required = Nothing
        , for = Nothing
        , onChange = Nothing
        , onQuery = Nothing
        , onToggle = Nothing
        , loadingSlot = Nothing
        , noData = Nothing
        , default = []
        }