module M3e.Cem.Html.ActionElementBase exposing (actionElementBase)

{-| 
@docs actionElementBase
-}


import Html


{-| The raw `<div>` element — a partial application of `Html.node`. -}
actionElementBase :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
actionElementBase =
    Html.node "div"