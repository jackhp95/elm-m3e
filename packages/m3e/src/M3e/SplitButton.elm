module M3e.SplitButton exposing (splitButton)

{-| 
@docs splitButton
-}


import M3e.Cem.Attr
import M3e.Cem.SplitButton
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-split-button>` element (lazy IR). -}
splitButton :
    { leadingButton : M3e.Element.Element { button : M3e.Value.Supported } msg
    , trailingButton :
        M3e.Element.Element { iconButton : M3e.Value.Supported } msg
    }
    -> List (M3e.Cem.Attr.Attr { variant : M3e.Value.Supported
    , size : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | splitButton : M3e.Value.Supported } msg
splitButton req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.SplitButton.splitButton
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.append
                []
                (List.append [] (List.map M3e.Cem.Attr.forget attributes))
            )
            (List.append
                [ M3e.Element.toNode
                    (M3e.Element.withSlot "leading-button" req_.leadingButton)
                , M3e.Element.toNode
                    (M3e.Element.withSlot "trailing-button" req_.trailingButton)
                ]
                (List.map M3e.Content.toNode content_)
            )
        )