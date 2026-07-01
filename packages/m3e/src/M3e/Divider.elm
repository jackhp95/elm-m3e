module M3e.Divider exposing (divider)

{-| 
@docs divider
-}


import M3e.Cem.Attr
import M3e.Cem.Divider
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-divider>` element (lazy IR). -}
divider :
    List (M3e.Cem.Attr.Attr { inset : M3e.Value.Supported
    , insetStart : M3e.Value.Supported
    , insetEnd : M3e.Value.Supported
    , vertical : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Element.Element child msg)
    -> M3e.Element.Element { s | divider : M3e.Value.Supported } msg
divider attributes children =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Divider.divider (List.map M3e.Cem.Attr.forget erased) ch
            )
            (List.map M3e.Cem.Attr.forget attributes)
            (List.map M3e.Element.toNode children)
        )