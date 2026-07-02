module M3e.Cem.FormField exposing
    ( formField, floatLabel, hideRequiredMarker, hideSubscript, variant
    )

{-|
Middle layer for `<m3e-form-field>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.FormField` module for everyday use.

@docs formField, floatLabel, hideRequiredMarker, hideSubscript, variant
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.FormField
import M3e.Value


{-| A container for form controls that applies Material Design styling and behavior.

**Slots:**
- `prefix`: Renders content before the fields's control.
- `prefix-text`: Renders text before the fields's control.
- `suffix`: Renders content after the fields's control.
- `suffix-text`: Renders text after the fields's control.
- `hint`: Renders hint text in the fields's subscript, when the control is valid.
- `error`: Renders error text in the fields's subscript, when the control is invalid.
-}
formField :
    List (M3e.Cem.Attr.Attr { floatLabel : M3e.Value.Supported
    , hideRequiredMarker : M3e.Value.Supported
    , hideSubscript : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
formField attributes children =
    M3e.Cem.Html.FormField.formField
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Specifies whether the label should float always or only when necessary. (default: `"auto"`) -}
floatLabel :
    M3e.Value.Value { always : M3e.Value.Supported, auto : M3e.Value.Supported }
    -> M3e.Cem.Attr.Attr { c | floatLabel : M3e.Value.Supported } msg
floatLabel v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.FormField.floatLabel
        (M3e.Value.toString v_)


{-| Whether the required marker should be hidden. (default: `false`) -}
hideRequiredMarker :
    Bool
    -> M3e.Cem.Attr.Attr { c | hideRequiredMarker : M3e.Value.Supported } msg
hideRequiredMarker =
    M3e.Cem.Attr.attribute M3e.Cem.Html.FormField.hideRequiredMarker


{-| Whether subscript content is hidden. (default: `"auto"`) -}
hideSubscript :
    M3e.Value.Value { always : M3e.Value.Supported
    , auto : M3e.Value.Supported
    , never : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | hideSubscript : M3e.Value.Supported } msg
hideSubscript v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.FormField.hideSubscript
        (M3e.Value.toString v_)


{-| The appearance variant of the field. (default: `"outlined"`) -}
variant :
    M3e.Value.Value { filled : M3e.Value.Supported
    , outlined : M3e.Value.Supported
    }
    -> M3e.Cem.Attr.Attr { c | variant : M3e.Value.Supported } msg
variant v_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.FormField.variant
        (M3e.Value.toString v_)