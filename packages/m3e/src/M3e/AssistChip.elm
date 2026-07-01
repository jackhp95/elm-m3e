module M3e.AssistChip exposing (assistChip, icon)

{-| 
@docs assistChip, icon
-}


import M3e.Action
import M3e.Cem.AssistChip
import M3e.Cem.Attr
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-assist-chip>` element (lazy IR). -}
assistChip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg
    , action :
        M3e.Action.Action { click : M3e.Value.Supported
        , link : M3e.Value.Supported
        } msg
    }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , name : M3e.Value.Supported
    , type_ : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { icon : M3e.Value.Supported } msg)
    -> M3e.Element.Element { s | assistChip : M3e.Value.Supported } msg
assistChip req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.AssistChip.assistChip
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
            )
            (List.append
                (List.map M3e.Cem.Attr.forget (M3e.Action.toAttrs req_.action))
                (List.append [] (List.map M3e.Cem.Attr.forget attributes))
            )
            (List.append
                [ M3e.Element.toNode req_.content ]
                (List.map M3e.Content.toNode content_)
            )
        )


{-| Place content in the `icon` slot. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
icon el =
    M3e.Content.slot "icon" el