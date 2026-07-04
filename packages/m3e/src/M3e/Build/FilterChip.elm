module M3e.Build.FilterChip exposing ( Builder, AttrCaps, SlotCaps, filterChip )

{-|
The ⑤ Build shape for `<m3e-filter-chip>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FilterChip as FilterChip`.

@docs Builder, AttrCaps, SlotCaps, filterChip
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-filter-chip>`; see `.build` for the terminal. -}
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
    , selected : Maybe Bool
    , value : Maybe String
    , variant :
        Maybe (M3e.Value.Value { elevated : M3e.Value.Supported
        , outlined : M3e.Value.Supported
        })
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onClick : Maybe (Json.Decode.Decoder msg)
    , icon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , trailingIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    }


{-| Seed a `Builder` for `<m3e-filter-chip>` with the required fields. -}
filterChip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg
filterChip req_ =
    Builder
        { content = req_.content
        , disabled = Nothing
        , disabledInteractive = Nothing
        , selected = Nothing
        , value = Nothing
        , variant = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , onChange = Nothing
        , onClick = Nothing
        , icon = Nothing
        , trailingIcon = Nothing
        }