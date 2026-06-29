module Cem.M3e.NavRail exposing (component, mode, onBeforeinput, onInput, onChange)

{-| A vertical bar, typically used on larger devices, that allows a user to switch between views.

@docs component, mode, onBeforeinput, onInput, onChange

-}

import Cem.M3e.Common
import Html
import Html.Events
import Json.Decode


{-| A vertical bar, typically used on larger devices, that allows a user to switch between views.

**Events:**

  - `beforeinput`: Dispatched before the selected state of an item changes.
  - `input`: Dispatched when the selected state of an item changes.
  - `change`: Dispatched when the selected state of an item changes.

**CSS Custom Properties:**

  - `--m3e-nav-rail-top-space`: Top block padding for the nav rail.
  - `--m3e-nav-rail-bottom-space`: Bottom block padding for the nav rail.
  - `--m3e-nav-rail-compact-width`: Width of the nav rail in compact mode.
  - `--m3e-nav-rail-inline-padding`: Inline padding for nav rail.
  - `--m3e-nav-rail-expanded-width`: Width of the nav rail in expanded mode.
  - `--m3e-nav-rail-expanded-item-height`: Height of nav items in expanded mode.
  - `--m3e-nav-rail-button-item-space`: Space below icon buttons and FABs.
  - `--m3e-nav-rail-icon-button-inset`: Inset for icon buttons.
  - `--m3e-nav-rail-expanded-inline-padding`: Deprecated, use `--m3e-nav-rail-inline-padding`.
  - `--m3e-nav-rail-expanded-min-width`: Deprecated, use `--m3e-nav-rail-expanded-width`.
  - `--m3e-nav-rail-expanded-max-width`: Deprecated, use `--m3e-nav-rail-expanded-width`.
  - `--m3e-nav-rail-expanded-icon-button-inset`: Deprecated, use `--m3e-nav-rail-icon-button-inset`.
  - `--m3e-nav-bar-height`: Height of the navigation bar.
  - `--m3e-nav-bar-container-color`: Background color of the navigation bar container.
  - `--m3e-nav-bar-vertical-item-width`: Minimum width of vertical nav items.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-nav-rail" attributes children


{-| The mode in which items in the rail are presented. (default: `"compact"`)
-}
mode :
    Cem.M3e.Common.Value
        { auto : Cem.M3e.Common.Supported
        , compact : Cem.M3e.Common.Supported
        , expanded : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
mode =
    Cem.M3e.Common.mode


{-| Dispatched before the selected state of an item changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the selected state of an item changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Dispatched when the selected state of an item changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder
