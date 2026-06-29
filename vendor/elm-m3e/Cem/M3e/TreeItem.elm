module Cem.M3e.TreeItem exposing
    ( component, disabled, indeterminate, open, selected, visible
    , haschilditems, level, onOpening, onOpened, onClosing, onClosed
    , onClick, labelSlot, iconSlot, selectedIconSlot, toggleIconSlot, openToggleIconSlot
    )

{-| An expandable item in a tree.

@docs component, disabled, indeterminate, open, selected, visible
@docs haschilditems, level, onOpening, onOpened, onClosing, onClosed
@docs onClick, labelSlot, iconSlot, selectedIconSlot, toggleIconSlot, openToggleIconSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| An expandable item in a tree.

**Events:**

  - `opening`: Dispatched when the item begins to open.
  - `opened`: Dispatched when the item has opened.
  - `closing`: Dispatched when the item begins to close.
  - `closed`: Dispatched when the item has closed.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `label`: Renders the label of the item.
  - `icon`: Renders the icon of the item.
  - `selected-icon`: Renders the icon of the item when selected.
  - `toggle-icon`: Renders the toggle icon.
  - `open-toggle-icon`: Renders the toggle icon when selected.

**CSS Custom Properties:**

  - `--m3e-tree-item-font-size`: Font size for the item label.
  - `--m3e-tree-item-font-weight`: Font weight for the item label.
  - `--m3e-tree-item-line-height`: Line height for the item label.
  - `--m3e-tree-item-tracking`: Letter spacing for the item label.
  - `--m3e-tree-item-padding`: Inline padding for the item.
  - `--m3e-tree-item-height`: Height of the item.
  - `--m3e-tree-item-shape`: Border radius of the item and focus ring.
  - `--m3e-tree-item-icon-size`: Size of the icon.
  - `--m3e-tree-item-inset`: Indentation for nested items.
  - `--m3e-tree-item-label-color`: Text color for the item label.
  - `--m3e-tree-item-selected-label-color`: Text color for selected item label.
  - `--m3e-tree-item-selected-container-color`: Background color for selected item.
  - `--m3e-tree-item-selected-container-focus-color`: Focus color for selected item container.
  - `--m3e-tree-item-selected-container-hover-color`: Hover color for selected item container.
  - `--m3e-tree-item-selected-ripple-color`: Ripple color for selected item.
  - `--m3e-tree-item-unselected-container-focus-color`: Focus color for unselected item container.
  - `--m3e-tree-item-unselected-container-hover-color`: Hover color for unselected item container.
  - `--m3e-tree-item-unselected-ripple-color`: Ripple color for unselected item.
  - `--m3e-tree-item-disabled-color`: Text color for disabled item.
  - `--m3e-tree-item-disabled-color-opacity`: Opacity for disabled item text color.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-tree-item" attributes children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| A value indicating whether the element's selected / checked state is indeterminate. (default: `false`)
-}
indeterminate : Bool -> Html.Attribute msg
indeterminate val_ =
    Html.Attributes.property "indeterminate" (Json.Encode.bool val_)


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


{-| Renders the toggle icon when selected.
-}
openToggleIconSlot : Html.Attribute msg
openToggleIconSlot =
    Html.Attributes.attribute "slot" "open-toggle-icon"
