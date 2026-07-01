module M3e.Cem.Html.TextOverflow exposing (textOverflow)

{-| 
@docs textOverflow
-}


import Html


{-| The raw `<m3e-text-overflow>` element — a partial application of `Html.node`. -}
textOverflow :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
textOverflow =
    Html.node "m3e-text-overflow"