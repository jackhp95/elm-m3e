module M3e.Build.Step exposing ( Builder, AttrCaps, SlotCaps, step )

{-|
The ⑤ Build shape for `<m3e-step>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Step as Step`.

@docs Builder, AttrCaps, SlotCaps, step
-}


import Json.Decode
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-step>`; see `.build` for the terminal. -}
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
    , completed : Maybe Bool
    , disabled : Maybe Bool
    , editable : Maybe Bool
    , for : Maybe String
    , optional : Maybe Bool
    , selected : Maybe Bool
    , invalid : Maybe Bool
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onClick : Maybe (Json.Decode.Decoder msg)
    , icon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , doneIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , editIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , errorIcon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , hint : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , error : Maybe (M3e.Element.Element { text : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-step>` with the required fields. -}
step :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg
step req_ =
    Builder
        { content = req_.content
        , completed = Nothing
        , disabled = Nothing
        , editable = Nothing
        , for = Nothing
        , optional = Nothing
        , selected = Nothing
        , invalid = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , onChange = Nothing
        , onClick = Nothing
        , icon = Nothing
        , doneIcon = Nothing
        , editIcon = Nothing
        , errorIcon = Nothing
        , hint = Nothing
        , error = Nothing
        , phantomMsg_ = Nothing
        }