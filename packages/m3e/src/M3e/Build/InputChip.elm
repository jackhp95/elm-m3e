module M3e.Build.InputChip exposing ( Builder, AttrCaps, SlotCaps, inputChip )

{-|
The ⑤ Build shape for `<m3e-input-chip>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.InputChip as InputChip`.

@docs Builder, AttrCaps, SlotCaps, inputChip
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-input-chip>`; see `.build` for the terminal. -}
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
    , disabledInteractive : Maybe Bool
    , removable : Maybe Bool
    , removeLabel : Maybe String
    , value : Maybe String
    , variant :
        Maybe (M3e.Value.Value { elevated : M3e.Value.Supported
        , outlined : M3e.Value.Supported
        })
    , onRemove : Maybe (Json.Decode.Decoder msg)
    , onClick : Maybe (Json.Decode.Decoder msg)
    , avatar : Maybe (M3e.Element.Element { avatar : M3e.Value.Supported } msg)
    , icon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , removeIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-input-chip>` with the required fields. -}
inputChip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg
inputChip req_ =
    Builder
        { content = req_.content
        , disabled = Nothing
        , disabledInteractive = Nothing
        , removable = Nothing
        , removeLabel = Nothing
        , value = Nothing
        , variant = Nothing
        , onRemove = Nothing
        , onClick = Nothing
        , avatar = Nothing
        , icon = Nothing
        , removeIcon = Nothing
        , phantomMsg_ = Nothing
        }