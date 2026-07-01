module M3e.Cem.Html.ScrollContainer exposing (dividers, scrollContainer, thin)

{-| 
@docs scrollContainer, dividers, thin
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-scroll-container>` element — a partial application of `Html.node`. -}
scrollContainer :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
scrollContainer =
    Html.node "m3e-scroll-container"


{-| The dividers used to separate scrollable content. (default: `"above-below"`) -}
dividers : String -> Html.Attribute msg
dividers =
    Html.Attributes.attribute "dividers"


{-| Whether to present thin scrollbars. (default: `false`) -}
thin : Bool -> Html.Attribute msg
thin val_ =
    Html.Attributes.property "thin" (Json.Encode.bool val_)