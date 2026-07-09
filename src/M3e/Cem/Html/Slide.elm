module M3e.Cem.Html.Slide exposing ( slide, selectedIndex )

{-|
Bottom layer for `<m3e-slide>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs slide, selectedIndex
-}


import Html
import Html.Attributes


{-| The raw `<m3e-slide>` element — a partial application of `Html.node`. -}
slide : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
slide =
    Html.node "m3e-slide"


{-| The zero-based index of the visible item. (default: `null`) -}
selectedIndex : Float -> Html.Attribute msg
selectedIndex val_ =
    Html.Attributes.attribute "selected-index" (String.fromFloat val_)