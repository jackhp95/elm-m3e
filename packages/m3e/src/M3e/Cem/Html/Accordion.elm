module M3e.Cem.Html.Accordion exposing ( accordion, multi )

{-|
Bottom layer for `<m3e-accordion>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs accordion, multi
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-accordion>` element — a partial application of `Html.node`. -}
accordion : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
accordion =
    Html.node "m3e-accordion"


{-| Whether multiple expansion panels can be open at the same time. (default: `false`) -}
multi : Bool -> Html.Attribute msg
multi val_ =
    Html.Attributes.property "multi" (Json.Encode.bool val_)