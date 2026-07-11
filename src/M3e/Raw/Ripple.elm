module M3e.Raw.Ripple exposing (ripple, centered, disabled, for, radius, unbounded)

{-| Bottom layer for `<m3e-ripple>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs ripple, centered, disabled, for, radius, unbounded

-}

import Html
import Html.Attributes


{-| The raw `<m3e-ripple>` element — a partial application of `Html.node`.
-}
ripple : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
ripple =
    Html.node "m3e-ripple"


{-| Whether the ripple always originates from the center of the element's bounds, rather
than originating from the location of the click event. (default: `false`)
-}
centered : Bool -> Html.Attribute msg
centered val_ =
    if val_ then
        Html.Attributes.attribute "centered" ""

    else
        Html.Attributes.classList []


{-| Whether click events will not trigger the ripple.
Ripples can be still controlled manually by using the `show` and 'hide' methods. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""

    else
        Html.Attributes.classList []


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"


{-| The radius, in pixels, of the ripple. (default: `null`)
-}
radius : Float -> Html.Attribute msg
radius val_ =
    Html.Attributes.attribute "radius" (String.fromFloat val_)


{-| Whether the ripple is visible outside the element's bounds. (default: `false`)
-}
unbounded : Bool -> Html.Attribute msg
unbounded val_ =
    if val_ then
        Html.Attributes.attribute "unbounded" ""

    else
        Html.Attributes.classList []
