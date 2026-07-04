module M3e.Build.ExpansionHeader exposing ( Builder, AttrCaps, SlotCaps, expansionHeader )

{-|
The ⑤ Build shape for `<m3e-expansion-header>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.ExpansionHeader as ExpansionHeader`.

@docs Builder, AttrCaps, SlotCaps, expansionHeader
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-expansion-header>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { hideToggle : Maybe Bool
    , toggleDirection :
        Maybe (M3e.Value.Value { horizontal : M3e.Value.Supported
        , vertical : M3e.Value.Supported
        })
    , togglePosition :
        Maybe (M3e.Value.Value { after : M3e.Value.Supported
        , before : M3e.Value.Supported
        })
    , disabled : Maybe Bool
    , onClick : Maybe (Json.Decode.Decoder msg)
    , default : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , toggleIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-expansion-header>`. -}
expansionHeader : Builder AttrCaps SlotCaps msg
expansionHeader =
    Builder
        { hideToggle = Nothing
        , toggleDirection = Nothing
        , togglePosition = Nothing
        , disabled = Nothing
        , onClick = Nothing
        , default = Nothing
        , toggleIcon = Nothing
        , phantomMsg_ = Nothing
        }