module Cem.M3e.ScrollContainer exposing (component, dividers, thin)

{-| A vertically oriented content container which presents dividers above and below content when scrolled.

@docs component, dividers, thin

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Json.Encode


{-| A vertically oriented content container which presents dividers above and below content when scrolled.

**CSS Custom Properties:**

  - `--m3e-divider-thickness`: Thickness of the divider lines above and below content.
  - `--m3e-divider-color`: Color of the divider lines when visible.
  - `--m3e-focus-ring-color`: Color of the focus ring outline.
  - `--m3e-focus-ring-thickness`: Thickness of the focus ring outline.
  - `--m3e-focus-ring-factor`: Animation factor for focus ring thickness.
  - `--m3e-focus-ring-duration`: Duration of the focus ring animation.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-scroll-container" attributes children


{-| The dividers used to separate scrollable content. (default: `"above-below"`)
-}
dividers :
    Cem.M3e.Common.Value
        { above : Cem.M3e.Common.Supported
        , aboveBelow : Cem.M3e.Common.Supported
        , below : Cem.M3e.Common.Supported
        , none : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
dividers =
    Cem.M3e.Common.dividers


{-| Whether to present thin scrollbars. (default: `false`)
-}
thin : Bool -> Html.Attribute msg
thin val_ =
    Html.Attributes.property "thin" (Json.Encode.bool val_)
