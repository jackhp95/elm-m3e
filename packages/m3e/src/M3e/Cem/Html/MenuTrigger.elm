module M3e.Cem.Html.MenuTrigger exposing ( menuTrigger, for )

{-|
Bottom layer for `<m3e-menu-trigger>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs menuTrigger, for
-}


import Html
import Html.Attributes


{-| The raw `<m3e-menu-trigger>` element — a partial application of `Html.node`. -}
menuTrigger : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
menuTrigger =
    Html.node "m3e-menu-trigger"


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> Html.Attribute msg
for =
    Html.Attributes.attribute "for"