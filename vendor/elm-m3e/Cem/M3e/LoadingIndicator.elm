module Cem.M3e.LoadingIndicator exposing (component, variant)

{-| Shows indeterminate progress for a short wait time.

@docs component, variant

-}

import Cem.M3e.Common
import Html


{-| Shows indeterminate progress for a short wait time.

**CSS Custom Properties:**

  - `--m3e-loading-indicator-active-indicator-color`: Uncontained active indicator color.
  - `--m3e-loading-indicator-contained-active-indicator-color`: Contained active indicator color.
  - `--m3e-loading-indicator-contained-container-color`: Contained container (background) color.
  - `--m3e-loading-indicator-active-indicator-size`: Size of the active indicator.
  - `--m3e-loading-indicator-container-shape`: Container shape.
  - `--m3e-loading-indicator-container-size`: Container size.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-loading-indicator" attributes children


{-| The appearance variant of the indicator. (default: `"uncontained"`)
-}
variant :
    Cem.M3e.Common.Value
        { contained : Cem.M3e.Common.Supported
        , uncontained : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant
