module M3e.Cem.Html.Accordion exposing (accordion, multi)

{-| 
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