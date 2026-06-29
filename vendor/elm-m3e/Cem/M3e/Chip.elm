module Cem.M3e.Chip exposing (component, value, variant, iconSlot, trailingIconSlot)

{-| A non-interactive chip used to convey small pieces of information.

@docs component, value, variant, iconSlot, trailingIconSlot

-}

import Cem.M3e.Common
import Html
import Html.Attributes


{-| A non-interactive chip used to convey small pieces of information.

**Slots:**

  - `icon`: Renders an icon before the chip's label.
  - `trailing-icon`: Renders an icon after the chip's label.

**CSS Custom Properties:**

  - `--m3e-chip-container-shape`: Border radius of the chip container.
  - `--m3e-chip-container-height`: Base height of the chip container before density adjustment.
  - `--m3e-chip-label-text-font-size`: Font size of the chip label text.
  - `--m3e-chip-label-text-font-weight`: Font weight of the chip label text.
  - `--m3e-chip-label-text-line-height`: Line height of the chip label text.
  - `--m3e-chip-label-text-tracking`: Letter spacing of the chip label text.
  - `--m3e-chip-label-text-color`: Label text color in default state.
  - `--m3e-chip-icon-color`: Icon color in default state.
  - `--m3e-chip-icon-size`: Font size of leading/trailing icons.
  - `--m3e-chip-spacing`: Horizontal gap between chip content elements.
  - `--m3e-chip-padding-start`: Default start padding when no icon is present.
  - `--m3e-chip-padding-end`: Default end padding when no trailing icon is present.
  - `--m3e-chip-with-icon-padding-start`: Start padding when leading icon is present.
  - `--m3e-chip-with-icon-padding-end`: End padding when trailing icon is present.
  - `--m3e-elevated-chip-container-color`: Background color for elevated variant.
  - `--m3e-elevated-chip-elevation`: Elevation level for elevated variant.
  - `--m3e-elevated-chip-hover-elevation`: Elevation level on hover.
  - `--m3e-outlined-chip-outline-thickness`: Outline thickness for outlined variant.
  - `--m3e-outlined-chip-outline-color`: Outline color for outlined variant.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-chip" attributes children


{-| A string representing the value of the chip.
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| The appearance variant of the chip. (default: `"outlined"`)
-}
variant :
    Cem.M3e.Common.Value
        { elevated : Cem.M3e.Common.Supported
        , outlined : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant


{-| Renders an icon before the chip's label.
-}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders an icon after the chip's label.
-}
trailingIconSlot : Html.Attribute msg
trailingIconSlot =
    Html.Attributes.attribute "slot" "trailing-icon"
