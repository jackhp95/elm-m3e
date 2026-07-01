module M3e.TocItem exposing (tocItem)

{-| 
@docs tocItem
-}


import M3e.Cem.Attr
import M3e.Cem.TocItem
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-toc-item>` element (lazy IR). -}
tocItem :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | tocItem : M3e.Value.Supported } msg
tocItem req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.TocItem.tocItem (List.map M3e.Cem.Attr.forget erased) ch
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