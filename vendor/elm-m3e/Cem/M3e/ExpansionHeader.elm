module Cem.M3e.ExpansionHeader exposing
    ( component, hideToggle, toggleDirection, togglePosition, disabled, onClick
    , toggleIconSlot
    )

{-| A button used to toggle the expanded state of an expansion panel.

@docs component, hideToggle, toggleDirection, togglePosition, disabled, onClick
@docs toggleIconSlot

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A button used to toggle the expanded state of an expansion panel.

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `toggle-icon`: Renders the icon of the expansion toggle.

**CSS Custom Properties:**

  - `--m3e-expansion-header-collapsed-height`: Height of the header when the panel is collapsed.
  - `--m3e-expansion-header-expanded-height`: Height of the header when the panel is expanded.
  - `--m3e-expansion-header-padding-left`: Left padding inside the header.
  - `--m3e-expansion-header-padding-right`: Right padding inside the header.
  - `--m3e-expansion-header-spacing`: Spacing between header elements.
  - `--m3e-expansion-header-toggle-icon-size`: Size of the toggle icon (e.g. chevron).
  - `--m3e-expansion-header-font-size`: The font size of the header text.
  - `--m3e-expansion-header-font-weight`: The font weight of the header text.
  - `--m3e-expansion-header-line-height`: The line height of the header text.
  - `--m3e-expansion-header-tracking`: Letter spacing (tracking) of the header text.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-expansion-header" attributes children


{-| Whether to hide the expansion toggle. (default: `false`)
-}
hideToggle : Bool -> Html.Attribute msg
hideToggle val_ =
    Html.Attributes.property "hide-toggle" (Json.Encode.bool val_)


{-| The direction of the expansion toggle. (default: `"vertical"`)
-}
toggleDirection :
    Cem.M3e.Common.Value
        { horizontal : Cem.M3e.Common.Supported
        , vertical : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
toggleDirection =
    Cem.M3e.Common.toggleDirection


{-| The position of the expansion toggle. (default: `"after"`)
-}
togglePosition :
    Cem.M3e.Common.Value
        { after : Cem.M3e.Common.Supported
        , before : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
togglePosition =
    Cem.M3e.Common.togglePosition


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Dispatched when the element is clicked.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders the icon of the expansion toggle.
-}
toggleIconSlot : Html.Attribute msg
toggleIconSlot =
    Html.Attributes.attribute "slot" "toggle-icon"
