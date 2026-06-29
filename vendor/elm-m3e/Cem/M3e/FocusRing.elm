module Cem.M3e.FocusRing exposing (component, disabled, inward, for)

{-| A focus ring used to depict a strong focus indicator.

@docs component, disabled, inward, for

-}

import Html
import Html.Attributes
import Json.Encode


{-| A focus ring used to depict a strong focus indicator.

**CSS Custom Properties:**

  - `--m3e-focus-ring-color`: The color of the focus ring.
  - `--m3e-focus-ring-duration`: The duration of the focus ring animation.
  - `--m3e-focus-ring-growth-factor`: The factor by which the focus ring grows.
  - `--m3e-focus-ring-thickness`: The thickness of the focus ring.
  - `--m3e-focus-ring-visibility`: The visibility of the focus ring.
  - `--m3e-focus-ring-outward-offset`: Offset of an outward focus ring.
  - `--m3e-focus-ring-inward-offset`: Offset of an inward focus ring.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-focus-ring" attributes children


{-| Whether the focus events will not trigger the focus ring.
Focus rings can be still controlled manually by using the `show` and `hide` methods. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the focus ring animates inward instead of outward. (default: `false`)
-}
inward : Bool -> Html.Attribute msg
inward val_ =
    Html.Attributes.property "inward" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_
