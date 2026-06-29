module Cem.M3e.ExpansionPanel exposing
    ( component, disabled, hideToggle, open, toggleDirection, togglePosition
    , onOpening, onOpened, onClosing, onClosed, actionsSlot, headerSlot
    , toggleIconSlot
    )

{-| An expandable details-summary view.

@docs component, disabled, hideToggle, open, toggleDirection, togglePosition
@docs onOpening, onOpened, onClosing, onClosed, actionsSlot, headerSlot
@docs toggleIconSlot

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| An expandable details-summary view.

**Events:**

  - `opening`: Dispatched when the expansion panel begins to open.
  - `opened`: Dispatched when the expansion panel has opened.
  - `closing`: Dispatched when the expansion panel begins to close.
  - `closed`: Dispatched when the expansion panel has closed.

**Slots:**

  - `actions`: Renders the actions bar of the panel.
  - `header`: Renders the header content.
  - `toggle-icon`: Renders the expansion toggle icon.

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
  - `--m3e-expansion-panel-text-color`: Color of the panel's text content.
  - `--m3e-expansion-panel-disabled-text-color`: Color of the panel's text content, when disabled.
  - `--m3e-expansion-panel-disabled-text-opacity`: Opacity of the panel's text content, when disabled.
  - `--m3e-expansion-panel-container-color`: Background color of the panel container.
  - `--m3e-expansion-panel-elevation`: Elevation level when the panel is collapsed.
  - `--m3e-expansion-panel-shape`: Shape (e.g. border radius) of the panel when collapsed.
  - `--m3e-expansion-panel-open-elevation`: Elevation level when the panel is expanded.
  - `--m3e-expansion-panel-open-shape`: Shape (e.g. border radius) of the panel when expanded.
  - `--m3e-expansion-panel-content-padding`: Padding around the panel's content area.
  - `--m3e-expansion-panel-actions-spacing`: Spacing between action buttons or elements.
  - `--m3e-expansion-panel-actions-padding`: Padding around the actions section.
  - `--m3e-expansion-panel-actions-divider-thickness`: Thickness of the divider above actions.
  - `--m3e-expansion-panel-actions-divider-color`: Color of the divider above actions.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-expansion-panel" attributes children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether to hide the expansion toggle. (default: `false`)
-}
hideToggle : Bool -> Html.Attribute msg
hideToggle val_ =
    Html.Attributes.property "hide-toggle" (Json.Encode.bool val_)


{-| Whether the panel is expanded. (default: `false`)
-}
open : Bool -> Html.Attribute msg
open val_ =
    Html.Attributes.property "open" (Json.Encode.bool val_)


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


{-| Dispatched when the expansion panel begins to open.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onOpening : Json.Decode.Decoder msg -> Html.Attribute msg
onOpening decoder =
    Html.Events.on "opening" decoder


{-| Dispatched when the expansion panel has opened.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onOpened : Json.Decode.Decoder msg -> Html.Attribute msg
onOpened decoder =
    Html.Events.on "opened" decoder


{-| Dispatched when the expansion panel begins to close.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClosing : Json.Decode.Decoder msg -> Html.Attribute msg
onClosing decoder =
    Html.Events.on "closing" decoder


{-| Dispatched when the expansion panel has closed.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClosed : Json.Decode.Decoder msg -> Html.Attribute msg
onClosed decoder =
    Html.Events.on "closed" decoder


{-| Renders the actions bar of the panel.
-}
actionsSlot : Html.Attribute msg
actionsSlot =
    Html.Attributes.attribute "slot" "actions"


{-| Renders the header content.
-}
headerSlot : Html.Attribute msg
headerSlot =
    Html.Attributes.attribute "slot" "header"


{-| Renders the expansion toggle icon.
-}
toggleIconSlot : Html.Attribute msg
toggleIconSlot =
    Html.Attributes.attribute "slot" "toggle-icon"
