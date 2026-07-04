module M3e.Build.FormField exposing ( Builder, AttrCaps, SlotCaps, formField )

{-|
The ⑤ Build shape for `<m3e-form-field>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FormField as FormField`.

@docs Builder, AttrCaps, SlotCaps, formField
-}


import M3e.Element
import M3e.Value


{-| Opaque builder for `<m3e-form-field>`; see `.build` for the terminal. -}
type Builder attrCaps slotCaps msg
    = Builder (Fields msg)


{-| Per-component attribute capability row for the phantom-typed Builder. -}
type alias AttrCaps =
    {}


{-| Per-component slot capability row for the phantom-typed Builder. -}
type alias SlotCaps =
    {}


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