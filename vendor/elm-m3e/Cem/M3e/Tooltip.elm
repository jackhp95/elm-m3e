module Cem.M3e.Tooltip exposing
    ( component, disabled, for, hideDelay, position, showDelay
    , touchGestures, isopen
    )

{-| Adds additional context to a button or other UI element.

@docs component, disabled, for, hideDelay, position, showDelay
@docs touchGestures, isopen

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Json.Encode


{-| Adds additional context to a button or other UI element.

**Component Info:**

  - **Extends:** `TooltipElementBase` from `/src/tooltip/TooltipElementBase`

**CSS Custom Properties:**

  - `--m3e-tooltip-padding`: Internal spacing of the tooltip container.
  - `--m3e-tooltip-min-width`: Minimum width of the tooltip.
  - `--m3e-tooltip-max-width`: Maximum width of the tooltip.
  - `--m3e-tooltip-min-height`: Minimum height of the tooltip container.
  - `--m3e-tooltip-max-height`: Maximum height of the tooltip.
  - `--m3e-tooltip-shape`: Border radius of the tooltip container.
  - `--m3e-tooltip-container-color`: Background color of the tooltip.
  - `--m3e-tooltip-supporting-text-color`: Text color of supporting text.
  - `--m3e-tooltip-supporting-text-font-size`: Font size of supporting text.
  - `--m3e-tooltip-supporting-text-font-weight`: Font weight of supporting text.
  - `--m3e-tooltip-supporting-text-line-height`: Line height of supporting text.
  - `--m3e-tooltip-supporting-text-tracking`: Letter spacing of supporting text.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-tooltip" attributes children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_


{-| The amount of time, in milliseconds, before hiding the tooltip. (default: `200`)
-}
hideDelay : Float -> Html.Attribute msg
hideDelay val_ =
    Html.Attributes.property "hide-delay" (Json.Encode.float val_)


{-| The position of the tooltip. (default: `"below"`)
-}
position :
    Cem.M3e.Common.Value
        { above : Cem.M3e.Common.Supported
        , after : Cem.M3e.Common.Supported
        , before : Cem.M3e.Common.Supported
        , below : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
position =
    Cem.M3e.Common.position


{-| The amount of time, in milliseconds, before showing the tooltip. (default: `0`)
-}
showDelay : Float -> Html.Attribute msg
showDelay val_ =
    Html.Attributes.property "show-delay" (Json.Encode.float val_)


{-| The mode in which to handle touch gestures. (default: `"auto"`)
-}
touchGestures :
    Cem.M3e.Common.Value
        { auto : Cem.M3e.Common.Supported
        , off : Cem.M3e.Common.Supported
        , on : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
touchGestures =
    Cem.M3e.Common.touchGestures


{-| Whether the tooltip is currently open.
-}
isopen : Bool -> Html.Attribute msg
isopen val_ =
    Html.Attributes.property "isOpen" (Json.Encode.bool val_)
