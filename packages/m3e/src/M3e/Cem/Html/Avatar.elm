module M3e.Cem.Html.Avatar exposing (avatar)

{-| 
@docs avatar
-}


import Html


{-| The raw `<m3e-avatar>` element — a partial application of `Html.node`. -}
avatar : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
avatar =
    Html.node "m3e-avatar"