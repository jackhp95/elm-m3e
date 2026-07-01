module M3e.Cem.Html.BottomSheetAction exposing (bottomSheetAction)

{-| 
@docs bottomSheetAction
-}


import Html


{-| The raw `<m3e-bottom-sheet-action>` element — a partial application of `Html.node`. -}
bottomSheetAction :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
bottomSheetAction =
    Html.node "m3e-bottom-sheet-action"