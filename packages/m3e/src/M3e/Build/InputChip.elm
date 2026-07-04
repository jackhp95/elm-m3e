module M3e.Build.InputChip exposing
    ( Builder, AttrCaps, SlotCaps, inputChip, disabled, disabledInteractive
    , removable, removeLabel, value, variant, onRemove, onClick, avatar
    , icon, removeIcon
    )

{-|
The ⑤ Build shape for `<m3e-input-chip>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.InputChip as InputChip`.

@docs Builder, AttrCaps, SlotCaps, inputChip, disabled, disabledInteractive
@docs removable, removeLabel, value, variant, onRemove, onClick
@docs avatar, icon, removeIcon
-}


import Json.Decode
import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-input-chip>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { disabled : M3e.Build.Internal.Available
    , disabledInteractive : M3e.Build.Internal.Available
    , removable : M3e.Build.Internal.Available
    , removeLabel : M3e.Build.Internal.Available
    , value : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    , onRemove : M3e.Build.Internal.Available
    , onClick : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { avatar : M3e.Build.Internal.Available
    , icon : M3e.Build.Internal.Available
    , removeIcon : M3e.Build.Internal.Available
    }


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


{-| Whether the element is disabled. (default: `false`) -}
disabled :
    Bool
    -> Builder { a | disabled : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabled : M3e.Build.Internal.Used } s msg
disabled v_ (Builder f_) =
    Builder { f_ | disabled = Just v_ }


{-| Whether the element is disabled and interactive. (default: `false`) -}
disabledInteractive :
    Bool
    -> Builder { a | disabledInteractive : M3e.Build.Internal.Available } s msg
    -> Builder { a | disabledInteractive : M3e.Build.Internal.Used } s msg
disabledInteractive v_ (Builder f_) =
    Builder { f_ | disabledInteractive = Just v_ }


{-| Whether the chip is removable. (default: `false`) -}
removable :
    Bool
    -> Builder { a | removable : M3e.Build.Internal.Available } s msg
    -> Builder { a | removable : M3e.Build.Internal.Used } s msg
removable v_ (Builder f_) =
    Builder { f_ | removable = Just v_ }


{-| The accessible label given to the button used to remove the chip. (default: `"Remove"`) -}
removeLabel :
    String
    -> Builder { a | removeLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | removeLabel : M3e.Build.Internal.Used } s msg
removeLabel v_ (Builder f_) =
    Builder { f_ | removeLabel = Just v_ }


{-| A string representing the value of the chip. -}
value :
    String
    -> Builder { a | value : M3e.Build.Internal.Available } s msg
    -> Builder { a | value : M3e.Build.Internal.Used } s msg
value v_ (Builder f_) =
    Builder { f_ | value = Just v_ }


{-| The appearance variant of the chip. (default: `"outlined"`) -}
variant :
    M3e.Value.Value { elevated : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }


{-| Dispatched when the remove button is clicked or DELETE or BACKSPACE key is pressed. -}
onRemove :
    Json.Decode.Decoder msg
    -> Builder { a | onRemove : M3e.Build.Internal.Available } s msg
    -> Builder { a | onRemove : M3e.Build.Internal.Used } s msg
onRemove v_ (Builder f_) =
    Builder { f_ | onRemove = Just v_ }


{-| Dispatched when the element is clicked. -}
onClick :
    Json.Decode.Decoder msg
    -> Builder { a | onClick : M3e.Build.Internal.Available } s msg
    -> Builder { a | onClick : M3e.Build.Internal.Used } s msg
onClick v_ (Builder f_) =
    Builder { f_ | onClick = Just v_ }


{-| Set the `avatar` slot. Consumes the `avatar` slot capability. -}
avatar :
    M3e.Element.Element { avatar : M3e.Value.Supported } msg
    -> Builder a { s | avatar : M3e.Build.Internal.Available } msg
    -> Builder a { s | avatar : M3e.Build.Internal.Used } msg
avatar v_ (Builder f_) =
    Builder { f_ | avatar = Just v_ }


{-| Set the `icon` slot. Consumes the `icon` slot capability. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg
icon v_ (Builder f_) =
    Builder { f_ | icon = Just v_ }


{-| Set the `remove-icon` slot. Consumes the `removeIcon` slot capability. -}
removeIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | removeIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | removeIcon : M3e.Build.Internal.Used } msg
removeIcon v_ (Builder f_) =
    Builder { f_ | removeIcon = Just v_ }