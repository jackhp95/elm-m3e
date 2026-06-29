module Cem.M3e.List exposing (component, variant)

{-| A list of items.

@docs component, variant

-}

import Cem.M3e.Common
import Html


{-| A list of items.

**CSS Custom Properties:**

  - `--m3e-list-divider-inset-start-size`: Start inset for dividers within the list.
  - `--m3e-list-divider-inset-end-size`: End inset for dividers within the list.
  - `--m3e-segmented-list-segment-gap`: Gap between list items in segmented variant.
  - `--m3e-segmented-list-container-shape`: Border radius of the segmented list container.
  - `--m3e-segmented-list-item-container-color`: Background color of items in segmented variant.
  - `--m3e-segmented-list-item-disabled-container-color`: Background color of disabled items in segmented variant.
  - `--m3e-segmented-list-item-container-shape`: Border radius of items in segmented variant.
  - `--m3e-segmented-list-item-hover-container-shape`: Border radius of items in segmented variant on hover.
  - `--m3e-segmented-list-item-focus-container-shape`: Border radius of items in segmented variant on focus.
  - `--m3e-segmented-list-item-selected-container-shape`: Border radius of items in segmented variant when selected.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-list" attributes children


{-| The appearance variant of the list. (default: `"standard"`)
-}
variant :
    Cem.M3e.Common.Value
        { segmented : Cem.M3e.Common.Supported
        , standard : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant
