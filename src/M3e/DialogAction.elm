module M3e.DialogAction exposing (view, returnValue)

{-| An element, nested within a clickable element, used to close a parenting dialog.

**Component Info:**

  - **Extends:** `ActionElementBase`

@docs view, returnValue

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.DialogAction
import M3e.Node
import M3e.Token


{-| Build the `<m3e-dialog-action>` element (lazy IR).
-}
view :
    List
        (M3e.Html.Attr.Attr
            { returnValue : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | dialogAction : M3e.Token.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.DialogAction.dialogAction
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.map M3e.Element.toNode children)
        )


{-| The value to return from the dialog. (default: `""`)
-}
returnValue : String -> M3e.Html.Attr.Attr { c | returnValue : M3e.Token.Supported } msg
returnValue =
    M3e.Html.DialogAction.returnValue
