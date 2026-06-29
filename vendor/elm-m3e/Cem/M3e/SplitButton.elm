module Cem.M3e.SplitButton exposing (component, variant, size, leadingButtonSlot, trailingButtonSlot)

{-| A button used to show an action with a menu of related actions.

@docs component, variant, size, leadingButtonSlot, trailingButtonSlot

-}

import Cem.M3e.Common
import Html
import Html.Attributes


{-| A button used to show an action with a menu of related actions.

**Slots:**

  - `leading-button`: The leading button used to perform the primary action.
  - `trailing-button`: The trailing icon button used to open a menu of related actions.

**CSS Custom Properties:**

  - `--m3e-split-button-extra-small-trailing-button-unselected-leading-space`: Leading space for the trailing button (extra-small, unselected).
  - `--m3e-split-button-extra-small-trailing-button-unselected-trailing-space`: Trailing space for the trailing button (extra-small, unselected).
  - `--m3e-split-button-small-trailing-button-unselected-leading-space`: Leading space for the trailing button (small, unselected).
  - `--m3e-split-button-small-trailing-button-unselected-trailing-space`: Trailing space for the trailing button (small, unselected).
  - `--m3e-split-button-medium-trailing-button-unselected-leading-space`: Leading space for the trailing button (medium, unselected).
  - `--m3e-split-button-medium-trailing-button-unselected-trailing-space`: Trailing space for the trailing button (medium, unselected).
  - `--m3e-split-button-large-trailing-button-unselected-leading-space`: Leading space for the trailing button (large, unselected).
  - `--m3e-split-button-large-trailing-button-unselected-trailing-space`: Trailing space for the trailing button (large, unselected).
  - `--m3e-split-button-extra-large-trailing-button-unselected-leading-space`: Leading space for the trailing button (extra-large, unselected).
  - `--m3e-split-button-extra-large-trailing-button-unselected-trailing-space`: Trailing space for the trailing button (extra-large, unselected).
  - `--m3e-split-button-extra-small-trailing-button-selected-leading-space`: Leading space for the trailing button (extra-small, selected).
  - `--m3e-split-button-extra-small-trailing-button-selected-trailing-space`: Trailing space for the trailing button (extra-small, selected).
  - `--m3e-split-button-small-trailing-button-selected-leading-space`: Leading space for the trailing button (small, selected).
  - `--m3e-split-button-small-trailing-button-selected-trailing-space`: Trailing space for the trailing button (small, selected).
  - `--m3e-split-button-medium-trailing-button-selected-leading-space`: Leading space for the trailing button (medium, selected).
  - `--m3e-split-button-medium-trailing-button-selected-trailing-space`: Trailing space for the trailing button (medium, selected).
  - `--m3e-split-button-large-trailing-button-selected-leading-space`: Leading space for the trailing button (large, selected).
  - `--m3e-split-button-large-trailing-button-selected-trailing-space`: Trailing space for the trailing button (large, selected).
  - `--m3e-split-button-extra-large-trailing-button-selected-leading-space`: Leading space for the trailing button (extra-large, selected).
  - `--m3e-split-button-extra-large-trailing-button-selected-trailing-space`: Trailing space for the trailing button (extra-large, selected).
  - `--m3e-split-button-extra-small-inner-corner-size`: Inner corner size for the leading/trailing button (extra-small).
  - `--m3e-split-button-small-inner-corner-size`: Inner corner size for the leading/trailing button (small).
  - `--m3e-split-button-medium-inner-corner-size`: Inner corner size for the leading/trailing button (medium).
  - `--m3e-split-button-large-inner-corner-size`: Inner corner size for the leading/trailing button (large).
  - `--m3e-split-button-extra-large-inner-corner-size`: Inner corner size for the leading/trailing button (extra-large).
  - `--m3e-split-button-extra-small-inner-corner-hover-size`: Inner corner size on hover (extra-small).
  - `--m3e-split-button-small-inner-corner-hover-size`: Inner corner size on hover (small).
  - `--m3e-split-button-medium-inner-corner-hover-size`: Inner corner size on hover (medium).
  - `--m3e-split-button-large-inner-corner-hover-size`: Inner corner size on hover (large).
  - `--m3e-split-button-extra-large-inner-corner-hover-size`: Inner corner size on hover (extra-large).
  - `--m3e-split-button-extra-small-inner-corner-pressed-size`: Inner corner size on press (extra-small).
  - `--m3e-split-button-small-inner-corner-pressed-size`: Inner corner size on press (small).
  - `--m3e-split-button-medium-inner-corner-pressed-size`: Inner corner size on press (medium).
  - `--m3e-split-button-large-inner-corner-pressed-size`: Inner corner size on press (large).
  - `--m3e-split-button-extra-large-inner-corner-pressed-size`: Inner corner size on press (extra-large).
  - `--m3e-split-button-extra-small-between-spacing`: Spacing between leading and trailing buttons (extra-small).
  - `--m3e-split-button-small-between-spacing`: Spacing between leading and trailing buttons (small).
  - `--m3e-split-button-medium-between-spacing`: Spacing between leading and trailing buttons (medium).
  - `--m3e-split-button-large-between-spacing`: Spacing between leading and trailing buttons (large).
  - `--m3e-split-button-extra-large-between-spacing`: Spacing between leading and trailing buttons (extra-large).

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-split-button" attributes children


{-| The appearance variant of the button. (default: `"filled"`)
-}
variant :
    Cem.M3e.Common.Value
        { elevated : Cem.M3e.Common.Supported
        , filled : Cem.M3e.Common.Supported
        , outlined : Cem.M3e.Common.Supported
        , tonal : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant


{-| The size of the button. (default: `"small"`)
-}
size :
    Cem.M3e.Common.Value
        { extraLarge : Cem.M3e.Common.Supported
        , extraSmall : Cem.M3e.Common.Supported
        , large : Cem.M3e.Common.Supported
        , medium : Cem.M3e.Common.Supported
        , small : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
size =
    Cem.M3e.Common.size


{-| The leading button used to perform the primary action.
-}
leadingButtonSlot : Html.Attribute msg
leadingButtonSlot =
    Html.Attributes.attribute "slot" "leading-button"


{-| The trailing icon button used to open a menu of related actions.
-}
trailingButtonSlot : Html.Attribute msg
trailingButtonSlot =
    Html.Attributes.attribute "slot" "trailing-button"
