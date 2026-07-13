module M3e.Html.DialogAction exposing (dialogAction, returnValue)

{-| Middle layer for `<m3e-dialog-action>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.DialogAction` module for everyday use.

@docs dialogAction, returnValue

-}

import Html
import M3e.Raw.DialogAction
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| An element, nested within a clickable element, used to close a parenting dialog.

**Component Info:**

  - **Extends:** `ActionElementBase`

-}
dialogAction :
    List
        (Markup.Html.Attr.Attr
            { returnValue : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
dialogAction attributes children =
    M3e.Raw.DialogAction.dialogAction
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


{-| The value to return from the dialog. (default: `""`)
-}
returnValue :
    String
    -> Markup.Html.Attr.Attr { c | returnValue : M3e.Token.Supported } msg
returnValue =
    Markup.Html.Attr.Internal.attribute M3e.Raw.DialogAction.returnValue
