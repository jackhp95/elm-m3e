module M3e.Build.Checkbox exposing
    ( Builder, AttrCaps, SlotCaps, checkbox, checked, disabled
    , indeterminate, name, required, value, onBeforeinput, onInput, onChange
    , onInvalid, onClick
    )

{-|
The ⑤ Build shape for `<m3e-checkbox>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Checkbox as Checkbox`.

@docs Builder, AttrCaps, SlotCaps, checkbox, checked, disabled
@docs indeterminate, name, required, value, onBeforeinput, onInput
@docs onChange, onInvalid, onClick
-}


import Json.Decode
import M3e.Build.Internal


{-| Opaque builder for `<m3e-checkbox>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { checked : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , indeterminate : M3e.Build.Internal.Available
    , name : M3e.Build.Internal.Available
    , required : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onInvalid : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


type alias Fields msg =
    { checked : Maybe Bool
    , disabled : Maybe Bool
    , indeterminate : Maybe Bool
    , name : Maybe String
    , required : Maybe Bool
    , value : Maybe String
    , onBeforeinput : Maybe (Json.Decode.Decoder msg)
    , onInput : Maybe (Json.Decode.Decoder msg)
    , onChange : Maybe (Json.Decode.Decoder msg)
    , onInvalid : Maybe (Json.Decode.Decoder msg)
    , onClick : Maybe (Json.Decode.Decoder msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-checkbox>`. -}
checkbox : Builder AttrCaps SlotCaps msg
checkbox =
    Builder
        { checked = Nothing
        , disabled = Nothing
        , indeterminate = Nothing
        , name = Nothing
        , required = Nothing
        , value = Nothing
        , onBeforeinput = Nothing
        , onInput = Nothing
        , onChange = Nothing
        , onInvalid = Nothing
        , onClick = Nothing
        , phantomMsg_ = Nothing
        }


{-| Whether the element is checked. (default: `false`) -}
checked :
    Bool
    -> Builder { a | checked : M3e.Build.Internal.Available } s msg
    -> Builder { a | checked : M3e.Build.Internal.Used } s msg
checked v_ (Builder f_) =
    Builder { f_ | checked = Just v_ }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| Whether the element's checked state is indeterminate. (default: `false`) -}
indeterminate :
    Bool
    -> Builder { a | indeterminate : M3e.Build.Internal.Available } s msg
    -> Builder { a | indeterminate : M3e.Build.Internal.Used } s msg
indeterminate v_ (Builder f_) =
    Builder { f_ | indeterminate = Just v_ }


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


{-| A string representing the value of the checkbox. (default: `"on"`) -}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg
    -> Builder { a | value : M3e.Build.Internal.Used } s msg
value v_ (Builder f_) =
    Builder { f_ | value = Just v_ }


{-| Dispatched before the checked state changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg
onBeforeinput v_ (Builder f_) =
    Builder { f_ | onBeforeinput = Just v_ }


{-| Dispatched when the checked state changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg
onInput v_ (Builder f_) =
    Builder { f_ | onInput = Just v_ }


{-| Dispatched when the checked state changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }


{-| Dispatched when a form is submitted and the element fails constraint validation. -}
onInvalid :
    Json.Decode.Decoder msg
    -> Builder { a | onInvalid : M3e.Build.Internal.Available } s msg
    -> Builder { a | onInvalid : M3e.Build.Internal.Used } s msg
onInvalid v_ (Builder f_) =
    Builder { f_ | onInvalid = Just v_ }


{-| Dispatched when the element is clicked. -}
onClick :
    Json.Decode.Decoder msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg
onClick v_ (Builder f_) =
    Builder { f_ | onClick = Just v_ }