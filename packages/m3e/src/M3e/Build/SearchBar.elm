module M3e.Build.SearchBar exposing ( Builder, AttrCaps, SlotCaps, searchBar )

{-|
The ⑤ Build shape for `<m3e-search-bar>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SearchBar as SearchBar`.

@docs Builder, AttrCaps, SlotCaps, searchBar
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-search-bar>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg any_ =
    { input : M3e.Element.Element any_ msg
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
    }


{-| Seed a `Builder` for `<m3e-search-bar>` with the required fields. -}
searchBar :
    { input : M3e.Element.Element any msg } -> Builder AttrCaps SlotCaps msg
searchBar req_ =
    Builder
        { input = req_.input
        , clearable = Nothing
        , clearLabel = Nothing
        , onClear = Nothing
        , clearIcon = Nothing
        , leading = []
        , trailing = []
        }