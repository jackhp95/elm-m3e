module M3e.Build.RadioGroup exposing
    ( Builder, AttrCaps, SlotCaps, radioGroup, ariaInvalid, disabled
    , name, required, onBeforeinput, onInput, onChange
    )

{-|
The ⑤ Build shape for `<m3e-radio-group>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.RadioGroup as RadioGroup`.

@docs Builder, AttrCaps, SlotCaps, radioGroup, ariaInvalid, disabled
@docs name, required, onBeforeinput, onInput, onChange
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element


{-| Opaque builder for `<m3e-radio-group>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { ariaInvalid : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , required : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { ariaInvalid : Maybe String
    , disabled : Maybe Bool
    , name : Maybe String
    , required : Maybe Bool
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , onChange : Maybe (Json.Decode.Decoder msg)
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-radio-group>`. -}
radioGroup : Builder AttrCaps SlotCaps msg
radioGroup =
    Builder
        { ariaInvalid = Nothing
        , disabled = Nothing
        , name = Nothing
        , required = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , onChange = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


{-| Set the `aria-invalid` attribute. -}
ariaInvalid :
    String
    -> Builder { a | ariaInvalid : M3e.Build.Internal.Available } s msg
    -> Builder { a | ariaInvalid : M3e.Build.Internal.Used } s msg
ariaInvalid v_ (Builder f_) =
    Builder { f_ | ariaInvalid = Just v_ }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| The name that identifies the element when submitting the associated form. -}
name :
    String
    -> Builder { a | name : M3e.Build.Internal.Available } s msg
    -> Builder { a | name : M3e.Build.Internal.Used } s msg
name v_ (Builder f_) =
    Builder { f_ | name = Just v_ }


{-| Whether the element is required. (default: `false`) -}
required :
    Bool
    -> Builder { a | required : M3e.Build.Internal.Available } s msg
    -> Builder { a | required : M3e.Build.Internal.Used } s msg
required v_ (Builder f_) =
    Builder { f_ | required = Just v_ }


{-| Dispatched before the checked state of a radio button changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg
onBeforeinput v_ (Builder f_) =
    Builder { f_ | onBeforeinput = Just v_ }


{-| Dispatched when the checked state of a radio button changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg
onInput v_ (Builder f_) =
    Builder { f_ | onInput = Just v_ }


{-| Dispatched when the checked state of a radio button changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }