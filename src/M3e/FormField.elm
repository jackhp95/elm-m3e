module M3e.FormField exposing
    ( view, floatLabel, hideRequiredMarker, hideSubscript, variant, control
    , prefix, prefixText, label, suffix, suffixText, hint
    , error
    )

{-| A container for form controls that applies Material Design styling and behavior.

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
[ M3e.FormField.view [ M3e.FormField.variant M3e.Token.outlined ] [ M3e.FormField.label "fld1" (Native.node Html.label [ Native.attribute "for" "fld1" ] [ Kit.text "Outlined" ]), M3e.FormField.control "fld1" (Native.node Html.input [ Native.attribute "id" "fld1" ] []) ]
    , M3e.FormField.view [ M3e.FormField.variant M3e.Token.filled ] [ M3e.FormField.label "fld2" (Native.node Html.label [ Native.attribute "for" "fld2" ] [ Kit.text "Filled" ]), M3e.FormField.control "fld2" (Native.node Html.input [ Native.attribute "id" "fld2" ] []) ]
    ]
```


### Examples

<!-- elm-cem:example title="Float label" -->
```elm
M3e.FormField.view [ M3e.FormField.floatLabel M3e.Token.always ] [ M3e.FormField.label "fld3" (Native.node Html.label [ Native.attribute "for" "fld3" ] [ Kit.text "Always float label" ]), M3e.FormField.control "fld3" (Native.node Html.input [ Native.attribute "id" "fld3" ] []) ]
```

<!-- elm-cem:example title="Hint labels" -->
```elm
M3e.FormField.view [ M3e.FormField.hideSubscript M3e.Token.auto ] [ M3e.FormField.label "fld4" (Native.node Html.label [ Native.attribute "for" "fld4" ] [ Kit.text "Field w/ hint" ]), M3e.FormField.control "fld4" (Native.node Html.input [ Native.attribute "id" "fld4" ] []), M3e.FormField.hint (Native.span [] [ Kit.text "Hint text" ]) ]
```

<!-- elm-cem:example title="Error messages" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "fld5" (Native.node Html.label [ Native.attribute "for" "fld5" ] [ Kit.text "Required field" ]), M3e.FormField.control "fld5" (Native.node Html.input [ Native.attribute "id" "fld5", Native.attribute "required" "" ] []), M3e.FormField.hint (Native.span [] [ Kit.text "Hint text" ]) ]
```

<!-- elm-cem:example title="Error messages (2)" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "fld6" (Native.node Html.label [ Native.attribute "for" "fld6" ] [ Kit.text "Required field" ]), M3e.FormField.control "fld6" (Native.node Html.input [ Native.attribute "id" "fld6", Native.attribute "required" "" ] []), M3e.FormField.hint (Native.span [] [ Kit.text "Hint text" ]), M3e.FormField.error (Native.span [] [ Kit.text "Custom error message" ]) ]
```

<!-- elm-cem:example title="Hiding the required marker" -->
```elm
M3e.FormField.view [ M3e.FormField.hideRequiredMarker True ] [ M3e.FormField.label "fld7" (Native.node Html.label [ Native.attribute "for" "fld7" ] [ Kit.text "Required field" ]), M3e.FormField.control "fld7" (Native.node Html.input [ Native.attribute "id" "fld7", Native.attribute "required" "" ] []) ]
```

<!-- elm-cem:example title="Prefix and suffix" -->
```elm
M3e.FormField.view [] [ M3e.FormField.label "fld8" (Native.node Html.label [ Native.attribute "for" "fld8" ] [ Kit.text "Amount" ]), M3e.FormField.prefixText (Native.span [] [ Kit.text "$" ]), M3e.FormField.control "fld8" (Native.node Html.input [ Native.attribute "id" "fld8", Native.attribute "type" "number", Native.attribute "placeholder" "0" ] []), M3e.FormField.suffixText (Native.span [] [ Kit.text ".00" ]), M3e.FormField.suffix (M3e.IconButton.view [] [ M3e.Icon.view [ M3e.Icon.name "clear" ] [] ]) ]
```

<!-- elm-cem:example title="Density" -->
```elm
[ M3e.FormField.view [ M3e.FormField.variant M3e.Token.outlined, M3e.Attributes.class "density-3" ] [ M3e.FormField.label "dfld1" (Native.node Html.label [ Native.attribute "for" "dfld1" ] [ Kit.text "Density -3" ]), M3e.FormField.control "dfld1" (Native.node Html.input [ Native.attribute "id" "dfld1" ] []) ]
    , M3e.FormField.view [ M3e.FormField.variant M3e.Token.outlined, M3e.Attributes.class "density-2" ] [ M3e.FormField.label "dfld2" (Native.node Html.label [ Native.attribute "for" "dfld2" ] [ Kit.text "Density -2" ]), M3e.FormField.control "dfld2" (Native.node Html.input [ Native.attribute "id" "dfld2" ] []) ]
    , M3e.FormField.view [ M3e.FormField.variant M3e.Token.outlined, M3e.Attributes.class "density-1" ] [ M3e.FormField.label "dfld3" (Native.node Html.label [ Native.attribute "for" "dfld3" ] [ Kit.text "Density -1" ]), M3e.FormField.control "dfld3" (Native.node Html.input [ Native.attribute "id" "dfld3" ] []) ]
    , M3e.FormField.view [ M3e.FormField.variant M3e.Token.outlined, M3e.Attributes.class "density-0" ] [ M3e.FormField.label "dfld4" (Native.node Html.label [ Native.attribute "for" "dfld4" ] [ Kit.text "Density 0" ]), M3e.FormField.control "dfld4" (Native.node Html.input [ Native.attribute "id" "dfld4" ] []) ]
    ]
