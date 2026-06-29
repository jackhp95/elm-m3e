module Cem.M3e.FabMenu exposing (component, variant, onBeforetoggle, onToggle)

{-| A menu, opened from a floating action button (FAB), used to display multiple related actions.

@docs component, variant, onBeforetoggle, onToggle

-}

import Cem.M3e.Common
import Html
import Html.Events
import Json.Decode


{-| A menu, opened from a floating action button (FAB), used to display multiple related actions.

**Events:**

  - `beforetoggle`: Dispatched before the toggle state changes.
  - `toggle`: Dispatched after the toggle state has changed.

**CSS Custom Properties:**

  - `--m3e-fab-menu-spacing`: Vertical gap between menu items.
  - `--m3e-fab-menu-max-width`: Maximum width of the menu.
  - `--m3e-primary-fab-color`: Foreground color for primary variant items.
  - `--m3e-primary-fab-container-color`: Container color for primary variant items.
  - `--m3e-primary-fab-hover-color`: Hover background color for primary variant items.
  - `--m3e-primary-fab-focus-color`: Focus background color for primary variant items.
  - `--m3e-primary-fab-ripple-color`: Ripple color for primary variant items.
  - `--m3e-secondary-fab-color`: Foreground color for secondary variant items.
  - `--m3e-secondary-fab-container-color`: Container color for secondary variant items.
  - `--m3e-secondary-fab-hover-color`: Hover background color for secondary variant items.
  - `--m3e-secondary-fab-focus-color`: Focus background color for secondary variant items.
  - `--m3e-secondary-fab-ripple-color`: Ripple color for secondary variant items.
  - `--m3e-tertiary-fab-color`: Foreground color for tertiary variant items.
  - `--m3e-tertiary-fab-container-color`: Container color for tertiary variant items.
  - `--m3e-tertiary-fab-hover-color`: Hover background color for tertiary variant items.
  - `--m3e-tertiary-fab-focus-color`: Focus background color for tertiary variant items.
  - `--m3e-tertiary-fab-ripple-color`: Ripple color for tertiary variant items.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-fab-menu" attributes children


{-| The appearance variant of the menu. (default: `"primary"`)
-}
variant :
    Cem.M3e.Common.Value
        { primary : Cem.M3e.Common.Supported
        , secondary : Cem.M3e.Common.Supported
        , tertiary : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant


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
