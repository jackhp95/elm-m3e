module Cem.M3e.Ripple exposing (centered, component, disabled, for, radius, unbounded)

{-| 
Connects user input to screen reactions using ripples.

## Component

@docs component

### Attributes

@docs centered, disabled, for, radius, unbounded
-}


import Html
import Html.Attributes
import Json.Encode


{-| Connects user input to screen reactions using ripples. -}
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


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_


{-| The radius, in pixels, of the ripple. (default: `null`) -}
radius : Float -> Html.Attribute msg
radius val_ =
    Html.Attributes.property "radius" (Json.Encode.float val_)


{-| Whether the ripple is visible outside the element's bounds. (default: `false`) -}
unbounded : Bool -> Html.Attribute msg
unbounded val_ =
    Html.Attributes.property "unbounded" (Json.Encode.bool val_)