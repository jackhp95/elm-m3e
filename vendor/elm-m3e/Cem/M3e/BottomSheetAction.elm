module Cem.M3e.BottomSheetAction exposing (component)

{-| An element, nested within a clickable element, used to close a parenting bottom sheet.


## Component

@docs component

-}

import Html


{-| An element, nested within a clickable element, used to close a parenting bottom sheet.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-bottom-sheet-action" attributes children
