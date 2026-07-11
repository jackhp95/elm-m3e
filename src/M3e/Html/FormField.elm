module M3e.Html.FormField exposing (formField, floatLabel, hideRequiredMarker, hideSubscript, variant)

{-| Middle layer for `<m3e-form-field>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.FormField` module for everyday use.

@docs formField, floatLabel, hideRequiredMarker, hideSubscript, variant

-}

import Html
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.FormField
import M3e.Token


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

-}
formField :
    List
        (M3e.Html.Attr.Attr
            { floatLabel : M3e.Token.Supported
            , hideRequiredMarker : M3e.Token.Supported
            , hideSubscript : M3e.Token.Supported
            , variant : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
formField attributes children =
    M3e.Raw.FormField.formField
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| Specifies whether the label should float always or only when necessary. (default: `"auto"`)
-}
floatLabel :
    M3e.Token.Value { always : M3e.Token.Supported, auto : M3e.Token.Supported }
    -> M3e.Html.Attr.Attr { c | floatLabel : M3e.Token.Supported } msg
floatLabel v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.FormField.floatLabel
        (M3e.Token.toString v_)


{-| Whether the required marker should be hidden. (default: `false`)
-}
hideRequiredMarker :
    Bool
    -> M3e.Html.Attr.Attr { c | hideRequiredMarker : M3e.Token.Supported } msg
hideRequiredMarker =
    M3e.Html.Attr.Internal.attribute M3e.Raw.FormField.hideRequiredMarker


{-| Whether subscript content is hidden. (default: `"auto"`)
-}
hideSubscript :
    M3e.Token.Value
        { always : M3e.Token.Supported
        , auto : M3e.Token.Supported
        , never : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | hideSubscript : M3e.Token.Supported } msg
hideSubscript v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.FormField.hideSubscript
        (M3e.Token.toString v_)


{-| The appearance variant of the field. (default: `"outlined"`)
-}
variant :
    M3e.Token.Value
        { filled : M3e.Token.Supported
        , outlined : M3e.Token.Supported
        }
    -> M3e.Html.Attr.Attr { c | variant : M3e.Token.Supported } msg
variant v_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.FormField.variant
        (M3e.Token.toString v_)
