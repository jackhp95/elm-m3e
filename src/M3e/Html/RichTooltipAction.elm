module M3e.Html.RichTooltipAction exposing (richTooltipAction, disableRestoreFocus)

{-| Middle layer for `<m3e-rich-tooltip-action>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.RichTooltipAction` module for everyday use.

@docs richTooltipAction, disableRestoreFocus

-}

import Html
import M3e.Raw.RichTooltipAction
import M3e.Token
import Markup.Html.Attr
import Markup.Html.Attr.Internal


{-| An element, nested within a clickable element, used to dismiss a parenting rich tooltip.

**Component Info:**

  - **Extends:** `ActionElementBase`

-}
richTooltipAction :
    List
        (Markup.Html.Attr.Attr
            { disableRestoreFocus : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
richTooltipAction attributes children =
    M3e.Raw.RichTooltipAction.richTooltipAction
        (List.map Markup.Html.Attr.toAttribute attributes)
        children


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
    Markup.Html.Attr.Internal.attribute
        M3e.Raw.RichTooltipAction.disableRestoreFocus
