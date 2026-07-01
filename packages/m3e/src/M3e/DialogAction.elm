module M3e.DialogAction exposing (child, children, dialogAction, returnValue)

{-| 
@docs dialogAction, returnValue, child, children
-}


import M3e.Cem.Attr
import M3e.Cem.DialogAction
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-dialog-action>` element (lazy IR). -}
dialogAction :
    List (M3e.Cem.Attr.Attr { returnValue : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { default : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | dialogAction : M3e.Value.Supported } msg
dialogAction attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.DialogAction.dialogAction
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Content.toNode content_)
        )


{-| The value to return from the dialog. (default: `""`) -}
returnValue :
    String -> M3e.Cem.Attr.Attr { c | returnValue : M3e.Value.Supported } msg
returnValue =
    M3e.Cem.DialogAction.returnValue


{-| Place content in the `(default)` slot. -}
child :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | default : M3e.Value.Supported } msg
child el =
    M3e.Content.slot "" el


{-| Place many elements in the default slot. -}
children :
    List (M3e.Element.Element any msg)
    -> List (M3e.Content.Content { r | default : M3e.Value.Supported } msg)
children els =
    List.map (M3e.Content.slot "") els