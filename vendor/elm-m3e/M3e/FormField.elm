module M3e.FormField exposing
    ( component
    , floatLabel, hideRequiredMarker, hideSubscript
    , prefixSlot, prefixTextSlot, suffixSlot, suffixTextSlot, hintSlot, errorSlot
    )

{-| A container for form controls that applies Material Design styling and behavior.


## Component

@docs component


### Attributes

@docs floatLabel, hideRequiredMarker, hideSubscript


### Slots

@docs prefixSlot, prefixTextSlot, suffixSlot, suffixTextSlot, hintSlot, errorSlot

-}

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

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-form-field" attributes children


{-| Specifies whether the label should float always or only when necessary. (default: `"auto"`)
-}
floatLabel : String -> Html.Attribute msg
floatLabel val_ =
    Html.Attributes.attribute "float-label" val_


{-| Whether the required marker should be hidden. (default: `false`)
-}
hideRequiredMarker : Bool -> Html.Attribute msg
hideRequiredMarker val_ =
    Html.Attributes.property "hide-required-marker" (Json.Encode.bool val_)


{-| Whether subscript content is hidden. (default: `"auto"`)
-}
hideSubscript : String -> Html.Attribute msg
hideSubscript val_ =
    Html.Attributes.attribute "hide-subscript" val_


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
