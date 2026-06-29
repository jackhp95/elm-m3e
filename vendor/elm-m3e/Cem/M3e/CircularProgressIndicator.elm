module Cem.M3e.CircularProgressIndicator exposing (component, indeterminate, maxAttr, value, variant)

{-| A circular indicator of progress and activity.

@docs component, indeterminate, maxAttr, value, variant

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Json.Encode


{-| A circular indicator of progress and activity.

**Component Info:**

  - **Extends:** `ProgressElementIndicatorBase` from `/src/progress-indicator/ProgressElementIndicatorBase`

**CSS Custom Properties:**

  - `--m3e-circular-flat-progress-indicator-diameter`: Diameter of the `flat` variant.
  - `--m3e-circular-wavy-progress-indicator-diameter`: Diameter of the `wavy` variant.
  - `--m3e-circular-wavy-progress-indicator-amplitude`: Amplitude of the `wavy` variant.
  - `--m3e-circular-wavy-progress-indicator-wavelength`: Wavelength of the `wavy` variant.
  - `--m3e-circular-progress-indicator-thickness`: Thickness of the progress indicator.
  - `--m3e-progress-indicator-track-color`: Track color of the progress indicator (background).
  - `--m3e-progress-indicator-color`: Color of the progress indicator (foreground).

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-circular-progress-indicator" attributes children


{-| Whether to show something is happening without conveying progress. (default: `false`)
-}
indeterminate : Bool -> Html.Attribute msg
indeterminate val_ =
    Html.Attributes.property "indeterminate" (Json.Encode.bool val_)


{-| The maximum progress value. (default: `100`)
-}
maxAttr : Float -> Html.Attribute msg
maxAttr val_ =
    Html.Attributes.property "max" (Json.Encode.float val_)


{-| A fractional value, between 0 and `max`, indicating progress. (default: `0`)
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| The appearance of the indicator. (default: `"flat"`)
-}
variant :
    Cem.M3e.Common.Value
        { flat : Cem.M3e.Common.Supported
        , wavy : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant
