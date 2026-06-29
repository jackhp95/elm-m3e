module Cem.M3e.ThemeIcon exposing (component, color, scheme, variant, isdark)

{-| An icon that visually presents a preview of a theme.

@docs component, color, scheme, variant, isdark

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Json.Encode


{-| An icon that visually presents a preview of a theme.

**CSS Custom Properties:**

  - `--m3e-theme-icon-size`: Size of the theme icon.
  - `--m3e-theme-icon-shape`: Border radius of the icon container.
  - `--m3e-theme-icon-outline-color`: Outline stroke color of the icon border.
  - `--m3e-theme-icon-outline-opacity`: Opacity percentage applied to the outline color.
  - `--m3e-theme-icon-container-color`: Fill color for the container layer of the previewed theme.
  - `--m3e-theme-icon-color`: Fill color for the primary layer of the previewed theme.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-theme-icon" attributes children


{-| The hex color of the theme to preview (default: `"#6750A4"`)
-}
color : String -> Html.Attribute msg
color val_ =
    Html.Attributes.attribute "color" val_


{-| The color scheme of the theme. (default: `"auto"`)
-}
scheme :
    Cem.M3e.Common.Value
        { auto : Cem.M3e.Common.Supported
        , dark : Cem.M3e.Common.Supported
        , light : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
scheme =
    Cem.M3e.Common.scheme


{-| The color variant of the theme. (default: `"neutral"`)
-}
variant :
    Cem.M3e.Common.Value
        { content : Cem.M3e.Common.Supported
        , expressive : Cem.M3e.Common.Supported
        , fidelity : Cem.M3e.Common.Supported
        , fruitSalad : Cem.M3e.Common.Supported
        , monochrome : Cem.M3e.Common.Supported
        , neutral : Cem.M3e.Common.Supported
        , rainbow : Cem.M3e.Common.Supported
        , tonalSpot : Cem.M3e.Common.Supported
        , vibrant : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant


{-| Whether a dark theme is applied.
-}
isdark : Bool -> Html.Attribute msg
isdark val_ =
    Html.Attributes.property "isDark" (Json.Encode.bool val_)
