module M3e.Build.SearchBar exposing
    ( Builder, AttrCaps, SlotCaps, searchBar, clearable, clearLabel
    , onClear, clearIcon
    )

{-|
The ⑤ Build shape for `<m3e-search-bar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SearchBar as SearchBar`.

@docs Builder, AttrCaps, SlotCaps, searchBar, clearable, clearLabel
@docs onClear, clearIcon
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-search-bar>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { clearable : M3e.Build.Internal.Available
    , clearLabel : M3e.Build.Internal.Available
    , onClear : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { clearIcon : M3e.Build.Internal.Available }


type alias Fields msg =
    { input : M3e.Element.Element {} msg
    , clearable : Maybe Bool
    , clearLabel : Maybe String
    , onClear : Maybe (Json.Decode.Decoder msg)
    , clearIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , leading :
        List (M3e.Element.Element { icon : M3e.Value.Supported
        , iconButton : M3e.Value.Supported
        } msg)
    , trailing :
        List (M3e.Element.Element { icon : M3e.Value.Supported
        , iconButton : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-search-bar>` with the required fields. -}
searchBar :
    { input : M3e.Element.Element {} msg } -> Builder AttrCaps SlotCaps msg
searchBar req_ =
    Builder
        { input = req_.input
        , clearable = Nothing
        , clearLabel = Nothing
        , onClear = Nothing
        , clearIcon = Nothing
        , leading = []
        , trailing = []
        , phantomMsg_ = Nothing
        }


{-| Whether the bar presents a button used to clear the search term. (default: `false`) -}
clearable :
    Bool
    -> Builder { a | clearable : M3e.Build.Internal.Available } s msg
    -> Builder { a | clearable : M3e.Build.Internal.Used } s msg
clearable v_ (Builder f_) =
    Builder { f_ | clearable = Just v_ }


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`) -}
clearLabel :
    String
    -> Builder { a | clearLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | clearLabel : M3e.Build.Internal.Used } s msg
clearLabel v_ (Builder f_) =
    Builder { f_ | clearLabel = Just v_ }


{-| Dispatched when the search term is cleared. -}
onClear :
    Json.Decode.Decoder msg
    -> Builder { a | onClear : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClear : M3e.Build.Internal.Used } s msg
onClear v_ (Builder f_) =
    Builder { f_ | onClear = Just v_ }


{-| Set the `clear-icon` slot. Consumes the `clearIcon` slot capability. -}
clearIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | clearIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | clearIcon : M3e.Build.Internal.Used } msg
clearIcon v_ (Builder f_) =
    Builder { f_ | clearIcon = Just v_ }