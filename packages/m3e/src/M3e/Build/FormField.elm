module M3e.Build.FormField exposing
    ( Builder, AttrCaps, SlotCaps, formField, floatLabel, hideRequiredMarker
    , hideSubscript, variant, prefix, prefixText, label, suffix, suffixText
    , hint, error, default
    )

{-|
The ⑤ Build shape for `<m3e-form-field>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FormField as FormField`.

@docs Builder, AttrCaps, SlotCaps, formField, floatLabel, hideRequiredMarker
@docs hideSubscript, variant, prefix, prefixText, label, suffix
@docs suffixText, hint, error, default
-}


import M3e.Build.Internal
import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-form-field>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    { floatLabel : M3e.Build.Internal.Available
    , hideRequiredMarker : M3e.Build.Internal.Available
    , hideSubscript : M3e.Build.Internal.Available
    , variant : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    { prefix : M3e.Build.Internal.Available
    , prefixText : M3e.Build.Internal.Available
    , label : M3e.Build.Internal.Available
    , suffix : M3e.Build.Internal.Available
    , suffixText : M3e.Build.Internal.Available
    , hint : M3e.Build.Internal.Available
    , error : M3e.Build.Internal.Available
    }


type alias Fields msg =
    { floatLabel :
        Maybe (M3e.Value.Value { always : M3e.Value.Supported
        , auto : M3e.Value.Supported
        })
    , hideRequiredMarker : Maybe Bool
    , hideSubscript :
        Maybe (M3e.Value.Value { always : M3e.Value.Supported
        , auto : M3e.Value.Supported
        , never : M3e.Value.Supported
        })
    , variant :
        Maybe (M3e.Value.Value { filled : M3e.Value.Supported
        , outlined : M3e.Value.Supported
        })
    , prefix : Maybe (M3e.Element.Element {} msg)
    , prefixText : Maybe (M3e.Element.Element {} msg)
    , label : Maybe (M3e.Element.Element {} msg)
    , suffix : Maybe (M3e.Element.Element {} msg)
    , suffixText : Maybe (M3e.Element.Element {} msg)
    , hint : Maybe (M3e.Element.Element {} msg)
    , error : Maybe (M3e.Element.Element {} msg)
    , default : List (M3e.Element.Element {} msg)
    , phantomMsg_ : Maybe msg
    }


{-| Seed a `Builder` for `<m3e-form-field>`. -}
formField : Builder AttrCaps SlotCaps msg
formField =
    Builder
        { floatLabel = Nothing
        , hideRequiredMarker = Nothing
        , hideSubscript = Nothing
        , variant = Nothing
        , prefix = Nothing
        , prefixText = Nothing
        , label = Nothing
        , suffix = Nothing
        , suffixText = Nothing
        , hint = Nothing
        , error = Nothing
        , default = []
        , phantomMsg_ = Nothing
        }


{-| Specifies whether the label should float always or only when necessary. (default: `"auto"`) -}
floatLabel :
    M3e.Value.Value { always : M3e.Value.Supported, auto : M3e.Value.Supported }
    -> Builder { a | floatLabel : M3e.Build.Internal.Available } s msg
    -> Builder { a | floatLabel : M3e.Build.Internal.Used } s msg
floatLabel v_ (Builder f_) =
    Builder { f_ | floatLabel = Just v_ }


{-| Whether the required marker should be hidden. (default: `false`) -}
hideRequiredMarker :
    Bool
    -> Builder { a | hideRequiredMarker : M3e.Build.Internal.Available } s msg
    -> Builder { a | hideRequiredMarker : M3e.Build.Internal.Used } s msg
hideRequiredMarker v_ (Builder f_) =
    Builder { f_ | hideRequiredMarker = Just v_ }


{-| Whether subscript content is hidden. (default: `"auto"`) -}
hideSubscript :
    M3e.Value.Value { always : M3e.Value.Supported
    , auto : M3e.Value.Supported
    , never : M3e.Value.Supported
    }
    -> Builder { a | hideSubscript : M3e.Build.Internal.Available } s msg
    -> Builder { a | hideSubscript : M3e.Build.Internal.Used } s msg
hideSubscript v_ (Builder f_) =
    Builder { f_ | hideSubscript = Just v_ }


{-| The appearance variant of the field. (default: `"outlined"`) -}
variant :
    M3e.Value.Value { filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg
variant v_ (Builder f_) =
    Builder { f_ | variant = Just v_ }


{-| Set the `prefix` slot. Consumes the `prefix` slot capability. -}
prefix :
    M3e.Element.Element {} msg
    -> Builder a { s | prefix : M3e.Build.Internal.Available } msg
    -> Builder a { s | prefix : M3e.Build.Internal.Used } msg
prefix v_ (Builder f_) =
    Builder { f_ | prefix = Just v_ }


{-| Set the `prefix-text` slot. Consumes the `prefixText` slot capability. -}
prefixText :
    M3e.Element.Element {} msg
    -> Builder a { s | prefixText : M3e.Build.Internal.Available } msg
    -> Builder a { s | prefixText : M3e.Build.Internal.Used } msg
prefixText v_ (Builder f_) =
    Builder { f_ | prefixText = Just v_ }


{-| Set the `label` slot. Consumes the `label` slot capability. -}
label :
    M3e.Element.Element {} msg
    -> Builder a { s | label : M3e.Build.Internal.Available } msg
    -> Builder a { s | label : M3e.Build.Internal.Used } msg
label v_ (Builder f_) =
    Builder { f_ | label = Just v_ }


{-| Set the `suffix` slot. Consumes the `suffix` slot capability. -}
suffix :
    M3e.Element.Element {} msg
    -> Builder a { s | suffix : M3e.Build.Internal.Available } msg
    -> Builder a { s | suffix : M3e.Build.Internal.Used } msg
suffix v_ (Builder f_) =
    Builder { f_ | suffix = Just v_ }


{-| Set the `suffix-text` slot. Consumes the `suffixText` slot capability. -}
suffixText :
    M3e.Element.Element {} msg
    -> Builder a { s | suffixText : M3e.Build.Internal.Available } msg
    -> Builder a { s | suffixText : M3e.Build.Internal.Used } msg
suffixText v_ (Builder f_) =
    Builder { f_ | suffixText = Just v_ }


{-| Set the `hint` slot. Consumes the `hint` slot capability. -}
hint :
    M3e.Element.Element {} msg
    -> Builder a { s | hint : M3e.Build.Internal.Available } msg
    -> Builder a { s | hint : M3e.Build.Internal.Used } msg
hint v_ (Builder f_) =
    Builder { f_ | hint = Just v_ }


{-| Set the `error` slot. Consumes the `error` slot capability. -}
error :
    M3e.Element.Element {} msg
    -> Builder a { s | error : M3e.Build.Internal.Available } msg
    -> Builder a { s | error : M3e.Build.Internal.Used } msg
error v_ (Builder f_) =
    Builder { f_ | error = Just v_ }


{-| Add an element to the `unnamed` (multi) slot. -}
default : M3e.Element.Element {} msg -> Builder a s msg -> Builder a s msg
default v_ (Builder f_) =
    Builder { f_ | default = List.append f_.default [ v_ ] }