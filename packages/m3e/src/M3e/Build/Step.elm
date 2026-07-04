module M3e.Build.Step exposing
    ( Builder, AttrCaps, SlotCaps, step, completed, disabled
    , editable, for, optional, selected, invalid, onBeforeinput, onInput
    , onChange, onClick, icon, doneIcon, editIcon, errorIcon, hint
    , error
    )

{-|
The ⑤ Build shape for `<m3e-step>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Step as Step`.

@docs Builder, AttrCaps, SlotCaps, step, completed, disabled
@docs editable, for, optional, selected, invalid, onBeforeinput
@docs onInput, onChange, onClick, icon, doneIcon, editIcon
@docs errorIcon, hint, error
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-step>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { completed : M3e.Build.Internal.Available
    , disabled : M3e.Build.Internal.Available
    , editable : M3e.Build.Internal.Available
    , for : M3e.Build.Internal.Available
    , optional : M3e.Build.Internal.Available
    , selected : M3e.Build.Internal.Available
    , invalid : M3e.Build.Internal.Available
    , onBeforeinput : M3e.Build.Internal.Available
    , onInput : M3e.Build.Internal.Available
    , onChange : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { icon : M3e.Build.Internal.Available
    , doneIcon : M3e.Build.Internal.Available
    , editIcon : M3e.Build.Internal.Available
    , errorIcon : M3e.Build.Internal.Available
    , hint : M3e.Build.Internal.Available
    , error : M3e.Build.Internal.Available
    }


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


{-| Whether the step has been completed. (default: `false`) -}
completed :
    Bool
    -> Builder { a | completed : M3e.Build.Internal.Available } s msg
    -> Builder { a | completed : M3e.Build.Internal.Used } s msg
completed v_ (Builder f_) =
    Builder { f_ | completed = Just v_ }


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| Whether the step is editable and users can return to it after completion. (default: `false`) -}
editable :
    Bool
    -> Builder { a | editable : M3e.Build.Internal.Available } s msg
    -> Builder { a | editable : M3e.Build.Internal.Used } s msg
editable v_ (Builder f_) =
    Builder { f_ | editable = Just v_ }


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for :
    String
    -> Builder { a | for : M3e.Build.Internal.Available } s msg
    -> Builder { a | for : M3e.Build.Internal.Used } s msg
for v_ (Builder f_) =
    Builder { f_ | for = Just v_ }


{-| Whether the step is optional. (default: `false`) -}
optional :
    Bool
    -> Builder { a | optional : M3e.Build.Internal.Available } s msg
    -> Builder { a | optional : M3e.Build.Internal.Used } s msg
optional v_ (Builder f_) =
    Builder { f_ | optional = Just v_ }


{-| Whether the element is selected. (default: `false`) -}
selected :
    Bool
    -> Builder { a | selected : M3e.Build.Internal.Available } s msg
    -> Builder { a | selected : M3e.Build.Internal.Used } s msg
selected v_ (Builder f_) =
    Builder { f_ | selected = Just v_ }


{-| Whether the step has an error. (default: `false`) -}
invalid :
    Bool
    -> Builder { a | invalid : M3e.Build.Internal.Available } s msg
    -> Builder { a | invalid : M3e.Build.Internal.Used } s msg
invalid v_ (Builder f_) =
    Builder { f_ | invalid = Just v_ }


{-| Dispatched before the selected state changes. -}
onBeforeinput :
    Json.Decode.Decoder msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onBeforeinput : M3e.Build.Internal.Used } s msg
onBeforeinput v_ (Builder f_) =
    Builder { f_ | onBeforeinput = Just v_ }


{-| Dispatched when the selected state changes. -}
onInput :
    Json.Decode.Decoder msg
    -> Builder { a | onInput : M3e.Build.Internal.Available } s msg
    -> Builder { a | onInput : M3e.Build.Internal.Used } s msg
onInput v_ (Builder f_) =
    Builder { f_ | onInput = Just v_ }


{-| Dispatched when the selected state changes. -}
onChange :
    Json.Decode.Decoder msg
    -> Builder { a | onChange : M3e.Build.Internal.Available } s msg
    -> Builder { a | onChange : M3e.Build.Internal.Used } s msg
onChange v_ (Builder f_) =
    Builder { f_ | onChange = Just v_ }


{-| Dispatched when the element is clicked. -}
onClick :
    Json.Decode.Decoder msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg
onClick v_ (Builder f_) =
    Builder { f_ | onClick = Just v_ }


{-| Set the `icon` slot. Consumes the `icon` slot capability. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg
icon v_ (Builder f_) =
    Builder { f_ | icon = Just v_ }


{-| Set the `done-icon` slot. Consumes the `doneIcon` slot capability. -}
doneIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | doneIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | doneIcon : M3e.Build.Internal.Used } msg
doneIcon v_ (Builder f_) =
    Builder { f_ | doneIcon = Just v_ }


{-| Set the `edit-icon` slot. Consumes the `editIcon` slot capability. -}
editIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | editIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | editIcon : M3e.Build.Internal.Used } msg
editIcon v_ (Builder f_) =
    Builder { f_ | editIcon = Just v_ }


{-| Set the `error-icon` slot. Consumes the `errorIcon` slot capability. -}
errorIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | errorIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | errorIcon : M3e.Build.Internal.Used } msg
errorIcon v_ (Builder f_) =
    Builder { f_ | errorIcon = Just v_ }


{-| Set the `hint` slot. Consumes the `hint` slot capability. -}
hint :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> Builder a { s | hint : M3e.Build.Internal.Available } msg
    -> Builder a { s | hint : M3e.Build.Internal.Used } msg
hint v_ (Builder f_) =
    Builder { f_ | hint = Just v_ }


{-| Set the `error` slot. Consumes the `error` slot capability. -}
error :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> Builder a { s | error : M3e.Build.Internal.Available } msg
    -> Builder a { s | error : M3e.Build.Internal.Used } msg
error v_ (Builder f_) =
    Builder { f_ | error = Just v_ }