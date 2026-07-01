module M3e.RichTooltip exposing (actions, richTooltip, subhead)

{-| 
@docs richTooltip, subhead, actions
-}


import M3e.Cem.Attr
import M3e.Cem.RichTooltip
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-rich-tooltip>` element (lazy IR). -}
richTooltip :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { disabled : M3e.Value.Supported
    , for : M3e.Value.Supported
    , hideDelay : M3e.Value.Supported
    , position : M3e.Value.Supported
    , showDelay : M3e.Value.Supported
    , touchGestures : M3e.Value.Supported
    , onBeforetoggle : M3e.Value.Supported
    , onToggle : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content { subhead : M3e.Value.Supported
    , actions : M3e.Value.Supported
    } msg)
    -> M3e.Element.Element { s | richTooltip : M3e.Value.Supported } msg
richTooltip req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.RichTooltip.richTooltip
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


{-| Place content in the `subhead` slot. -}
subhead :
    M3e.Element.Element { text : M3e.Value.Supported } msg
    -> M3e.Content.Content { r | subhead : M3e.Value.Supported } msg
subhead el =
    M3e.Content.slot "subhead" el


{-| Place content in the `actions` slot. -}
actions :
    M3e.Element.Element any msg
    -> M3e.Content.Content { r | actions : M3e.Value.Supported } msg
actions el =
    M3e.Content.slot "actions" el