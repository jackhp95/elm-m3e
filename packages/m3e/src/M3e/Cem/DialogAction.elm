module M3e.Cem.DialogAction exposing (dialogAction, returnValue)

{-| 
@docs dialogAction, returnValue
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.DialogAction
import M3e.Value


{-| An element, nested within a clickable element, used to close a parenting dialog. -}
dialogAction :
    List (M3e.Cem.Attr.Attr { returnValue : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
dialogAction attributes children =
    M3e.Cem.Html.DialogAction.dialogAction
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The value to return from the dialog. (default: `""`) -}
returnValue :
    String -> M3e.Cem.Attr.Attr { c | returnValue : M3e.Value.Supported } msg
returnValue =
    M3e.Cem.Attr.attribute M3e.Cem.Html.DialogAction.returnValue