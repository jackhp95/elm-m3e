module Cem.M3e.FormField exposing
    ( component, floatLabel, hideRequiredMarker, hideSubscript, variant, prefixSlot
    , prefixTextSlot, suffixSlot, suffixTextSlot, hintSlot, errorSlot
    )

{-| A container for form controls that applies Material Design styling and behavior.

@docs component, floatLabel, hideRequiredMarker, hideSubscript, variant, prefixSlot
@docs prefixTextSlot, suffixSlot, suffixTextSlot, hintSlot, errorSlot

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Json.Encode


{-| A container for form controls that applies Material Design styling and behavior.

**Slots:**

  - `prefix`: Renders content before the fields's control.
  - `prefix-text`: Renders text before the fields's control.
  - `suffix`: Renders content after the fields's control.
  - `suffix-text`: Renders text after the fields's control.
  - `hint`: Renders hint text in the fields's subscript, when the control is valid.
  - `error`: Renders error text in the fields's subscript, when the control is invalid.

**CSS Custom Properties:**

  - `--m3e-form-field-font-size`: Font size for the form field container text.
  - `--m3e-form-field-font-weight`: Font weight for the form field container text.
  - `--m3e-form-field-line-height`: Line height for the form field container text.
  - `--m3e-form-field-tracking`: Letter spacing for the form field container text.
  - `--m3e-form-field-label-font-size`: Font size for the floating label.
  - `--m3e-form-field-label-font-weight`: Font weight for the floating label.
  - `--m3e-form-field-label-line-height`: Line height for the floating label.
  - `--m3e-form-field-label-tracking`: Letter spacing for the floating label.
  - `--m3e-form-field-subscript-font-size`: Font size for hint and error text.
  - `--m3e-form-field-subscript-font-weight`: Font weight for hint and error text.
  - `--m3e-form-field-subscript-line-height`: Line height for hint and error text.
  - `--m3e-form-field-subscript-tracking`: Letter spacing for hint and error text.
  - `--m3e-form-field-color`: Text color for the form field container.
  - `--m3e-form-field-subscript-color`: Color for hint and error text.
  - `--m3e-form-field-invalid-color`: Color used when the control is invalid.
  - `--m3e-form-field-focused-outline-color`: Outline color when focused.
  - `--m3e-form-field-focused-color`: Label color when focused.
  - `--m3e-form-field-outline-color`: Outline color in outlined variant.
  - `--m3e-form-field-container-color`: Background color in filled variant.
  - `--m3e-form-field-hover-container-color`: Hover background color in filled variant.
  - `--m3e-form-field-width`: Width of the form field container.
  - `--m3e-form-field-icon-size`: Size of prefix and suffix icons.
  - `--m3e-outlined-form-field-container-shape`: Corner radius for outlined container.
  - `--m3e-form-field-container-shape`: Corner radius for filled container.
  - `--m3e-form-field-hover-container-opacity`: Opacity for hover background in filled variant.
  - `--m3e-form-field-disabled-opacity`: Opacity for disabled text.
  - `--m3e-form-field-disabled-container-opacity`: Opacity for disabled container background.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-form-field" attributes children


{-| Specifies whether the label should float always or only when necessary. (default: `"auto"`)
-}
floatLabel :
    Cem.M3e.Common.Value
        { always : Cem.M3e.Common.Supported
        , auto : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
floatLabel =
    Cem.M3e.Common.floatLabel


{-| Whether the required marker should be hidden. (default: `false`)
-}
hideRequiredMarker : Bool -> Html.Attribute msg
hideRequiredMarker val_ =
    Html.Attributes.property "hide-required-marker" (Json.Encode.bool val_)


{-| Whether subscript content is hidden. (default: `"auto"`)
-}
hideSubscript :
    Cem.M3e.Common.Value
        { always : Cem.M3e.Common.Supported
        , auto : Cem.M3e.Common.Supported
        , never : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
hideSubscript =
    Cem.M3e.Common.hideSubscript


{-| The appearance variant of the field. (default: `"outlined"`)
-}
variant :
    Cem.M3e.Common.Value
        { filled : Cem.M3e.Common.Supported
        , outlined : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant


{-| Renders content before the fields's control.
-}
prefixSlot : Html.Attribute msg
prefixSlot =
    Html.Attributes.attribute "slot" "prefix"


{-| Renders text before the fields's control.
-}
prefixTextSlot : Html.Attribute msg
prefixTextSlot =
    Html.Attributes.attribute "slot" "prefix-text"


{-| Renders content after the fields's control.
-}
suffixSlot : Html.Attribute msg
suffixSlot =
    Html.Attributes.attribute "slot" "suffix"


{-| Renders text after the fields's control.
-}
suffixTextSlot : Html.Attribute msg
suffixTextSlot =
    Html.Attributes.attribute "slot" "suffix-text"


{-| Renders hint text in the fields's subscript, when the control is valid.
-}
hintSlot : Html.Attribute msg
hintSlot =
    Html.Attributes.attribute "slot" "hint"


{-| Renders error text in the fields's subscript, when the control is invalid.
-}
errorSlot : Html.Attribute msg
errorSlot =
    Html.Attributes.attribute "slot" "error"
