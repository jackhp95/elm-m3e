module M3e.DialogAction exposing (view, returnValue)

{-| An element, nested within a clickable element, used to close a parenting dialog.

**Component Info:**

  - **Extends:** `ActionElementBase`

@docs view, returnValue

-}

import M3e.Html.DialogAction
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Node


{-| Build the `<m3e-dialog-action>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { returnValue : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element any msg)
    -> Markup.Element.Element { s | dialogAction : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.DialogAction.dialogAction
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| The value to return from the dialog. (default: `""`)
-}
returnValue :
    String
    -> Markup.Html.Attr.Attr { c | returnValue : M3e.Token.Supported } msg
returnValue =
    M3e.Html.DialogAction.returnValue
