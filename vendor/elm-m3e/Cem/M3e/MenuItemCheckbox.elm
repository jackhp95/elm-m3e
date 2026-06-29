module Cem.M3e.MenuItemCheckbox exposing (component, disabled, checked, onClick, iconSlot, trailingIconSlot)

{-| An item of a menu which supports a checkable state.

@docs component, disabled, checked, onClick, iconSlot, trailingIconSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| An item of a menu which supports a checkable state.

**Component Info:**

  - **Extends:** `MenuItemElementBase` from `/src/menu/MenuItemElementBase`

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders an icon before the items's label.
  - `trailing-icon`: Renders an icon after the item's label.

**CSS Custom Properties:**

  - `--m3e-menu-item-container-height`: Height of the menu item container.
  - `--m3e-menu-item-color`: Text color for unselected, enabled menu items.
  - `--m3e-menu-item-container-hover-color`: State layer hover color for unselected items.
  - `--m3e-menu-item-container-focus-color`: State layer focus color for unselected items.
  - `--m3e-menu-item-ripple-color`: Ripple color for unselected items.
  - `--m3e-menu-item-selected-color`: Text color for selected items.
  - `--m3e-menu-item-selected-container-color`: Background color for selected items.
  - `--m3e-menu-item-selected-container-hover-color`: State layer hover color for selected items.
  - `--m3e-menu-item-selected-container-focus-color`: State layer focus color for selected items.
  - `--m3e-menu-item-selected-ripple-color`: Ripple color for selected items.
  - `--m3e-menu-item-active-state-layer-color`: State layer color for expanded items.
  - `--m3e-menu-item-active-state-layer-opacity`: State layer opacity for expanded items.
  - `--m3e-menu-item-disabled-color`: Base color for disabled items.
  - `--m3e-menu-item-disabled-opacity`: Opacity percentage for disabled item color mix.
  - `--m3e-vibrant-menu-item-color`: Text color for unselected, enabled menu items for vibrant variant.
  - `--m3e-vibrant-menu-item-container-hover-color`: State layer hover color for unselected items for vibrant variant.
  - `--m3e-vibrant-menu-item-container-focus-color`: State layer focus color for unselected items for vibrant variant.
  - `--m3e-vibrant-menu-item-ripple-color`: Ripple color for unselected items for vibrant variant.
  - `--m3e-vibrant-menu-item-selected-color`: Text color for selected items for vibrant variant.
  - `--m3e-vibrant-menu-item-selected-container-color`: Background color for selected items for vibrant variant.
  - `--m3e-vibrant-menu-item-selected-container-hover-color`: State layer hover color for selected items for vibrant variant.
  - `--m3e-vibrant-menu-item-selected-container-focus-color`: State layer focus color for selected items for vibrant variant.
  - `--m3e-vibrant-menu-item-selected-ripple-color`: Ripple color for selected items for vibrant variant.
  - `--m3e-vibrant-menu-item-active-state-layer-color`: State layer color for expanded items for vibrant variant.
  - `--m3e-vibrant-menu-item-disabled-color`: Base color for disabled items for vibrant variant
  - `--m3e-menu-item-icon-label-space`: Horizontal gap between icon and content.
  - `--m3e-menu-item-padding-start`: Start padding for the item wrapper.
  - `--m3e-menu-item-padding-end`: End padding for the item wrapper.
  - `--m3e-menu-item-label-text-font-size`: Font size for menu item text.
  - `--m3e-menu-item-label-text-font-weight`: Font weight for menu item text.
  - `--m3e-menu-item-label-text-line-height`: Line height for menu item text.
  - `--m3e-menu-item-label-text-tracking`: Letter spacing for menu item text.
  - `--m3e-menu-item-focus-ring-shape`: Border radius for the focus ring.
  - `--m3e-menu-item-icon-size`: Font size for leading and trailing icons.
  - `--m3e-menu-item-shape`: Base shape of the menu item.
  - `--m3e-menu-item-selected-shape`: Shape used for a selected menu item.
  - `--m3e-menu-item-first-child-shape`: Shape for the first menu item in a menu.
  - `--m3e-menu-item-last-child-shape`: Shape for the last menu item in a menu.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-menu-item-checkbox" attributes children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the element is checked. (default: `false`)
-}
checked : Bool -> Html.Attribute msg
checked =
    Html.Attributes.checked


{-| Dispatched when the element is clicked.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders an icon before the items's label.
-}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders an icon after the item's label.
-}
trailingIconSlot : Html.Attribute msg
trailingIconSlot =
    Html.Attributes.attribute "slot" "trailing-icon"
