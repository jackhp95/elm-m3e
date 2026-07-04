module M3e.Build.Chip exposing
    ( Builder, AttrCaps, SlotCaps, chip, value, variant
    , icon, trailingIcon
    )

{-|
The ⑤ Build shape for `<m3e-chip>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.Chip as Chip`.

@docs Builder, AttrCaps, SlotCaps, chip, value, variant
@docs icon, trailingIcon
-}


import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-chip>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { value : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { icon : M3e.Build.Internal.Available
    , trailingIcon : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
    , value : Maybe String
    , variant :
        Maybe (M3e.Value.Value { elevated : M3e.Value.Supported
        , outlined : M3e.Value.Supported
        })
    , icon : Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , trailingIcon :
        Maybe (M3e.Element.Element { icon : M3e.Value.Supported } msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-chip>` with the required fields. -}
chip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> Builder AttrCaps SlotCaps msg
chip req_ =
    Builder
        { content = req_.content
        , value = Nothing
        , variant = Nothing
        , icon = Nothing
        , trailingIcon = Nothing
        , phantomMsg_ = Nothing
        }


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


{-| Set the `icon` slot. Consumes the `icon` slot capability. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | icon : M3e.Build.Internal.Available } msg
    -> Builder a { s | icon : M3e.Build.Internal.Used } msg
icon v_ (Builder f_) =
    Builder { f_ | icon = Just v_ }


{-| Set the `trailing-icon` slot. Consumes the `trailingIcon` slot capability. -}
trailingIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> Builder a { s | trailingIcon : M3e.Build.Internal.Available } msg
    -> Builder a { s | trailingIcon : M3e.Build.Internal.Used } msg
trailingIcon v_ (Builder f_) =
    Builder { f_ | trailingIcon = Just v_ }