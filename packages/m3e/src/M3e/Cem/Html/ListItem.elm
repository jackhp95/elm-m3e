module M3e.Cem.Html.ListItem exposing (listItem)

{-| 
@docs listItem
-}


import Html


{-| The raw `<m3e-list-item>` element — a partial application of `Html.node`. -}
listItem : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
listItem =
    Html.node "m3e-list-item"