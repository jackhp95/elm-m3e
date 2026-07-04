module M3e.Build.Autocomplete exposing
    ( Builder, AttrCaps, SlotCaps, autocomplete, autoActivate, caseSensitive
    , filter, hideSelectionIndicator, hideLoading, hideNoData, loading, loadingLabel, noDataLabel
    , panelClass, required, for, onChange, onQuery, onToggle, loadingSlot
    , noData
    )

{-|
The ⑤ Build shape for `<m3e-autocomplete>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Autocomplete as Autocomplete`.

@docs Builder, AttrCaps, SlotCaps, autocomplete, autoActivate, caseSensitive
@docs filter, hideSelectionIndicator, hideLoading, hideNoData, loading, loadingLabel
@docs noDataLabel, panelClass, required, for, onChange, onQuery
@docs onToggle, loadingSlot, noData
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-autocomplete>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { autoActivate : M3e.Build.Internal.Available
    , caseSensitive : M3e.Build.Internal.Available
    , filter : M3e.Build.Internal.Available
    , hideSelectionIndicator : M3e.Build.Internal.Available
    , hideLoading : M3e.Build.Internal.Available
    , hideNoData : M3e.Build.Internal.Available
    , loading : M3e.Build.Internal.Available
    , loadingLabel : M3e.Build.Internal.Available
    , noDataLabel : M3e.Build.Internal.Available
    , panelClass : M3e.Build.Internal.Available
    , required : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onQuery : M3e.Build.Internal.Available
    , onToggle : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { loadingSlot : M3e.Build.Internal.Available
    , noData : M3e.Build.Internal.Available
    }


type alias Fields msg =
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
    , loadingSlot : Maybe (M3e.Element.Element {} msg)
    , noData : Maybe (M3e.Element.Element {} msg)
    , default :
        List (M3e.Element.Element { option : M3e.Value.Supported
        , optgroup : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
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
        , phantomMsg_ = Nothing
        }


{-| Whether the first option should be automatically activated. (default: `false`) -}
autoActivate :
    Bool
    -> Builder { a | autoActivate : M3e.Build.Internal.Available } s msg
    -> Builder { a | autoActivate : M3e.Build.Internal.Used } s msg
autoActivate v_ (Builder f_) =
    Builder { f_ | autoActivate = Just v_ }


{-| Whether filtering is case sensitive. (default: `false`) -}
caseSensitive :
    Bool
    -> Builder { a | caseSensitive : M3e.Build.Internal.Available } s msg
    -> Builder { a | caseSensitive : M3e.Build.Internal.Used } s msg
caseSensitive v_ (Builder f_) =
    Builder { f_ | caseSensitive = Just v_ }


{-| Mode in which to filter options. (default: `"contains"`) -}
filter :
    M3e.Value.Value { contains : M3e.Value.Supported
    , endsWith : M3e.Value.Supported
    , none : M3e.Value.Supported
    , startsWith : M3e.Value.Supported
    }
    -> Builder { a | filter : M3e.Build.Internal.Available } s msg
    -> Builder { a | filter : M3e.Build.Internal.Used } s msg
filter v_ (Builder f_) =
    Builder { f_ | filter = Just v_ }


{-| Whether to hide the selection indicator. (default: `false`) -}
hideSelectionIndicator :
    Bool
    -> Builder { a
        | hideSelectionIndicator : M3e.Build.Internal.Available
    } s msg
    -> Builder { a | hideSelectionIndicator : M3e.Build.Internal.Used } s msg
hideSelectionIndicator v_ (Builder f_) =
    Builder { f_ | hideSelectionIndicator = Just v_ }


{-| Whether to hide the menu when loading options. (default: `false`) -}
hideLoading :
    Bool
    -> Builder { a | hideLoading : M3e.Build.Internal.Available } s msg
    -> Builder { a | hideLoading : M3e.Build.Internal.Used } s msg
hideLoading v_ (Builder f_) =
    Builder { f_ | hideLoading = Just v_ }


{-| Whether to hide the menu when there are no options to show. (default: `false`) -}
hideNoData :
    Bool
    -> Builder { a | hideNoData : M3e.Build.Internal.Available } s msg
    -> Builder { a | hideNoData : M3e.Build.Internal.Used } s msg
hideNoData v_ (Builder f_) =
    Builder { f_ | hideNoData = Just v_ }


{-| Whether options are being loaded. (default: `false`) -}
loading :
    Bool
    -> Builder { a | loading : M3e.Build.Internal.Available } s msg
    -> Builder { a | loading : M3e.Build.Internal.Used } s msg
loading v_ (Builder f_) =
    Builder { f_ | loading = Just v_ }


{-| The text announced and presented when loading options. (default: `"Loading..."`) -}
loadingLabel :
    String
    -> Builder { a | loadingLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | loadingLabel : M3e.Build.Internal.Used } s msg
loadingLabel v_ (Builder f_) =
    Builder { f_ | loadingLabel = Just v_ }


{-| The text announced and presented when no options are available for the current term. (default: `"No options"`) -}
noDataLabel :
    String
    -> Builder { a | noDataLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | noDataLabel : M3e.Build.Internal.Used } s msg
noDataLabel v_ (Builder f_) =
    Builder { f_ | noDataLabel = Just v_ }


{-| Class or list of classes to be applied to the autocomplete's overlay panel. (default: `""`) -}
panelClass :
    String
    -> Builder { a | panelClass : M3e.Build.Internal.Available } s msg
    -> Builder { a | panelClass : M3e.Build.Internal.Used } s msg
panelClass v_ (Builder f_) =
    Builder { f_ | panelClass = Just v_ }


{-| Whether the user is required to make a selection when interacting with the autocomplete. (default: `false`) -}
required :
    Bool
    -> Builder { a | required : M3e.Build.Internal.Available } s msg
    -> Builder { a | required : M3e.Build.Internal.Used } s msg
required v_ (Builder f_) =
    Builder { f_ | required = Just v_ }


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg
    -> Builder { a | for : M3e.Build.Internal.Used } s msg
for v_ (Builder f_) =
    Builder { f_ | for = Just v_ }


{-| Dispatched when the committed value changes due to selecting an option or clearing the input. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }


{-| Dispatched when the input is focused or when the user modifies its value. -}
onQuery :
    Json.Decode.Decoder msg
    -> Builder { a | onQuery : M3e.Build.Internal.Available } s msg
    -> Builder { a | onQuery : M3e.Build.Internal.Used } s msg
onQuery v_ (Builder f_) =
    Builder { f_ | onQuery = Just v_ }


{-| Dispatched when the options menu opens or closes. -}
onToggle :
    Json.Decode.Decoder msg
    -> Builder { a | onToggle : M3e.Build.Internal.Available } s msg
    -> Builder { a | onToggle : M3e.Build.Internal.Used } s msg
onToggle v_ (Builder f_) =
    Builder { f_ | onToggle = Just v_ }


{-| Set the `loading` slot. Consumes the `loadingSlot` slot capability. -}
loadingSlot :
    M3e.Element.Element {} msg
    -> Builder a { s | loadingSlot : M3e.Build.Internal.Available } msg
    -> Builder a { s | loadingSlot : M3e.Build.Internal.Used } msg
loadingSlot v_ (Builder f_) =
    Builder { f_ | loadingSlot = Just v_ }


{-| Set the `no-data` slot. Consumes the `noData` slot capability. -}
noData :
    M3e.Element.Element {} msg
    -> Builder a { s | noData : M3e.Build.Internal.Available } msg
    -> Builder a { s | noData : M3e.Build.Internal.Used } msg
noData v_ (Builder f_) =
    Builder { f_ | noData = Just v_ }