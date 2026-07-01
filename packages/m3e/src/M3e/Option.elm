module M3e.Option exposing (option)

{-| 
@docs option
-}


import M3e.Cem.Attr
import M3e.Cem.Option
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-option>` element (lazy IR). -}
option :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disableHighlight : M3e.Value.Supported
    , highlightMode : M3e.Value.Supported
    , selected : M3e.Value.Supported
    , term : M3e.Value.Supported
    , value : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | option : M3e.Value.Supported } msg
option req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.Option.option (List.map M3e.Cem.Attr.forget erased) ch
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