module M3e.Record.RichTooltipAction exposing (view, disableRestoreFocus)

{-| An element, nested within a clickable element, used to dismiss a parenting rich tooltip.

**Component Info:**

  - **Extends:** `ActionElementBase`

@docs view, disableRestoreFocus

-}

import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Html.RichTooltipAction
import M3e.Node
import M3e.Token


{-| Build the `<m3e-rich-tooltip-action>` element (lazy IR).
-}
view :
    { content : M3e.Element.Element { text : M3e.Token.Supported } msg }
    ->
        List
            (M3e.Html.Attr.Attr
                { disableRestoreFocus : M3e.Token.Supported
                , slot : M3e.Token.Supported
                }
                msg
            )
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | richTooltipAction : M3e.Token.Supported } msg
view req_ attributes content_ =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
            (\erased ch ->
                M3e.Html.RichTooltipAction.richTooltipAction
                    (List.map M3e.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map M3e.Html.Attr.Internal.forget attributes)
            (List.append
                [ M3e.Element.toNode req_.content ]
                (List.map M3e.Element.toNode content_)
            )
        )


{-| Whether to focus should not be restored to the trigger when activated. (default: `false`)
-}
disableRestoreFocus :
    Bool
    -> M3e.Html.Attr.Attr { c | disableRestoreFocus : M3e.Token.Supported } msg
disableRestoreFocus =
    M3e.Html.RichTooltipAction.disableRestoreFocus