```

<!-- elm-cem:example title="Density (2)" -->
```elm
[ M3e.FormField.view [ M3e.FormField.variant M3e.Token.filled, M3e.Attributes.class "density-3" ] [ M3e.FormField.label "dfld5" (Native.node Html.label [ Native.attribute "for" "dfld5" ] [ Kit.text "Density -3" ]), M3e.FormField.control "dfld5" (Native.node Html.input [ Native.attribute "id" "dfld5" ] []) ]
    , M3e.FormField.view [ M3e.FormField.variant M3e.Token.filled, M3e.Attributes.class "density-2" ] [ M3e.FormField.label "dfld6" (Native.node Html.label [ Native.attribute "for" "dfld6" ] [ Kit.text "Density -2" ]), M3e.FormField.control "dfld6" (Native.node Html.input [ Native.attribute "id" "dfld6" ] []) ]
    , M3e.FormField.view [ M3e.FormField.variant M3e.Token.filled, M3e.Attributes.class "density-1" ] [ M3e.FormField.label "dfld7" (Native.node Html.label [ Native.attribute "for" "dfld7" ] [ Kit.text "Density -1" ]), M3e.FormField.control "dfld7" (Native.node Html.input [ Native.attribute "id" "dfld7" ] []) ]
    , M3e.FormField.view [ M3e.FormField.variant M3e.Token.filled, M3e.Attributes.class "density-0" ] [ M3e.FormField.label "dfld8" (Native.node Html.label [ Native.attribute "for" "dfld8" ] [ Kit.text "Density 0" ]), M3e.FormField.control "dfld8" (Native.node Html.input [ Native.attribute "id" "dfld8" ] []) ]
    ]
```

@docs view, floatLabel, hideRequiredMarker, hideSubscript, variant, control
@docs prefix, prefixText, label, suffix, suffixText, hint
@docs error

-}

import M3e.Html.FormField
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-form-field>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { floatLabel : M3e.Token.Supported
            , hideRequiredMarker : M3e.Token.Supported
            , hideSubscript : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | formField : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.FormField.formField
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Specifies whether the label should float always or only when necessary. (default: `"auto"`)
-}
floatLabel :
    M3e.Token.Value { always : M3e.Token.Supported, auto : M3e.Token.Supported }
    -> Markup.Html.Attr.Attr { c | floatLabel : M3e.Token.Supported } msg
floatLabel =
    M3e.Html.FormField.floatLabel


{-| Whether the required marker should be hidden. (default: `false`)
-}
hideRequiredMarker :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | hideRequiredMarker : M3e.Token.Supported
            }
            msg
hideRequiredMarker =
    M3e.Html.FormField.hideRequiredMarker


{-| Whether subscript content is hidden. (default: `"auto"`)
-}
hideSubscript :
    M3e.Token.Value
        { always : M3e.Token.Supported
        , auto : M3e.Token.Supported
        , never : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | hideSubscript : M3e.Token.Supported } msg
hideSubscript =
    M3e.Html.FormField.hideSubscript


{-| The appearance variant of the field. (default: `"outlined"`)
-}
variant :
    M3e.Token.Value
        { filled : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        }
    -> Markup.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant =
    M3e.Html.FormField.variant


{-| Place content in the `(default)` slot, wiring its `id=` from the required `id` so the label and control are associated.
-}
control : String -> Markup.Element.Element k msg -> Markup.Element.Element k msg
control id_ el =
    Markup.Element.withAttr "id" id_ el


{-| Place content in the `prefix` slot.
-}
prefix : Markup.Element.Element any msg -> Markup.Element.Element k msg
prefix el =
    Markup.Element.Internal.placeSlot "prefix" el


{-| Place content in the `prefix-text` slot.
-}
prefixText : Markup.Element.Element any msg -> Markup.Element.Element k msg
prefixText el =
    Markup.Element.Internal.placeSlot "prefix-text" el


{-| Place content in the `label` slot, wiring its `for=` from the required `id` so the label and control are associated.
-}
label : String -> Markup.Element.Element any msg -> Markup.Element.Element k msg
label id_ el =
    Markup.Element.Internal.placeSlot
        "label"
        (Markup.Element.withAttr "for" id_ el)


{-| Place content in the `suffix` slot.
-}
suffix : Markup.Element.Element any msg -> Markup.Element.Element k msg
suffix el =
    Markup.Element.Internal.placeSlot "suffix" el


{-| Place content in the `suffix-text` slot.
-}
suffixText : Markup.Element.Element any msg -> Markup.Element.Element k msg
suffixText el =
    Markup.Element.Internal.placeSlot "suffix-text" el


{-| Place content in the `hint` slot.
-}
hint : Markup.Element.Element any msg -> Markup.Element.Element k msg
hint el =
    Markup.Element.Internal.placeSlot "hint" el


{-| Place content in the `error` slot.
-}
error : Markup.Element.Element any msg -> Markup.Element.Element k msg
error el =
    Markup.Element.Internal.placeSlot "error" el
