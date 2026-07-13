module M3e.RichTooltipAction exposing (view, disableRestoreFocus)

{-| An element, nested within a clickable element, used to dismiss a parenting rich tooltip.

**Component Info:**

  - **Extends:** `ActionElementBase`

@docs view, disableRestoreFocus

-}

import M3e.Html.RichTooltipAction
import M3e.Kind
import M3e.Token
import Markup.Element
import Markup.Element.Internal
import Markup.Html.Attr
import Markup.Html.Attr.Internal
import Markup.Kind
import Markup.Node


{-| Build the `<m3e-rich-tooltip-action>` element (lazy IR).
-}
view :
    List
        (Markup.Html.Attr.Attr
            { disableRestoreFocus : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Markup.Element.Element { text : Markup.Kind.Shared } msg)
    -> Markup.Element.Element { s | richTooltipAction : M3e.Kind.Brand } msg
view attributes children =
    Markup.Element.Internal.fromNode
        (Markup.Node.fromComponent
            (\erased ch ->
                M3e.Html.RichTooltipAction.richTooltipAction
                    (List.map Markup.Html.Attr.Internal.forget erased)
                    ch
            )
            (List.map Markup.Html.Attr.Internal.forget attributes)
            (List.map Markup.Element.toNode children)
        )


{-| Whether to focus should not be restored to the trigger when activated. (default: `false`)
-}
disableRestoreFocus :
    Bool
    ->
        Markup.Html.Attr.Attr
            { c
                | disableRestoreFocus : M3e.Token.Supported
            }
            msg
disableRestoreFocus =
    M3e.Html.RichTooltipAction.disableRestoreFocus
