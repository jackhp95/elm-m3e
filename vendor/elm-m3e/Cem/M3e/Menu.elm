module Cem.M3e.Menu exposing
    ( component, positionX, positionY, variant, submenu, onBeforetoggle
    , onToggle
    )

{-| Presents a list of choices on a temporary surface.

@docs component, positionX, positionY, variant, submenu, onBeforetoggle
@docs onToggle

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Presents a list of choices on a temporary surface.

**Events:**

  - `beforetoggle`: Dispatched before the toggle state changes.
  - `toggle`: Dispatched after the toggle state has changed.

**CSS Custom Properties:**

  - `--m3e-menu-container-shape`: Controls the corner radius of the menu container.
  - `--m3e-menu-active-container-shape`: Controls the corner radius of the menu container when active.
  - `--m3e-menu-container-min-width`: Minimum width of the menu container.
  - `--m3e-menu-container-max-width`: Maximum width of the menu container.
  - `--m3e-menu-container-max-height`: Maximum height of the menu container.
  - `--m3e-menu-container-padding-block`: Vertical padding inside the menu container.
  - `--m3e-menu-container-padding-inline`: Horizontal padding inside the menu container.
  - `--m3e-menu-container-color`: Background color of the menu container.
  - `--m3e-menu-container-elevation`: Box shadow elevation of the menu container.
  - `--m3e-vibrant-menu-container-color`: Background color of the menu container for vibrant variant.
  - `--m3e-menu-divider-spacing`: Vertical spacing around slotted `m3e-divider` elements.
  - `--m3e-menu-gap`: Gap between content in the menu.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-menu" attributes children


{-| The position of the menu, on the x-axis. (default: `"after"`)
-}
positionX :
    Cem.M3e.Common.Value
        { after : Cem.M3e.Common.Supported
        , before : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
positionX =
    Cem.M3e.Common.positionX


{-| The position of the menu, on the y-axis. (default: `"below"`)
-}
positionY :
    Cem.M3e.Common.Value
        { above : Cem.M3e.Common.Supported
        , below : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
positionY =
    Cem.M3e.Common.positionY


{-| The appearance variant of the menu. (default: `"standard"`)
-}
variant :
    Cem.M3e.Common.Value
        { standard : Cem.M3e.Common.Supported
        , vibrant : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant


{-| A value indicating whether the menu is a submenu. (default: `false`)
-}
submenu : Bool -> Html.Attribute msg
submenu val_ =
    Html.Attributes.property "submenu" (Json.Encode.bool val_)


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
