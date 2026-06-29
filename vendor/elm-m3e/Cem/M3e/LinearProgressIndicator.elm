module Cem.M3e.LinearProgressIndicator exposing (component, bufferValue, maxAttr, mode, value, variant)

{-| A horizontal bar for indicating progress and activity.

@docs component, bufferValue, maxAttr, mode, value, variant

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Json.Encode


{-| A horizontal bar for indicating progress and activity.

**Component Info:**

  - **Extends:** `ProgressElementIndicatorBase` from `/src/progress-indicator/ProgressElementIndicatorBase`

**CSS Custom Properties:**

  - `--m3e-linear-progress-indicator-thickness`: Thickness (height) of the progress bar.
  - `--m3e-linear-progress-indicator-shape`: Border radius of the progress bar.
  - `--m3e-progress-indicator-track-color`: Track color of the progress bar (background/buffer).
  - `--m3e-progress-indicator-color`: Color of the progress indicator (foreground).
  - `--m3e-linear-wavy-progress-indicator-amplitude`: Amplitude of the `wavy` variant.
  - `--m3e-linear-wavy-progress-indicator-wavelength`: Wavelength of the `wavy` variant.
  - `--m3e-linear-wavy-indeterminate-progress-indicator-wavelength`: Wavelength of the indeterminate/query `wavy` variant.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-linear-progress-indicator" attributes children


{-| A fractional value, between 0 and `max`, indicating buffer progress. (default: `0`)
-}
bufferValue : Float -> Html.Attribute msg
bufferValue val_ =
    Html.Attributes.property "buffer-value" (Json.Encode.float val_)


{-| The maximum progress value. (default: `100`)
-}
maxAttr : Float -> Html.Attribute msg
maxAttr val_ =
    Html.Attributes.property "max" (Json.Encode.float val_)


{-| The mode of the progress bar. (default: `"determinate"`)
-}
mode :
    Cem.M3e.Common.Value
        { buffer : Cem.M3e.Common.Supported
        , determinate : Cem.M3e.Common.Supported
        , indeterminate : Cem.M3e.Common.Supported
        , query : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
mode =
    Cem.M3e.Common.mode


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
