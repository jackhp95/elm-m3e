module M3e.Cem.DialogAction exposing ( dialogAction, returnValue )

{-|
Middle layer for `<m3e-dialog-action>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.DialogAction` module for everyday use.

@docs dialogAction, returnValue
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.DialogAction
import M3e.Value


{-| An element, nested within a clickable element, used to close a parenting dialog.

**Component Info:**
- **Extends:** `ActionElementBase`
-}
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