module M3e.Cem.Html.NavRailToggle exposing (for, navRailToggle)

{-| 
@docs navRailToggle, for
-}


import Html
import Html.Attributes


{-| The raw `<m3e-nav-rail-toggle>` element — a partial application of `Html.node`. -}
navRailToggle :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
navRailToggle =
    Html.node "m3e-nav-rail-toggle"


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"