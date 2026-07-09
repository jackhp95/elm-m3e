module M3e.DialogAction exposing ( view, returnValue )

{-|
An element, nested within a clickable element, used to close a parenting dialog.

**Component Info:**
- **Extends:** `ActionElementBase`

@docs view, returnValue
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.DialogAction
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-dialog-action>` element (lazy IR). -}
view :
    List (M3e.Cem.Attr.Attr { returnValue : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | dialogAction : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.DialogAction.dialogAction
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| The value to return from the dialog. (default: `""`) -}
returnValue :
    String -> M3e.Cem.Attr.Attr { c | returnValue : M3e.Value.Supported } msg
returnValue =
    M3e.Cem.DialogAction.returnValue