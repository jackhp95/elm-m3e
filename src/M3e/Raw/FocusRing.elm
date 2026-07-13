module M3e.Raw.FocusRing exposing (focusRing, disabled, inward, for)

{-| Bottom layer for `<m3e-focus-ring>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs focusRing, disabled, inward, for

-}

import Html
import Html.Attributes


{-| The raw `<m3e-focus-ring>` element — a partial application of `Html.node`.
-}
focusRing : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
focusRing =
    Html.node "m3e-focus-ring"


{-| Whether the focus events will not trigger the focus ring.
Focus rings can be still controlled manually by using the `show` and `hide` methods. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    if val_ then
        Html.Attributes.attribute "disabled" ""

    else
        Html.Attributes.classList []


{-| Whether the focus ring animates inward instead of outward. (default: `false`)
-}
inward : Bool -> Html.Attribute msg
inward val_ =
    if val_ then
        Html.Attributes.attribute "inward" ""

    else
        Html.Attributes.classList []


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"
