module Cem.M3e.RichTooltipAction exposing
    ( component
    , disableRestoreFocus
    )

{-| An element, nested within a clickable element, used to dismiss a parenting rich tooltip.


## Component

@docs component


### Attributes

@docs disableRestoreFocus

-}

import Html
import Html.Attributes
import Json.Encode


{-| An element, nested within a clickable element, used to dismiss a parenting rich tooltip.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-rich-tooltip-action" attributes children


{-| Whether to focus should not be restored to the trigger when activated. (default: `false`)
-}
disableRestoreFocus : Bool -> Html.Attribute msg
disableRestoreFocus val_ =
    Html.Attributes.property "disableRestoreFocus" (Json.Encode.bool val_)
