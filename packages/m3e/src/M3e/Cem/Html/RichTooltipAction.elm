module M3e.Cem.Html.RichTooltipAction exposing ( richTooltipAction, disableRestoreFocus )

{-|
Bottom layer for `<m3e-rich-tooltip-action>`: the plain `elm/html` API — one element constructor plus raw attribute and event setters, R1-correct DOM emission, no phantom typing. The rawest escape in the gradient.

@docs richTooltipAction, disableRestoreFocus
-}


import Html
import Html.Attributes
import Json.Encode


{-| The raw `<m3e-rich-tooltip-action>` element — a partial application of `Html.node`. -}
richTooltipAction :
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
richTooltipAction =
    Html.node "m3e-rich-tooltip-action"


{-| Whether to focus should not be restored to the trigger when activated. (default: `false`) -}
disableRestoreFocus : Bool -> Html.Attribute msg
disableRestoreFocus val_ =
    Html.Attributes.property "disableRestoreFocus" (Json.Encode.bool val_)