module M3e.InputChip exposing (avatar, icon, inputChip, removeIcon)

{-| 
@docs inputChip, avatar, icon, removeIcon
-}


import M3e.Cem.Attr
import M3e.Cem.InputChip
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-input-chip>` element (lazy IR). -}
inputChip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , disabledInteractive : M3e.Value.Supported
    , removable : M3e.Value.Supported
    , removeLabel : M3e.Value.Supported
    , value : M3e.Value.Supported
    , variant : M3e.Value.Supported
    , onRemove : M3e.Value.Supported
    , onClick : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { avatar : M3e.Value.Supported
    , icon : M3e.Value.Supported
    , removeIcon : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | inputChip : M3e.Value.Supported } msg
inputChip req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.InputChip.inputChip
                    (List.map M3e.Cem.Attr.forget erased)
                    ch
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


{-| Place content in the `avatar` slot. -}
avatar :
    M3e.Element.Element { avatar : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | avatar : M3e.Value.Supported } msg
avatar el =
    M3e.Content.slot "avatar" el


{-| Place content in the `icon` slot. -}
icon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | icon : M3e.Value.Supported } msg
icon el =
    M3e.Content.slot "icon" el


{-| Place content in the `remove-icon` slot. -}
removeIcon :
    M3e.Element.Element { icon : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | removeIcon : M3e.Value.Supported } msg
removeIcon el =
    M3e.Content.slot "remove-icon" el