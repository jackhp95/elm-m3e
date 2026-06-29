module Cem.M3e.DrawerContainer exposing
    ( component, end, endMode, endDivider, start, startMode
    , startDivider, onChange, startSlot, endSlot
    )

{-| A container for one or two sliding drawers.

@docs component, end, endMode, endDivider, start, startMode
@docs startDivider, onChange, startSlot, endSlot

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A container for one or two sliding drawers.

**Events:**

  - `change`: Dispatched when the state of the start or end drawers change.

**Slots:**

  - `start`: Renders the start drawer.
  - `end`: Renders the end drawer.

**CSS Custom Properties:**

  - `--m3e-drawer-container-color`: The background color of the drawer container.
  - `--m3e-drawer-container-elevation`: The elevation level of the drawer container.
  - `--m3e-drawer-container-width`: The width of the drawer container.
  - `--m3e-drawer-container-scrim-opacity`: The opacity of the scrim behind the drawer.
  - `--m3e-modal-drawer-start-shape`: The shape of the drawer's start edge (typically left in LTR).
  - `--m3e-modal-drawer-end-shape`: The shape of the drawer's end edge (typically right in LTR).
  - `--m3e-modal-drawer-container-color`: The background color of the modal drawer container.
  - `--m3e-modal-drawer-elevation`: The elevation level of the modal drawer container.
  - `--m3e-drawer-divider-color`: The color of the divider between drawer sections.
  - `--m3e-drawer-divider-thickness`: The thickness of the divider line.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-drawer-container" attributes children


{-| Whether the end drawer is open. (default: `false`)
-}
end : Bool -> Html.Attribute msg
end val_ =
    Html.Attributes.property "end" (Json.Encode.bool val_)


{-| The behavior mode of the end drawer. (default: `"side"`)
-}
endMode :
    Cem.M3e.Common.Value
        { auto : Cem.M3e.Common.Supported
        , over : Cem.M3e.Common.Supported
        , push : Cem.M3e.Common.Supported
        , side : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
endMode =
    Cem.M3e.Common.endMode


{-| Whether to show a divider between the end drawer and content for `side` mode. (default: `false`)
-}
endDivider : Bool -> Html.Attribute msg
endDivider val_ =
    Html.Attributes.property "end-divider" (Json.Encode.bool val_)


{-| Whether the start drawer is open. (default: `false`)
-}
start : Bool -> Html.Attribute msg
start val_ =
    Html.Attributes.property "start" (Json.Encode.bool val_)


{-| The behavior mode of the start drawer. (default: `"side"`)
-}
startMode :
    Cem.M3e.Common.Value
        { auto : Cem.M3e.Common.Supported
        , over : Cem.M3e.Common.Supported
        , push : Cem.M3e.Common.Supported
        , side : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
startMode =
    Cem.M3e.Common.startMode


{-| Whether to show a divider between the start drawer and content for `side` mode. (default: `false`)
-}
startDivider : Bool -> Html.Attribute msg
startDivider val_ =
    Html.Attributes.property "start-divider" (Json.Encode.bool val_)


{-| Dispatched when the state of the start or end drawers change.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Renders the start drawer.
-}
startSlot : Html.Attribute msg
startSlot =
    Html.Attributes.attribute "slot" "start"


{-| Renders the end drawer.
-}
endSlot : Html.Attribute msg
endSlot =
    Html.Attributes.attribute "slot" "end"
