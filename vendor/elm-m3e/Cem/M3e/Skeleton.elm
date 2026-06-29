module Cem.M3e.Skeleton exposing (component, animation, shape, loaded)

{-| A visual placeholder that mimics the layout of content while it's still loading.

@docs component, animation, shape, loaded

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Json.Encode


{-| A visual placeholder that mimics the layout of content while it's still loading.

**CSS Custom Properties:**

  - `--m3e-skeleton-color`: Base fill color for the skeleton surface.
  - `--m3e-skeleton-tint-color`: Tint fill color for the skeleton surface.
  - `--m3e-skeleton-tint-opacity`: Tint Opacity applied when the skeleton animation is not pulsating.
  - `--m3e-skeleton-accent-color`: Accent color used in wave animation.
  - `--m3e-skeleton-accent-opacity`: Opacity of the accent effect in animations.
  - `--m3e-skeleton-rounded-shape`: Corner radius for the rounded skeleton shape.
  - `--m3e-skeleton-circular-shape`: Corner radius for the circular skeleton shape.
  - `--m3e-skeleton-square-shape`: Corner radius for the square skeleton shape.
  - `--m3e-skeleton-shape`: Corner radius for the skeleton shape.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-skeleton" attributes children


{-| The animation effect of the skeleton. (default: `"wave"`)
-}
animation :
    Cem.M3e.Common.Value
        { none : Cem.M3e.Common.Supported
        , pulse : Cem.M3e.Common.Supported
        , wave : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
animation =
    Cem.M3e.Common.animation


{-| The shape of the skeleton. (default: `"auto"`)
-}
shape :
    Cem.M3e.Common.Value
        { auto : Cem.M3e.Common.Supported
        , circular : Cem.M3e.Common.Supported
        , rounded : Cem.M3e.Common.Supported
        , square : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
shape =
    Cem.M3e.Common.shape


{-| Whether the content of the skeleton has been loaded. (default: `false`)
-}
loaded : Bool -> Html.Attribute msg
loaded val_ =
    Html.Attributes.property "loaded" (Json.Encode.bool val_)
