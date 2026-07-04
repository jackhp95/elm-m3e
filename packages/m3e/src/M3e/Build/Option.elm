module M3e.Build.Option exposing ( Builder, AttrCaps, SlotCaps, option )

{-|
The ⑤ Build shape for `<m3e-option>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Option as Option`.

@docs Builder, AttrCaps, SlotCaps, option
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-option>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
    , disabled : Maybe Bool
    , disableHighlight : Maybe Bool
    , highlightMode :
        Maybe (M3e.Value.Value { contains : M3e.Value.Supported
        , endsWith : M3e.Value.Supported
        , startsWith : M3e.Value.Supported
        })
    , selected : Maybe Bool
    , term : Maybe String
    , value : Maybe String
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-option>` with the required fields. -}
option :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg
option req_ =
    Builder
        { content = req_.content
        , disabled = Nothing
        , disableHighlight = Nothing
        , highlightMode = Nothing
        , selected = Nothing
        , term = Nothing
        , value = Nothing
        , phantomMsg_ = Nothing
        }