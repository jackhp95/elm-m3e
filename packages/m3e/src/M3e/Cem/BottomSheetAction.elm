module M3e.Cem.BottomSheetAction exposing (bottomSheetAction)

{-| 
@docs bottomSheetAction
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.BottomSheetAction
import M3e.Value


{-| An element, nested within a clickable element, used to close a parenting bottom sheet. -}
bottomSheetAction :
    List (M3e.Cem.Attr.Attr { slot : M3e.Value.Supported } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
bottomSheetAction attributes children =
    M3e.Cem.Html.BottomSheetAction.bottomSheetAction
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children