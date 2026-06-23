module M3e.Ripple exposing
    ( component
    , radius, unbounded
    )

{-| Connects user input to screen reactions using ripples.


## Component

@docs component


### Attributes

@docs radius, unbounded

-}

import Html
import Html.Attributes
import Json.Encode


{-| Connects user input to screen reactions using ripples.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-ripple" attributes children


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
