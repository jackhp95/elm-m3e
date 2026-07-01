module M3e.Tooltip exposing (tooltip)

{-| 
@docs tooltip
-}


import M3e.Cem.Attr
import M3e.Cem.Tooltip
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-tooltip>` element (lazy IR). -}
tooltip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , hideDelay : M3e.Value.Supported
    , position : M3e.Value.Supported
    , showDelay : M3e.Value.Supported
    , touchGestures : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | tooltip : M3e.Value.Supported } msg
tooltip req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Tooltip.tooltip (List.map M3e.Cem.Attr.forget erased) ch
            )
            (List.append
                []
                (List.append [] (List.map M3e.Cem.Attr.forget attributes))
            )
            (List.append
                [ M3e.Element.toNode req_.content ]
                (List.map M3e.Content.toNode content_)
            )
        )