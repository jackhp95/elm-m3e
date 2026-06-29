module Cem.M3e.RichTooltip exposing
    ( component, disabled, for, hideDelay, position, showDelay
    , touchGestures, isopen, onBeforetoggle, onToggle, subheadSlot, actionsSlot
    )

{-| Provides contextual details for a control, such as explaining the value or purpose of a feature.

@docs component, disabled, for, hideDelay, position, showDelay
@docs touchGestures, isopen, onBeforetoggle, onToggle, subheadSlot, actionsSlot

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Provides contextual details for a control, such as explaining the value or purpose of a feature.

**Component Info:**

  - **Extends:** `TooltipElementBase` from `/src/tooltip/TooltipElementBase`

**Events:**

  - `beforetoggle`: Dispatched before the toggle state changes.
  - `toggle`: Dispatched after the toggle state has changed.

**Slots:**

  - `subhead`: Optional subhead text displayed above the supporting content.
  - `actions`: Optional action elements displayed at the bottom of the tooltip.

**CSS Custom Properties:**

  - `--m3e-rich-tooltip-padding-top`: Top padding of the tooltip container.
  - `--m3e-rich-tooltip-padding-bottom`: Bottom padding of the tooltip container (when no actions are present).
  - `--m3e-rich-tooltip-padding-inline`: Horizontal padding of the tooltip container.
  - `--m3e-rich-tooltip-max-width`: Maximum width of the tooltip surface.
  - `--m3e-rich-tooltip-shape`: Border‑radius of the tooltip container.
  - `--m3e-rich-tooltip-container-color`: Background color of the tooltip surface.
  - `--m3e-rich-tooltip-subhead-color`: Color of the subhead text.
  - `--m3e-rich-tooltip-subhead-font-size`: Font size of the subhead text.
  - `--m3e-rich-tooltip-subhead-font-weight`: Font weight of the subhead text.
  - `--m3e-rich-tooltip-subhead-line-height`: Line height of the subhead text.
  - `--m3e-rich-tooltip-subhead-tracking`: Letter‑spacing of the subhead text.
  - `--m3e-rich-tooltip-subhead-bottom-space`: Space below the subhead before the supporting text.
  - `--m3e-rich-tooltip-supporting-text-color`: Color of the supporting text.
  - `--m3e-rich-tooltip-supporting-text-font-size`: Font size of the supporting text.
  - `--m3e-rich-tooltip-supporting-text-font-weight`: Font weight of the supporting text.
  - `--m3e-rich-tooltip-supporting-text-line-height`: Line height of the supporting text.
  - `--m3e-rich-tooltip-supporting-text-tracking`: Letter‑spacing of the supporting text.
  - `--m3e-rich-tooltip-actions-padding-inline`: Horizontal padding applied to the actions slot area.
  - `--m3e-rich-tooltip-actions-top-space`: Space above the actions slot.
  - `--m3e-rich-tooltip-actions-bottom-space`: Space below the actions slot.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-rich-tooltip" attributes children


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


{-| The position of the tooltip. (default: `"below-after"`)
-}
position :
    Cem.M3e.Common.Value
        { above : Cem.M3e.Common.Supported
        , aboveAfter : Cem.M3e.Common.Supported
        , aboveBefore : Cem.M3e.Common.Supported
        , after : Cem.M3e.Common.Supported
        , before : Cem.M3e.Common.Supported
        , below : Cem.M3e.Common.Supported
        , belowAfter : Cem.M3e.Common.Supported
        , belowBefore : Cem.M3e.Common.Supported
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


{-| Dispatched before the toggle state changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onBeforetoggle : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforetoggle decoder =
    Html.Events.on "beforetoggle" decoder


{-| Dispatched after the toggle state has changed.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle decoder =
    Html.Events.on "toggle" decoder


{-| Optional subhead text displayed above the supporting content.
-}
subheadSlot : Html.Attribute msg
subheadSlot =
    Html.Attributes.attribute "slot" "subhead"


{-| Optional action elements displayed at the bottom of the tooltip.
-}
actionsSlot : Html.Attribute msg
actionsSlot =
    Html.Attributes.attribute "slot" "actions"
