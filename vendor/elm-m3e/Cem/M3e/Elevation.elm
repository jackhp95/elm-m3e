module Cem.M3e.Elevation exposing (component, disabled, for, level)

{-| Visually depicts elevation using a shadow.

@docs component, disabled, for, level

-}

import Html
import Html.Attributes
import Json.Encode


{-| Visually depicts elevation using a shadow.

**CSS Custom Properties:**

  - `--m3e-elevation-color`: Color used to depict elevation.
  - `--m3e-elevation-lift-duration`: Duration when lifting.
  - `--m3e-elevation-lift-easing`: Easing curve when lifting.
  - `--m3e-elevation-settle-duration`: Duration when settling.
  - `--m3e-elevation-settle-easing`: Easing curve when settling.
  - `--m3e-elevation-level`: Elevation when resting (box-shadow).
  - `--m3e-elevation-hover-level`: Elevation on hover (box-shadow).
  - `--m3e-elevation-focus-level`: Elevation on focus (box-shadow).
  - `--m3e-elevation-pressed-level`: Elevation on pressed (box-shadow).

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-elevation" attributes children


{-| Whether hover and press events will not trigger changes in elevation, when attached to an interactive element. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_


{-| The level at which to visually depict elevation. (default: `null`)
-}
level : String -> Html.Attribute msg
level val_ =
    Html.Attributes.attribute "level" val_
