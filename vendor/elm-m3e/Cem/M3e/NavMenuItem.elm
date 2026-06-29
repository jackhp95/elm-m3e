module Cem.M3e.NavMenuItem exposing
    ( component, disabled, open, selected, visible, haschilditems
    , level, onOpening, onOpened, onClosing, onClosed, onClick
    , labelSlot, iconSlot, badgeSlot, selectedIconSlot, toggleIconSlot
    )

{-| An expandable item, selectable item within a navigation menu.

@docs component, disabled, open, selected, visible, haschilditems
@docs level, onOpening, onOpened, onClosing, onClosed, onClick
@docs labelSlot, iconSlot, badgeSlot, selectedIconSlot, toggleIconSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| An expandable item, selectable item within a navigation menu.

**Events:**

  - `opening`: Dispatched when the item begins to open.
  - `opened`: Dispatched when the item has opened.
  - `closing`: Dispatched when the item begins to close.
  - `closed`: Dispatched when the item has closed.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `label`: Renders the label of the item.
  - `icon`: Renders the icon of the item.
  - `badge`: Renders the badge of the item.
  - `selected-icon`: Renders the icon of the item when selected.
  - `toggle-icon`: Renders the toggle icon.

**CSS Custom Properties:**

  - `--m3e-nav-menu-item-font-size`: Font size for the item label.
  - `--m3e-nav-menu-item-font-weight`: Font weight for the item label.
  - `--m3e-nav-menu-item-line-height`: Line height for the item label.
  - `--m3e-nav-menu-item-tracking`: Letter spacing for the item label.
  - `--m3e-nav-menu-item-padding`: Inline padding for the item.
  - `--m3e-nav-menu-item-height`: Height of the item.
  - `--m3e-nav-menu-item-spacing`: Spacing between icon and label.
  - `--m3e-nav-menu-item-shape`: Border radius of the item and focus ring.
  - `--m3e-nav-menu-item-icon-size`: Size of the icon.
  - `--m3e-nav-menu-item-inset`: Indentation for nested items.
  - `--m3e-nav-menu-item-label-color`: Text color for the item label.
  - `--m3e-nav-menu-item-selected-label-color`: Text color for selected item label.
  - `--m3e-nav-menu-item-selected-container-color`: Background color for selected item.
  - `--m3e-nav-menu-item-selected-container-focus-color`: Focus color for selected item container.
  - `--m3e-nav-menu-item-selected-container-hover-color`: Hover color for selected item container.
  - `--m3e-nav-menu-item-selected-ripple-color`: Ripple color for selected item.
  - `--m3e-nav-menu-item-unselected-container-focus-color`: Focus color for unselected item container.
  - `--m3e-nav-menu-item-unselected-container-hover-color`: Hover color for unselected item container.
  - `--m3e-nav-menu-item-unselected-ripple-color`: Ripple color for unselected item.
  - `--m3e-nav-menu-item-open-container-color`: Background color for open item with children.
  - `--m3e-nav-menu-item-open-container-focus-color`: Focus color for open item container.
  - `--m3e-nav-menu-item-open-container-hover-color`: Hover color for open item container.
  - `--m3e-nav-menu-item-open-ripple-color`: Ripple color for open item.
  - `--m3e-nav-menu-item-disabled-color`: Text color for disabled item.
  - `--m3e-nav-menu-item-disabled-color-opacity`: Opacity for disabled item text color.
  - `--m3e-nav-menu-item-badge-font-size`: Font size for badge slot.
  - `--m3e-nav-menu-item-badge-font-weight`: Font weight for badge slot.
  - `--m3e-nav-menu-item-badge-line-height`: Line height for badge slot.
  - `--m3e-nav-menu-item-badge-tracking`: Letter spacing for badge slot.
  - `--m3e-nav-menu-divider-margin`: Margin for divider elements.
  - `--m3e-nav-menu-item-vertical-inset`: Vertical margin for first/last child items.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-nav-menu-item" attributes children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the item is expanded. (default: `false`)
-}
open : Bool -> Html.Attribute msg
open val_ =
    Html.Attributes.property "open" (Json.Encode.bool val_)


{-| Whether the item is selected. (default: `false`)
-}
selected : Bool -> Html.Attribute msg
selected =
    Html.Attributes.selected


{-| Whether the item is visible.
-}
visible : Bool -> Html.Attribute msg
visible val_ =
    Html.Attributes.property "visible" (Json.Encode.bool val_)


{-| Whether the item has child items.
-}
haschilditems : Bool -> Html.Attribute msg
haschilditems val_ =
    Html.Attributes.property "hasChildItems" (Json.Encode.bool val_)


{-| The one-based level of the item.
-}
level : Float -> Html.Attribute msg
level val_ =
    Html.Attributes.property "level" (Json.Encode.float val_)


{-| Dispatched when the item begins to open.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onOpening : Json.Decode.Decoder msg -> Html.Attribute msg
onOpening decoder =
    Html.Events.on "opening" decoder


{-| Dispatched when the item has opened.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onOpened : Json.Decode.Decoder msg -> Html.Attribute msg
onOpened decoder =
    Html.Events.on "opened" decoder


{-| Dispatched when the item begins to close.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClosing : Json.Decode.Decoder msg -> Html.Attribute msg
onClosing decoder =
    Html.Events.on "closing" decoder


{-| Dispatched when the item has closed.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClosed : Json.Decode.Decoder msg -> Html.Attribute msg
onClosed decoder =
    Html.Events.on "closed" decoder


{-| Dispatched when the element is clicked.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders the label of the item.
-}
labelSlot : Html.Attribute msg
labelSlot =
    Html.Attributes.attribute "slot" "label"


{-| Renders the icon of the item.
-}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders the badge of the item.
-}
badgeSlot : Html.Attribute msg
badgeSlot =
    Html.Attributes.attribute "slot" "badge"


{-| Renders the icon of the item when selected.
-}
selectedIconSlot : Html.Attribute msg
selectedIconSlot =
    Html.Attributes.attribute "slot" "selected-icon"


{-| Renders the toggle icon.
-}
toggleIconSlot : Html.Attribute msg
toggleIconSlot =
    Html.Attributes.attribute "slot" "toggle-icon"
