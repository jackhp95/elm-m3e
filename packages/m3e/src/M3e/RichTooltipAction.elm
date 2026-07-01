module M3e.RichTooltipAction exposing (richTooltipAction)

{-| 
@docs richTooltipAction
-}


import M3e.Cem.Attr
import M3e.Cem.RichTooltipAction
import M3e.Content
import M3e.Element
import M3e.Node
import M3e.Value


{-| Build the `<m3e-rich-tooltip-action>` element (lazy IR). -}
richTooltipAction :
    { content : M3e.Element.Element { text : M3e.Value.Supported } msg }
    -> List (M3e.Cem.Attr.Attr { disableRestoreFocus : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (M3e.Content.Content {} msg)
    -> M3e.Element.Element { s | richTooltipAction : M3e.Value.Supported } msg
richTooltipAction req_ attributes content_ =
    M3e.Element.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Cem.RichTooltipAction.richTooltipAction
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