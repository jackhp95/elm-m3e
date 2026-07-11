module M3e.Raw.NavRailToggle exposing (navRailToggle, for)

{-| Bottom layer for `<m3e-nav-rail-toggle>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs navRailToggle, for

-}

import Html
import Html.Attributes


{-| The raw `<m3e-nav-rail-toggle>` element — a partial application of `Html.node`.
-}
navRailToggle : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
navRailToggle =
    Html.node "m3e-nav-rail-toggle"


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"
