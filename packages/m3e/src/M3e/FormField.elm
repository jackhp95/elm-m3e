module M3e.FormField exposing
    ( view, floatLabel, hideRequiredMarker, hideSubscript, variant, child
    , prefix, prefixText, label, suffix, suffixText, hint, error
    , children
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

### Examples

<!-- elm-cem:example title="Variants" -->
```elm
M3e.FormField.view [ M3e.FormField.variant M3e.Value.outlined ] [ M3e.FormField.label "fld" (Native.node Html.label [] [ Kit.text "Outlined" ]), M3e.FormField.child "fld" (Native.node Html.input [] []) ]
```

<!-- elm-cem:example title="Float label" -->
```elm
M3e.FormField.view [ M3e.FormField.floatLabel M3e.Value.always ] [ M3e.FormField.label "fld" (Native.node Html.label [] [ Kit.text "Always float label" ]), M3e.FormField.child "fld" (Native.node Html.input [] []) ]
```

<!-- elm-cem:example title="Hint labels" -->
```elm
M3e.FormField.view [ M3e.FormField.hideSubscript M3e.Value.never ] [ M3e.FormField.label "fld" (Native.node Html.label [] [ Kit.text "Field w/ hint" ]), M3e.FormField.hint (Native.span [] [ Kit.text "Hint text" ]), M3e.FormField.child "fld" (Native.node Html.input [] []) ]
```

<!-- elm-cem:example title="Error messages" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "fld5" (Native.node Html.label [] [ Kit.text "Required field" ]), M3e.FormField.hint (Native.span [] [ Kit.text "Hint text" ]), M3e.FormField.child "fld5" (Native.node Html.input [] []) ]
```

<!-- elm-cem:example title="Error messages (2)" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "fld" (Native.node Html.label [] [ Kit.text "Required field" ]), M3e.FormField.hint (Native.span [] [ Kit.text "Hint text" ]), M3e.FormField.error (Native.span [] [ Kit.text "Custom error message" ]), M3e.FormField.child "fld" (Native.node Html.input [] []) ]
```

<!-- elm-cem:example title="Hiding the required marker" -->
```elm
M3e.FormField.view [ M3e.FormField.hideRequiredMarker True ] [ M3e.FormField.label "fld" (Native.node Html.label [] [ Kit.text "Required field" ]), M3e.FormField.child "fld" (Native.node Html.input [] []) ]
```

<!-- elm-cem:example title="Prefix and suffix" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "fld" (Native.node Html.label [] [ Kit.text "Amount" ]), M3e.FormField.prefixText (Native.span [] [ Kit.text "$" ]), M3e.FormField.suffixText (Native.span [] [ Kit.text ".00" ]), M3e.FormField.suffix (M3e.IconButton.view [] [ M3e.IconButton.child (M3e.Icon.view [ M3e.Icon.name "clear" ] []) ]), M3e.FormField.child "fld" (Native.node Html.input [] []) ]
```

<!-- elm-cem:example title="Density" -->
```elm
M3e.FormField.view [ M3e.FormField.variant M3e.Value.outlined ] [ M3e.FormField.label "fld" (Native.node Html.label [] [ Kit.text "Density -3" ]), M3e.FormField.child "fld" (Native.node Html.input [] []) ]
```

@docs view, floatLabel, hideRequiredMarker, hideSubscript, variant, child
@docs prefix, prefixText, label, suffix, suffixText, hint
@docs error, children
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.FormField
import M3e.Content
import M3e.Content.Internal
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
    -> List (M3e.Content.Content { default : M3e.Value.Supported
    , prefix : M3e.Value.Supported
    , prefixText : M3e.Value.Supported
    , label : M3e.Value.Supported
    , suffix : M3e.Value.Supported
    , suffixText : M3e.Value.Supported
    , hint : M3e.Value.Supported
    , error : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | formField : M3e.Value.Supported } msg
view attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.FormField.formField
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Content.toNode content_)
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
child :
    String
    -> M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child id_ el =
    M3e.Content.Internal.slotWithAttr "" "id" id_ el


{-| Place content in the `prefix` slot. -}
prefix :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | prefix : M3e.Value.Supported } msg
prefix el =
    M3e.Content.Internal.slot "prefix" el


{-| Place content in the `prefix-text` slot. -}
prefixText :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | prefixText : M3e.Value.Supported } msg
prefixText el =
    M3e.Content.Internal.slot "prefix-text" el


{-| Place content in the `label` slot, wiring its `for=` from the required `id` for structural label↔control association (ADR 0010 R6). -}
label :
    String
    -> M3e.Element.Element any msg
    -> M3e.Content.Content { r | label : M3e.Value.Supported } msg
label id_ el =
    M3e.Content.Internal.slotWithAttr "label" "for" id_ el


{-| Place content in the `suffix` slot. -}
suffix :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | suffix : M3e.Value.Supported } msg
suffix el =
    M3e.Content.Internal.slot "suffix" el


{-| Place content in the `suffix-text` slot. -}
suffixText :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | suffixText : M3e.Value.Supported } msg
suffixText el =
    M3e.Content.Internal.slot "suffix-text" el


{-| Place content in the `hint` slot. -}
hint :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | hint : M3e.Value.Supported } msg
hint el =
    M3e.Content.Internal.slot "hint" el


{-| Place content in the `error` slot. -}
error :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | error : M3e.Value.Supported } msg
error el =
    M3e.Content.Internal.slot "error" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.Internal.slot "") els