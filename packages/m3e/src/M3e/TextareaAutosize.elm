module M3e.TextareaAutosize exposing (textareaAutosize)

{-| 
@docs textareaAutosize
-}


import M3e.Cem.Attr
import M3e.Cem.TextareaAutosize
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-textarea-autosize>` element (lazy IR). -}
textareaAutosize :
    List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , maxRows : M3e.Value.Supported
    , minRows : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | textareaAutosize : M3e.Value.Supported } msg
textareaAutosize attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.TextareaAutosize.textareaAutosize
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )