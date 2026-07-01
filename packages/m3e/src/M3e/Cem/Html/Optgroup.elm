module M3e.Cem.Html.Optgroup exposing (optgroup)

{-| 
@docs optgroup
-}


import Html


{-| The raw `<m3e-optgroup>` element — a partial application of `Html.node`. -}
optgroup : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
optgroup =
    Html.node "m3e-optgroup"