module M3e.Cem.RichTooltipAction exposing ( richTooltipAction, disableRestoreFocus )

{-|
Middle layer for `<m3e-rich-tooltip-action>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.RichTooltipAction` module for everyday use.

@docs richTooltipAction, disableRestoreFocus
-}


import Html
import M3e.Cem.Attr
import M3e.Cem.Html.RichTooltipAction
import M3e.Value


{-| An element, nested within a clickable element, used to dismiss a parenting rich tooltip. -}
richTooltipAction :
    List (M3e.Cem.Attr.Attr { disableRestoreFocus : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
richTooltipAction attributes children =
    M3e.Cem.Html.RichTooltipAction.richTooltipAction
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| Whether to focus should not be restored to the trigger when activated. (default: `false`) -}
disableRestoreFocus :
    Bool
    -> M3e.Cem.Attr.Attr { c | disableRestoreFocus : M3e.Value.Supported } msg
disableRestoreFocus =
    M3e.Cem.Attr.attribute M3e.Cem.Html.RichTooltipAction.disableRestoreFocus