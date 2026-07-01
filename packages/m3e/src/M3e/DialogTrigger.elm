module M3e.DialogTrigger exposing (dialogTrigger)

{-| 
@docs dialogTrigger
-}


import M3e.Cem.Attr
import M3e.Cem.DialogTrigger
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-dialog-trigger>` element (lazy IR). -}
dialogTrigger :
    List (M3e.Cem.Attr.Attr { for : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | dialogTrigger : M3e.Value.Supported } msg
dialogTrigger attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.DialogTrigger.dialogTrigger
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )