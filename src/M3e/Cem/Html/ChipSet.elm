module M3e.Cem.Html.ChipSet exposing ( chipSet, vertical )

{-|
Bottom layer for `<m3e-chip-set>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs chipSet, vertical
-}


import Html
import Html.Attributes


{-| The raw `<m3e-chip-set>` element, with the library's fixed host attribute (role="group") stamped ahead of the caller's attributes. -}
chipSet : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
chipSet attributes children =
    Html.node
        "m3e-chip-set"
        (Html.Attributes.attribute "role" "group" :: attributes)
        children


{-| Whether the element is oriented vertically. (default: `false`) -}
vertical : Bool -> Html.Attribute msg
vertical val_ =
    if val_ then
        Html.Attributes.attribute "vertical" ""
    
    else
        Html.Attributes.classList []