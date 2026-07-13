module M3e.Raw.BottomSheetAction exposing (bottomSheetAction)

{-| Bottom layer for `<m3e-bottom-sheet-action>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, faithful DOM emission, no phantom typing. The rawest escape in the gradient.

@docs bottomSheetAction

-}

import Html


{-| The raw `<m3e-bottom-sheet-action>` element — a partial application of `Html.node`.
-}
bottomSheetAction : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
bottomSheetAction =
    Html.node "m3e-bottom-sheet-action"
