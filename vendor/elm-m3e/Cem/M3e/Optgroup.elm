module Cem.M3e.Optgroup exposing (component, labelSlot)

{-| Groups options under a subheading.

@docs component, labelSlot

-}

import Html
import Html.Attributes


{-| Groups options under a subheading.

**Slots:**

  - `label`: Renders the label of the group.

**CSS Custom Properties:**

  - `--m3e-option-height`: The height of the group label container.
  - `--m3e-option-font-size`: The font size of the group label.
  - `--m3e-option-font-weight`: The font weight of the group label.
  - `--m3e-option-line-height`: The line height of the group label.
  - `--m3e-option-tracking`: The letter spacing of the group label.
  - `--m3e-option-padding-end`: The right padding of the label.
  - `--m3e-option-padding-start`: The left padding of the label.
  - `--m3e-option-color`: The text color of the group label.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-optgroup" attributes children


{-| Renders the label of the group.
-}
labelSlot : Html.Attribute msg
labelSlot =
    Html.Attributes.attribute "slot" "label"
