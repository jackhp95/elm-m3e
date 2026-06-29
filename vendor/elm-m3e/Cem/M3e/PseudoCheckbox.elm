module Cem.M3e.PseudoCheckbox exposing (component, checked, disabled, indeterminate)

{-| An element which looks like a checkbox.

@docs component, checked, disabled, indeterminate

-}

import Html
import Html.Attributes
import Json.Encode


{-| An element which looks like a checkbox.

**CSS Custom Properties:**

  - `--m3e-checkbox-icon-size`: Size of the checkbox icon.
  - `--m3e-checkbox-container-shape`: Border radius of the checkbox container.
  - `--m3e-checkbox-unselected-outline-thickness`: Outline thickness for unselected state.
  - `--m3e-checkbox-unselected-outline-color`: Outline color for unselected state.
  - `--m3e-checkbox-selected-container-color`: Background color for selected state.
  - `--m3e-checkbox-selected-icon-color`: Icon color for selected state.
  - `--m3e-checkbox-unselected-disabled-outline-color`: Outline color for unselected disabled state.
  - `--m3e-checkbox-unselected-disabled-outline-opacity`: Outline opacity for unselected disabled state.
  - `--m3e-checkbox-selected-disabled-container-color`: Background color for selected disabled state.
  - `--m3e-checkbox-selected-disabled-container-opacity`: Background opacity for selected disabled state.
  - `--m3e-checkbox-selected-disabled-icon-color`: Icon color for selected disabled state.
  - `--m3e-checkbox-selected-disabled-icon-opacity`: Icon opacity for selected disabled state.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-pseudo-checkbox" attributes children


{-| A value indicating whether the element is checked. (default: `false`)
-}
checked : Bool -> Html.Attribute msg
checked =
    Html.Attributes.checked


{-| A value indicating whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| A value indicating whether the element's checked state is indeterminate. (default: `false`)
-}
indeterminate : Bool -> Html.Attribute msg
indeterminate val_ =
    Html.Attributes.property "indeterminate" (Json.Encode.bool val_)
