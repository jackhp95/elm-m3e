module M3e.Build.FormField exposing
    ( Builder, AttrCaps, SlotCaps, formField, attr, floatLabel
    , hideRequiredMarker, hideSubscript, variant, prefix, prefixText, suffix, suffixText
    , hint, error, build
    )

{-|
The ⑤ Build shape for `<m3e-form-field>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.FormField as FormField`.

@docs Builder, AttrCaps, SlotCaps, formField, attr, floatLabel
@docs hideRequiredMarker, hideSubscript, variant, prefix, prefixText, suffix
@docs suffixText, hint, error, build
-}


import M3e.Build.Internal
import M3e.Cem.Attr.Internal
import M3e.Cem.FormField
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Phantom-typed opaque builder for `<m3e-form-field>`. -}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder { kind
        | formField : M3e.Value.Supported
    } attrCaps slotCaps msg


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


{-| Seed a `Builder` for `<m3e-form-field>`. -}
formField : Builder AttrCaps SlotCaps msg kind
formField =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
             (\erased_ ch_ ->
                  M3e.Cem.FormField.formField
                      (List.map M3e.Cem.Attr.Internal.forget erased_)
                      ch_
             )
             []
             []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times. -}
attr :
    M3e.Cem.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget a_)
             (M3e.Build.Internal.node_ b_)
        )


{-| Specifies whether the label should float always or only when necessary. (default: `"auto"`) -}
floatLabel :
    M3e.Value.Value { always : M3e.Value.Supported, auto : M3e.Value.Supported }
    -> Builder { a | floatLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | floatLabel : M3e.Build.Internal.Used } s msg kind
floatLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.FormField.floatLabel v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether the required marker should be hidden. (default: `false`) -}
hideRequiredMarker :
    Bool
    -> Builder { a
        | hideRequiredMarker : M3e.Build.Internal.Available
    } s msg kind
    -> Builder { a | hideRequiredMarker : M3e.Build.Internal.Used } s msg kind
hideRequiredMarker v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget
                  (M3e.Cem.FormField.hideRequiredMarker v_)
             )
             (M3e.Build.Internal.node_ b_)
        )


{-| Whether subscript content is hidden. (default: `"auto"`) -}
hideSubscript :
    M3e.Value.Value { always : M3e.Value.Supported
    , auto : M3e.Value.Supported
    , never : M3e.Value.Supported
    }
    -> Builder { a | hideSubscript : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | hideSubscript : M3e.Build.Internal.Used } s msg kind
hideSubscript v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.FormField.hideSubscript v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| The appearance variant of the field. (default: `"outlined"`) -}
variant :
    M3e.Value.Value { filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> Builder { a | variant : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | variant : M3e.Build.Internal.Used } s msg kind
variant v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
             (M3e.Cem.Attr.Internal.forget (M3e.Cem.FormField.variant v_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `prefix` slot. -}
prefix :
    M3e.Element.Element any msg
    -> Builder a { s | prefix : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | prefix : M3e.Build.Internal.Used } msg kind
prefix el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "prefix" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `prefix-text` slot. -}
prefixText :
    M3e.Element.Element any msg
    -> Builder a { s | prefixText : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | prefixText : M3e.Build.Internal.Used } msg kind
prefixText el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "prefix-text" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `suffix` slot. -}
suffix :
    M3e.Element.Element any msg
    -> Builder a { s | suffix : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | suffix : M3e.Build.Internal.Used } msg kind
suffix el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "suffix" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `suffix-text` slot. -}
suffixText :
    M3e.Element.Element any msg
    -> Builder a { s | suffixText : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | suffixText : M3e.Build.Internal.Used } msg kind
suffixText el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "suffix-text" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `hint` slot. -}
hint :
    M3e.Element.Element any msg
    -> Builder a { s | hint : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | hint : M3e.Build.Internal.Used } msg kind
hint el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "hint" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `error` slot. -}
error :
    M3e.Element.Element any msg
    -> Builder a { s | error : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | error : M3e.Build.Internal.Used } msg kind
error el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Element.toNode (M3e.Element.withSlot "error" el_))
             (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-form-field>` element from a `Builder`. -}
build :
    Builder a s msg kind
    -> M3e.Element.Element { formField : M3e.Value.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)