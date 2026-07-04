module M3e.Build.SearchView exposing ( Builder, AttrCaps, SlotCaps, searchView )

{-|
The ⑤ Build shape for `<m3e-search-view>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.SearchView as SearchView`.

@docs Builder, AttrCaps, SlotCaps, searchView
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-search-view>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { input : M3e.Element.Element {} msg
    , contained : Maybe Bool
    , mode :
        Maybe (M3e.Value.Value { auto : M3e.Value.Supported
        , docked : M3e.Value.Supported
        , fullscreen : M3e.Value.Supported
        })
    , open : Maybe Bool
    , clearLabel : Maybe String
    , closeLabel : Maybe String
    , hideSearchIcon : Maybe Bool
    , onQuery : Maybe (Json.Decode.Decoder msg)
    , onClear : Maybe (Json.Decode.Decoder msg)
    , onBeforetoggle : Maybe (Json.Decode.Decoder msg)
    , onToggle : Maybe (Json.Decode.Decoder msg)
    , searchIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , closeIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , clearIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , default : List (M3e.Element.Element {} msg)
    , openLeading :
        List (M3e.Element.Element { icon : M3e.Value.Supported
        , iconButton : M3e.Value.Supported
        } msg)
    , openTrailing :
        List (M3e.Element.Element { icon : M3e.Value.Supported
        , iconButton : M3e.Value.Supported
        } msg)
    , closedLeading :
        List (M3e.Element.Element { icon : M3e.Value.Supported
        , iconButton : M3e.Value.Supported
        } msg)
    , closedTrailing :
        List (M3e.Element.Element { icon : M3e.Value.Supported
        , iconButton : M3e.Value.Supported
        } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-search-view>` with the required fields. -}
searchView :
    { input : M3e.Element.Element {} msg } -> Builder AttrCaps SlotCaps msg
searchView req_ =
    Builder
        { input = req_.input
        , contained = Nothing
        , mode = Nothing
        , open = Nothing
        , clearLabel = Nothing
        , closeLabel = Nothing
        , hideSearchIcon = Nothing
        , onQuery = Nothing
        , onClear = Nothing
        , onBeforetoggle = Nothing
        , onToggle = Nothing
        , searchIcon = Nothing
        , closeIcon = Nothing
        , clearIcon = Nothing
        , default = []
        , openLeading = []
        , openTrailing = []
        , closedLeading = []
        , closedTrailing = []
        , phantomMsg_ = Nothing
        }