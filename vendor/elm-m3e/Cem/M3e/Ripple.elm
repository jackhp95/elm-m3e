module Cem.M3e.Ripple exposing (component, centered, disabled, for, radius, unbounded)

{-| Connects user input to screen reactions using ripples.

@docs component, centered, disabled, for, radius, unbounded

-}

import Html
import Html.Attributes
import Json.Encode


{-| Connects user input to screen reactions using ripples.

**CSS Custom Properties:**

  - `--m3e-ripple-color`: The color of the ripple.
  - `--m3e-ripple-enter-duration`: The duration for the enter animation (expansion from point of contact).
  - `--m3e-ripple-exit-duration`: The duration for the exit animation (fade-out).
  - `--m3e-ripple-opacity`: The opacity of the ripple.
  - `--m3e-ripple-scale-factor`: The factor by which to scale the ripple.
  - `--m3e-ripple-shape`: The shape of the ripple.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-ripple" attributes children


{-| Whether the ripple always originates from the center of the element's bounds, rather
than originating from the location of the click event. (default: `false`)
-}
centered : Bool -> Html.Attribute msg
centered val_ =
    Html.Attributes.property "centered" (Json.Encode.bool val_)


{-| Whether click events will not trigger the ripple.
Ripples can be still controlled manually by using the `show` and 'hide' methods. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_


{-| The radius, in pixels, of the ripple. (default: `null`)
-}
radius : Float -> Html.Attribute msg
radius val_ =
    Html.Attributes.property "radius" (Json.Encode.float val_)


{-| Whether the ripple is visible outside the element's bounds. (default: `false`)
-}
unbounded : Bool -> Html.Attribute msg
unbounded val_ =
    Html.Attributes.property "unbounded" (Json.Encode.bool val_)
