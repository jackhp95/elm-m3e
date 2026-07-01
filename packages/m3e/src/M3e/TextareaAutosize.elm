module M3e.TextareaAutosize exposing (disabled, for, maxRows, minRows, textareaAutosize)

{-| 
@docs textareaAutosize, disabled, for, maxRows, minRows
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


{-| Whether auto-sizing is disabled. (default: `false`) -}
disabled : Bool -> M3e.Cem.Attr.Attr { c | disabled : M3e.Value.Supported } msg
disabled =
    M3e.Cem.TextareaAutosize.disabled


{-| The identifier of the interactive control to which this element is attached. (default: `null`) -}
for : String -> M3e.Cem.Attr.Attr { c | for : M3e.Value.Supported } msg
for =
    M3e.Cem.TextareaAutosize.for


{-| The maximum amount of rows in the `textarea`. (default: `0`) -}
maxRows : Float -> M3e.Cem.Attr.Attr { c | maxRows : M3e.Value.Supported } msg
maxRows =
    M3e.Cem.TextareaAutosize.maxRows


{-| The minimum amount of rows in the `textarea`. (default: `0`) -}
minRows : Float -> M3e.Cem.Attr.Attr { c | minRows : M3e.Value.Supported } msg
minRows =
    M3e.Cem.TextareaAutosize.minRows