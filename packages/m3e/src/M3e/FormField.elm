module M3e.FormField exposing
    ( view, floatLabel, hideRequiredMarker, hideSubscript, variant, control
    , prefix, prefixText, label, suffix, suffixText, hint, error
    )

{-|
A container for form controls that applies Material Design styling and behavior.

**Component Info:**
- **Extends:** `LitElement`

**Slots:**
- `prefix`: Renders content before the fields's control.
- `prefix-text`: Renders text before the fields's control.
- `suffix`: Renders content after the fields's control.
- `suffix-text`: Renders text after the fields's control.
- `hint`: Renders hint text in the fields's subscript, when the control is valid.
- `error`: Renders error text in the fields's subscript, when the control is invalid.

<!-- elm-cem:docmeta category=Text inputs -->

## Examples

### Variants

<!-- elm-cem:example title="Variants" -->
```elm
[ M3e.FormField.view [ M3e.FormField.variant M3e.Value.outlined ] [ M3e.FormField.label "fld1" (Native.node Html.label [] [ Kit.text "Outlined" ]), M3e.FormField.control "fld1" (Native.node Html.input [] []) ]
    , M3e.FormField.view [ M3e.FormField.variant M3e.Value.filled ] [ M3e.FormField.label "fld2" (Native.node Html.label [] [ Kit.text "Filled" ]), M3e.FormField.control "fld2" (Native.node Html.input [] []) ]
    ]
```

### Examples

<!-- elm-cem:example title="Float label" -->
```elm
M3e.FormField.view [ M3e.FormField.floatLabel M3e.Value.always ] [ M3e.FormField.label "fld3" (Native.node Html.label [] [ Kit.text "Always float label" ]), M3e.FormField.control "fld3" (Native.node Html.input [] []) ]
```

<!-- elm-cem:example title="Hint labels" -->
```elm
M3e.FormField.view [ M3e.FormField.hideSubscript M3e.Value.auto ] [ M3e.FormField.label "fld4" (Native.node Html.label [] [ Kit.text "Field w/ hint" ]), M3e.FormField.hint (Native.span [] [ Kit.text "Hint text" ]), M3e.FormField.control "fld4" (Native.node Html.input [] []) ]
```

<!-- elm-cem:example title="Error messages" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "fld5" (Native.node Html.label [] [ Kit.text "Required field" ]), M3e.FormField.hint (Native.span [] [ Kit.text "Hint text" ]), M3e.FormField.control "fld5" (Native.node Html.input [] []) ]
```

<!-- elm-cem:example title="Error messages (2)" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "fld6" (Native.node Html.label [] [ Kit.text "Required field" ]), M3e.FormField.hint (Native.span [] [ Kit.text "Hint text" ]), M3e.FormField.error (Native.span [] [ Kit.text "Custom error message" ]), M3e.FormField.control "fld6" (Native.node Html.input [] []) ]
```

<!-- elm-cem:example title="Hiding the required marker" -->
```elm
M3e.FormField.view [ M3e.FormField.hideRequiredMarker True ] [ M3e.FormField.label "fld7" (Native.node Html.label [] [ Kit.text "Required field" ]), M3e.FormField.control "fld7" (Native.node Html.input [] []) ]
```

<!-- elm-cem:example title="Prefix and suffix" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "fld8" (Native.node Html.label [] [ Kit.text "Amount" ]), M3e.FormField.prefixText (Native.span [] [ Kit.text "$" ]), M3e.FormField.suffixText (Native.span [] [ Kit.text ".00" ]), M3e.FormField.suffix (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "clear" ] [] ]), M3e.FormField.control "fld8" (Native.node Html.input [] []) ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.FormField.view [ M3e.FormField.variant M3e.Value.outlined ] [ M3e.FormField.label "dfld1" (Native.node Html.label [] [ Kit.text "Density -3" ]), M3e.FormField.control "dfld1" (Native.node Html.input [] []) ]
    , M3e.FormField.view [ M3e.FormField.variant M3e.Value.outlined ] [ M3e.FormField.label "dfld2" (Native.node Html.label [] [ Kit.text "Density -2" ]), M3e.FormField.control "dfld2" (Native.node Html.input [] []) ]
    , M3e.FormField.view [ M3e.FormField.variant M3e.Value.outlined ] [ M3e.FormField.label "dfld3" (Native.node Html.label [] [ Kit.text "Density -1" ]), M3e.FormField.control "dfld3" (Native.node Html.input [] []) ]
    , M3e.FormField.view [ M3e.FormField.variant M3e.Value.outlined ] [ M3e.FormField.label "dfld4" (Native.node Html.label [] [ Kit.text "Density 0" ]), M3e.FormField.control "dfld4" (Native.node Html.input [] []) ]
    ]
```

<!-- elm-cem:example title="Density (2)" -->
```elm
[ M3e.FormField.view [ M3e.FormField.variant M3e.Value.filled ] [ M3e.FormField.label "dfld5" (Native.node Html.label [] [ Kit.text "Density -3" ]), M3e.FormField.control "dfld5" (Native.node Html.input [] []) ]
    , M3e.FormField.view [ M3e.FormField.variant M3e.Value.filled ] [ M3e.FormField.label "dfld6" (Native.node Html.label [] [ Kit.text "Density -2" ]), M3e.FormField.control "dfld6" (Native.node Html.input [] []) ]
    , M3e.FormField.view [ M3e.FormField.variant M3e.Value.filled ] [ M3e.FormField.label "dfld7" (Native.node Html.label [] [ Kit.text "Density -1" ]), M3e.FormField.control "dfld7" (Native.node Html.input [] []) ]
    , M3e.FormField.view [ M3e.FormField.variant M3e.Value.filled ] [ M3e.FormField.label "dfld8" (Native.node Html.label [] [ Kit.text "Density 0" ]), M3e.FormField.control "dfld8" (Native.node Html.input [] []) ]
    ]
```

@docs view, floatLabel, hideRequiredMarker, hideSubscript, variant, control
@docs prefix, prefixText, label, suffix, suffixText, hint
@docs error
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.FormField
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-form-field>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { floatLabel : M3e.Value.Supported
    , hideRequiredMarker : M3e.Value.Supported
    , hideSubscript : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | formField : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.FormField.formField
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| Specifies whether the label should float always or only when necessary. (default: `"auto"`) -}
floatLabel :
    M3e.Value.Value { always : M3e.Value.Supported, auto : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | floatLabel : M3e.Value.Supported } msg
floatLabel =
    M3e.Cem.FormField.floatLabel


{-| Whether the required marker should be hidden. (default: `false`) -}
hideRequiredMarker :
    Bool
    -> M3e.Cem.Attr.Attr { c | hideRequiredMarker : M3e.Value.Supported } msg
hideRequiredMarker =
    M3e.Cem.FormField.hideRequiredMarker


{-| Whether subscript content is hidden. (default: `"auto"`) -}
hideSubscript :
    M3e.Value.Value { always : M3e.Value.Supported
    , auto : M3e.Value.Supported
    , never : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | hideSubscript : M3e.Value.Supported } msg
hideSubscript =
    M3e.Cem.FormField.hideSubscript


{-| The appearance variant of the field. (default: `"outlined"`) -}
variant :
    M3e.Value.Value { filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant =
    M3e.Cem.FormField.variant


{-| Place content in the `(default)` slot, wiring its `id=` from the required `id` for structural label↔control association (ADR 0010 R6). -}
control : String -> M3e.Element.Element k msg -> M3e.Element.Element k msg
control id_ el =
    M3e.Element.withAttr "id" id_ el


{-| Place content in the `prefix` slot. -}
prefix : M3e.Element.Element any msg -> M3e.Element.Element k msg
prefix el =
    M3e.Element.Internal.placeSlot "prefix" el


{-| Place content in the `prefix-text` slot. -}
prefixText : M3e.Element.Element any msg -> M3e.Element.Element k msg
prefixText el =
    M3e.Element.Internal.placeSlot "prefix-text" el


{-| Place content in the `label` slot, wiring its `for=` from the required `id` for structural label↔control association (ADR 0010 R6). -}
label : String -> M3e.Element.Element any msg -> M3e.Element.Element k msg
label id_ el =
    M3e.Element.Internal.placeSlot "label" (M3e.Element.withAttr "for" id_ el)


{-| Place content in the `suffix` slot. -}
suffix : M3e.Element.Element any msg -> M3e.Element.Element k msg
suffix el =
    M3e.Element.Internal.placeSlot "suffix" el


{-| Place content in the `suffix-text` slot. -}
suffixText : M3e.Element.Element any msg -> M3e.Element.Element k msg
suffixText el =
    M3e.Element.Internal.placeSlot "suffix-text" el


{-| Place content in the `hint` slot. -}
hint : M3e.Element.Element any msg -> M3e.Element.Element k msg
hint el =
    M3e.Element.Internal.placeSlot "hint" el


{-| Place content in the `error` slot. -}
error : M3e.Element.Element any msg -> M3e.Element.Element k msg
error el =
    M3e.Element.Internal.placeSlot "error" el