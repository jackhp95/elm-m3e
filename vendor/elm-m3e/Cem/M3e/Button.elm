module Cem.M3e.Button exposing
    ( component, disabled, disabledInteractive, download, href, name
    , rel, selected, shape, size, target, toggle
    , type_, value, variant, onBeforeinput, onInput, onChange
    , onClick, iconSlot, selectedSlot, selectedIconSlot, trailingIconSlot
    )

{-| A button users interact with to perform an action.

@docs component, disabled, disabledInteractive, download, href, name
@docs rel, selected, shape, size, target, toggle
@docs type_, value, variant, onBeforeinput, onInput, onChange
@docs onClick, iconSlot, selectedSlot, selectedIconSlot, trailingIconSlot

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A button users interact with to perform an action.

**Events:**

  - `beforeinput`: Dispatched before a toggle button's selected state changes.
  - `input`: Dispatched when a toggle button's selected state changes.
  - `change`: Dispatched when a toggle button's selected state changes.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `icon`: Renders an icon before the button's label.
  - `selected`: Renders the label of the button, when selected.
  - `selected-icon`: Renders an icon before the button's label, when selected.
  - `trailing-icon`: Renders an icon after the button's label.

**CSS Custom Properties:**

  - `--m3e-button-container-height`: Height of the button container, for all size variants.
  - `--m3e-button-outline-thickness`: Thickness of the button outline, for all size variants.
  - `--m3e-button-label-text-font-size`: Font size for the label text, for all size variants.
  - `--m3e-button-label-text-font-weight`: Font weight for the label text, for all size variants.
  - `--m3e-button-label-text-line-height`: Line height for the label text, for all size variants.
  - `--m3e-button-label-text-tracking`: Letter tracking for the label text, for all size variants.
  - `--m3e-button-icon-size`: Size of the icon, for all size variants.
  - `--m3e-button-shape-round`: Corner radius for round shape, for all size variants.
  - `--m3e-button-shape-square`: Corner radius for square shape, for all size variants.
  - `--m3e-button-selected-shape-round`: Corner radius when selected (round), for all size variants.
  - `--m3e-button-selected-shape-square`: Corner radius when selected (square), for all size variants.
  - `--m3e-button-shape-pressed-morph`: Corner radius when pressed, for all size variants.
  - `--m3e-button-leading-space`: Space before icon or label, for all size variants.
  - `--m3e-button-trailing-space`: Space after icon or label, for all size variants.
  - `--m3e-button-icon-label-space`: Space between icon and label, for all size variants.
  - `--m3e-button-extra-small-container-height`: Height of the button container, for the extra-small size variant.
  - `--m3e-button-extra-small-outline-thickness`: Thickness of the button outline, for the extra-small size variant.
  - `--m3e-button-extra-small-label-text-font-size`: Font size for the label text, for the extra-small size variant.
  - `--m3e-button-extra-small-label-text-font-weight`: Font weight for the label text, for the extra-small size variant.
  - `--m3e-button-extra-small-label-text-line-height`: Line height for the label text, for the extra-small size variant.
  - `--m3e-button-extra-small-label-text-tracking`: Letter tracking for the label text, for the extra-small size variant.
  - `--m3e-button-extra-small-icon-size`: Size of the icon, for the extra-small size variant.
  - `--m3e-button-extra-small-shape-round`: Corner radius for round shape, for the extra-small size variant.
  - `--m3e-button-extra-small-shape-square`: Corner radius for square shape, for the extra-small size variant.
  - `--m3e-button-extra-small-selected-shape-round`: Corner radius when selected (round), for the extra-small size variant.
  - `--m3e-button-extra-small-selected-shape-square`: Corner radius when selected (square), for the extra-small size variant.
  - `--m3e-button-extra-small-shape-pressed-morph`: Corner radius when pressed, for the extra-small size variant.
  - `--m3e-button-extra-small-leading-space`: Space before icon or label, for the extra-small size variant.
  - `--m3e-button-extra-small-trailing-space`: Space after icon or label, for the extra-small size variant.
  - `--m3e-button-extra-small-icon-label-space`: Space between icon and label, for the extra-small size variant.
  - `--m3e-button-small-container-height`: Height of the button container, for the small size variant.
  - `--m3e-button-small-outline-thickness`: Thickness of the button outline, for the small size variant.
  - `--m3e-button-small-label-text-font-size`: Font size for the label text, for the small size variant.
  - `--m3e-button-small-label-text-font-weight`: Font weight for the label text, for the small size variant.
  - `--m3e-button-small-label-text-line-height`: Line height for the label text, for the small size variant.
  - `--m3e-button-small-label-text-tracking`: Letter tracking for the label text, for the small size variant.
  - `--m3e-button-small-icon-size`: Size of the icon, for the small size variant.
  - `--m3e-button-small-shape-round`: Corner radius for round shape, for the small size variant.
  - `--m3e-button-small-shape-square`: Corner radius for square shape, for the small size variant.
  - `--m3e-button-small-selected-shape-round`: Corner radius when selected (round), for the small size variant.
  - `--m3e-button-small-selected-shape-square`: Corner radius when selected (square), for the small size variant.
  - `--m3e-button-small-shape-pressed-morph`: Corner radius when pressed, for the small size variant.
  - `--m3e-button-small-leading-space`: Space before icon or label, for the small size variant.
  - `--m3e-button-small-trailing-space`: Space after icon or label, for the small size variant.
  - `--m3e-button-small-icon-label-space`: Space between icon and label, for the small size variant.
  - `--m3e-button-medium-container-height`: Height of the button container, for the medium size variant.
  - `--m3e-button-medium-outline-thickness`: Thickness of the button outline, for the medium size variant.
  - `--m3e-button-medium-label-text-font-size`: Font size for the label text, for the medium size variant.
  - `--m3e-button-medium-label-text-font-weight`: Font weight for the label text, for the medium size variant.
  - `--m3e-button-medium-label-text-line-height`: Line height for the label text, for the medium size variant.
  - `--m3e-button-medium-label-text-tracking`: Letter tracking for the label text, for the medium size variant.
  - `--m3e-button-medium-icon-size`: Size of the icon, for the medium size variant.
  - `--m3e-button-medium-shape-round`: Corner radius for round shape, for the medium size variant.
  - `--m3e-button-medium-shape-square`: Corner radius for square shape, for the medium size variant.
  - `--m3e-button-medium-selected-shape-round`: Corner radius when selected (round), for the medium size variant.
  - `--m3e-button-medium-selected-shape-square`: Corner radius when selected (square), for the medium size variant.
  - `--m3e-button-medium-shape-pressed-morph`: Corner radius when pressed, for the medium size variant.
  - `--m3e-button-medium-leading-space`: Space before icon or label, for the medium size variant.
  - `--m3e-button-medium-trailing-space`: Space after icon or label, for the medium size variant.
  - `--m3e-button-medium-icon-label-space`: Space between icon and label, for the medium size variant.
  - `--m3e-button-large-container-height`: Height of the button container, for the large size variant.
  - `--m3e-button-large-outline-thickness`: Thickness of the button outline, for the large size variant.
  - `--m3e-button-large-label-text-font-size`: Font size for the label text, for the large size variant.
  - `--m3e-button-large-label-text-font-weight`: Font weight for the label text, for the large size variant.
  - `--m3e-button-large-label-text-line-height`: Line height for the label text, for the large size variant.
  - `--m3e-button-large-label-text-tracking`: Letter tracking for the label text, for the large size variant.
  - `--m3e-button-large-icon-size`: Size of the icon, for the large size variant.
  - `--m3e-button-large-shape-round`: Corner radius for round shape, for the large size variant.
  - `--m3e-button-large-shape-square`: Corner radius for square shape, for the large size variant.
  - `--m3e-button-large-selected-shape-round`: Corner radius when selected (round), for the large size variant.
  - `--m3e-button-large-selected-shape-square`: Corner radius when selected (square), for the large size variant.
  - `--m3e-button-large-shape-pressed-morph`: Corner radius when pressed, for the large size variant.
  - `--m3e-button-large-leading-space`: Space before icon or label, for the large size variant.
  - `--m3e-button-large-trailing-space`: Space after icon or label, for the large size variant.
  - `--m3e-button-large-icon-label-space`: Space between icon and label, for the large size variant.
  - `--m3e-button-extra-large-container-height`: Height of the button container, for the extra-large size variant.
  - `--m3e-button-extra-large-outline-thickness`: Thickness of the button outline, for the extra-large size variant.
  - `--m3e-button-extra-large-label-text-font-size`: Font size for the label text, for the extra-large size variant.
  - `--m3e-button-extra-large-label-text-font-weight`: Font weight for the label text, for the extra-large size variant.
  - `--m3e-button-extra-large-label-text-line-height`: Line height for the label text, for the extra-large size variant.
  - `--m3e-button-extra-large-label-text-tracking`: Letter tracking for the label text, for the extra-large size variant.
  - `--m3e-button-extra-large-icon-size`: Size of the icon, for the extra-large size variant.
  - `--m3e-button-extra-large-shape-round`: Corner radius for round shape, for the extra-large size variant.
  - `--m3e-button-extra-large-shape-square`: Corner radius for square shape, for the extra-large size variant.
  - `--m3e-button-extra-large-selected-shape-round`: Corner radius when selected (round), for the extra-large size variant.
  - `--m3e-button-extra-large-selected-shape-square`: Corner radius when selected (square), for the extra-large size variant.
  - `--m3e-button-extra-large-shape-pressed-morph`: Corner radius when pressed, for the extra-large size variant.
  - `--m3e-button-extra-large-leading-space`: Space before icon or label, for the extra-large size variant.
  - `--m3e-button-extra-large-trailing-space`: Space after icon or label, for the extra-large size variant.
  - `--m3e-button-extra-large-icon-label-space`: Space between icon and label, for the extra-large size variant.
  - `--m3e-button-outline-color`: Outline color, for all variants.
  - `--m3e-button-disabled-outline-color`: Disabled outline color, for all variants.
  - `--m3e-button-hover-outline-color`: Hover outline color, for all variants.
  - `--m3e-button-focus-outline-color`: Focus outline color, for all variants.
  - `--m3e-button-pressed-outline-color`: Pressed outline color, for all variants.
  - `--m3e-button-container-color`: Container background color, for all variants.
  - `--m3e-button-container-elevation`: Elevation, for all variants.
  - `--m3e-button-unselected-container-color`: Unselected container color, for all variants.
  - `--m3e-button-selected-container-color`: Selected container color, for all variants.
  - `--m3e-button-disabled-container-elevation`: Disabled elevation, for all variants.
  - `--m3e-button-hover-container-elevation`: Hover elevation, for all variants.
  - `--m3e-button-focus-container-elevation`: Focus elevation, for all variants.
  - `--m3e-button-pressed-container-elevation`: Pressed elevation, for all variants.
  - `--m3e-button-label-text-color`: Label color, for all variants.
  - `--m3e-button-icon-color`: Icon color, for all variants.
  - `--m3e-button-unselected-label-text-color`: Unselected label color, for all variants.
  - `--m3e-button-unselected-icon-color`: Unselected icon color, for all variants.
  - `--m3e-button-selected-label-text-color`: Selected label color, for all variants.
  - `--m3e-button-selected-icon-color`: Selected icon color, for all variants.
  - `--m3e-button-disabled-container-color`: Disabled container color, for all variants.
  - `--m3e-button-disabled-container-opacity`: Disabled container opacity, for all variants.
  - `--m3e-button-disabled-icon-color`: Disabled icon color, for all variants.
  - `--m3e-button-disabled-icon-opacity`: Disabled icon opacity, for all variants.
  - `--m3e-button-disabled-label-text-color`: Disabled label color, for all variants.
  - `--m3e-button-disabled-label-text-opacity`: Disabled label opacity, for all variants.
  - `--m3e-button-hover-icon-color`: Hover icon color, for all variants.
  - `--m3e-button-hover-label-text-color`: Hover label color, for all variants.
  - `--m3e-button-hover-state-layer-color`: Hover state layer color, for all variants.
  - `--m3e-button-hover-state-layer-opacity`: Hover state layer opacity, for all variants.
  - `--m3e-button-hover-unselected-icon-color`: Hover unselected icon color, for all variants.
  - `--m3e-button-hover-unselected-label-text-color`: Hover unselected label color, for all variants.
  - `--m3e-button-hover-unselected-state-layer-color`: Hover unselected state layer color, for all variants.
  - `--m3e-button-hover-selected-icon-color`: Hover selected icon color, for all variants.
  - `--m3e-button-hover-selected-label-text-color`: Hover selected label color, for all variants.
  - `--m3e-button-hover-selected-state-layer-color`: Hover selected state layer color, for all variants.
  - `--m3e-button-focus-icon-color`: Focus icon color, for all variants.
  - `--m3e-button-focus-label-text-color`: Focus label color, for all variants.
  - `--m3e-button-focus-state-layer-color`: Focus state layer color, for all variants.
  - `--m3e-button-focus-state-layer-opacity`: Focus state layer opacity, for all variants.
  - `--m3e-button-focus-unselected-icon-color`: Focus unselected icon color, for all variants.
  - `--m3e-button-focus-unselected-label-text-color`: Focus unselected label color, for all variants.
  - `--m3e-button-focus-unselected-state-layer-color`: Focus unselected state layer color, for all variants.
  - `--m3e-button-focus-selected-icon-color`: Focus selected icon color, for all variants.
  - `--m3e-button-focus-selected-label-text-color`: Focus selected label color, for all variants.
  - `--m3e-button-focus-selected-state-layer-color`: Focus selected state layer color, for all variants.
  - `--m3e-button-pressed-icon-color`: Pressed icon color, for all variants.
  - `--m3e-button-pressed-label-text-color`: Pressed label color, for all variants.
  - `--m3e-button-pressed-state-layer-color`: Pressed state layer color, for all variants.
  - `--m3e-button-pressed-state-layer-opacity`: Pressed state layer opacity, for all variants.
  - `--m3e-button-pressed-unselected-icon-color`: Pressed unselected icon color, for all variants.
  - `--m3e-button-pressed-unselected-label-text-color`: Pressed unselected label color, for all variants.
  - `--m3e-button-pressed-unselected-state-layer-color`: Pressed unselected state layer color, for all variants.
  - `--m3e-button-pressed-selected-icon-color`: Pressed selected icon color, for all variants.
  - `--m3e-button-pressed-selected-label-text-color`: Pressed selected label color, for all variants.
  - `--m3e-button-pressed-selected-state-layer-color`: Pressed selected state layer color, for all variants.
  - `--m3e-elevated-button-label-text-color`: Label color, for the elevated variant.
  - `--m3e-elevated-button-icon-color`: Icon color, for the elevated variant.
  - `--m3e-elevated-button-container-color`: Container background color, for the elevated variant.
  - `--m3e-elevated-button-container-elevation`: Elevation, for the elevated variant.
  - `--m3e-elevated-button-unselected-label-text-color`: Unselected label color, for the elevated variant.
  - `--m3e-elevated-button-unselected-icon-color`: Unselected icon color, for the elevated variant.
  - `--m3e-elevated-button-unselected-container-color`: Unselected container color, for the elevated variant.
  - `--m3e-elevated-button-selected-label-text-color`: Selected label color, for the elevated variant.
  - `--m3e-elevated-button-selected-icon-color`: Selected icon color, for the elevated variant.
  - `--m3e-elevated-button-selected-container-color`: Selected container color, for the elevated variant.
  - `--m3e-elevated-button-disabled-container-color`: Disabled container color, for the elevated variant.
  - `--m3e-elevated-button-disabled-container-opacity`: Disabled container opacity, for the elevated variant.
  - `--m3e-elevated-button-disabled-icon-color`: Disabled icon color, for the elevated variant.
  - `--m3e-elevated-button-disabled-icon-opacity`: Disabled icon opacity, for the elevated variant.
  - `--m3e-elevated-button-disabled-label-text-color`: Disabled label color, for the elevated variant.
  - `--m3e-elevated-button-disabled-label-text-opacity`: Disabled label opacity, for the elevated variant.
  - `--m3e-elevated-button-disabled-container-elevation`: Disabled elevation, for the elevated variant.
  - `--m3e-elevated-button-hover-icon-color`: Hover icon color, for the elevated variant.
  - `--m3e-elevated-button-hover-label-text-color`: Hover label color, for the elevated variant.
  - `--m3e-elevated-button-hover-state-layer-color`: Hover state layer color, for the elevated variant.
  - `--m3e-elevated-button-hover-state-layer-opacity`: Hover state layer opacity, for the elevated variant.
  - `--m3e-elevated-button-hover-container-elevation`: Hover elevation, for the elevated variant.
  - `--m3e-elevated-button-hover-unselected-icon-color`: Hover unselected icon color, for the elevated variant.
  - `--m3e-elevated-button-hover-unselected-label-text-color`: Hover unselected label color, for the elevated variant.
  - `--m3e-elevated-button-hover-unselected-state-layer-color`: Hover unselected state layer color, for the elevated variant.
  - `--m3e-elevated-button-hover-selected-icon-color`: Hover selected icon color, for the elevated variant.
  - `--m3e-elevated-button-hover-selected-label-text-color`: Hover selected label color, for the elevated variant.
  - `--m3e-elevated-button-hover-selected-state-layer-color`: Hover selected state layer color, for the elevated variant.
  - `--m3e-elevated-button-focus-icon-color`: Focus icon color, for the elevated variant.
  - `--m3e-elevated-button-focus-label-text-color`: Focus label color, for the elevated variant.
  - `--m3e-elevated-button-focus-state-layer-color`: Focus state layer color, for the elevated variant.
  - `--m3e-elevated-button-focus-state-layer-opacity`: Focus state layer opacity, for the elevated variant.
  - `--m3e-elevated-button-focus-container-elevation`: Focus elevation, for the elevated variant.
  - `--m3e-elevated-button-focus-unselected-label-text-color`: Focus unselected label color, for the elevated variant.
  - `--m3e-elevated-button-focus-unselected-icon-color`: Focus unselected icon color, for the elevated variant.
  - `--m3e-elevated-button-focus-unselected-state-layer-color`: Focus unselected state layer color, for the elevated variant.
  - `--m3e-elevated-button-focus-selected-icon-color`: Focus selected icon color, for the elevated variant.
  - `--m3e-elevated-button-focus-selected-label-text-color`: Focus selected label color, for the elevated variant.
  - `--m3e-elevated-button-focus-selected-state-layer-color`: Focus selected state layer color, for the elevated variant.
  - `--m3e-elevated-button-pressed-icon-color`: Pressed icon color, for the elevated variant.
  - `--m3e-elevated-button-pressed-label-text-color`: Pressed label color, for the elevated variant.
  - `--m3e-elevated-button-pressed-state-layer-color`: Pressed state layer color, for the elevated variant.
  - `--m3e-elevated-button-pressed-state-layer-opacity`: Pressed state layer opacity, for the elevated variant.
  - `--m3e-elevated-button-pressed-container-elevation`: Pressed elevation, for the elevated variant.
  - `--m3e-elevated-button-pressed-unselected-label-text-color`: Pressed unselected label color, for the elevated variant.
  - `--m3e-elevated-button-pressed-unselected-icon-color`: Pressed unselected icon color, for the elevated variant.
  - `--m3e-elevated-button-pressed-unselected-state-layer-color`: Pressed unselected state layer color, for the elevated variant.
  - `--m3e-elevated-button-pressed-selected-icon-color`: Pressed selected icon color, for the elevated variant.
  - `--m3e-elevated-button-pressed-selected-label-text-color`: Pressed selected label color, for the elevated variant.
  - `--m3e-elevated-button-pressed-selected-state-layer-color`: Pressed selected state layer color, for the elevated variant.
  - `--m3e-outlined-button-label-text-color`: Label color, for the outlined variant.
  - `--m3e-outlined-button-icon-color`: Icon color, for the outlined variant.
  - `--m3e-outlined-button-outline-color`: Outline color, for the outlined variant.
  - `--m3e-outlined-button-unselected-label-text-color`: Unselected label color, for the outlined variant.
  - `--m3e-outlined-button-unselected-icon-color`: Unselected icon color, for the outlined variant.
  - `--m3e-outlined-button-selected-label-text-color`: Selected label color, for the outlined variant.
  - `--m3e-outlined-button-selected-icon-color`: Selected icon color, for the outlined variant.
  - `--m3e-outlined-button-selected-container-color`: Selected container color, for the outlined variant.
  - `--m3e-outlined-button-disabled-container-color`: Disabled container color, for the outlined variant.
  - `--m3e-outlined-button-disabled-container-opacity`: Disabled container opacity, for the outlined variant.
  - `--m3e-outlined-button-disabled-icon-color`: Disabled icon color, for the outlined variant.
  - `--m3e-outlined-button-disabled-icon-opacity`: Disabled icon opacity, for the outlined variant.
  - `--m3e-outlined-button-disabled-label-text-color`: Disabled label color, for the outlined variant.
  - `--m3e-outlined-button-disabled-label-text-opacity`: Disabled label opacity, for the outlined variant.
  - `--m3e-outlined-button-disabled-outline-color`: Disabled outline color, for the outlined variant.
  - `--m3e-outlined-button-hover-icon-color`: Hover icon color, for the outlined variant.
  - `--m3e-outlined-button-hover-label-text-color`: Hover label color, for the outlined variant.
  - `--m3e-outlined-button-hover-outline-color`: Hover outline color, for the outlined variant.
  - `--m3e-outlined-button-hover-state-layer-color`: Hover state layer color, for the outlined variant.
  - `--m3e-outlined-button-hover-state-layer-opacity`: Hover state layer opacity, for the outlined variant.
  - `--m3e-outlined-button-hover-unselected-icon-color`: Hover unselected icon color, for the outlined variant.
  - `--m3e-outlined-button-hover-unselected-label-text-color`: Hover unselected label color, for the outlined variant.
  - `--m3e-outlined-button-hover-unselected-state-layer-color`: Hover unselected state layer color, for the outlined variant.
  - `--m3e-outlined-button-hover-selected-icon-color`: Hover selected icon color, for the outlined variant.
  - `--m3e-outlined-button-hover-selected-label-text-color`: Hover selected label color, for the outlined variant.
  - `--m3e-outlined-button-hover-selected-state-layer-color`: Hover selected state layer color, for the outlined variant.
  - `--m3e-outlined-button-focus-icon-color`: Focus icon color, for the outlined variant.
  - `--m3e-outlined-button-focus-label-text-color`: Focus label color, for the outlined variant.
  - `--m3e-outlined-button-focus-outline-color`: Focus outline color, for the outlined variant.
  - `--m3e-outlined-button-focus-state-layer-color`: Focus state layer color, for the outlined variant.
  - `--m3e-outlined-button-focus-state-layer-opacity`: Focus state layer opacity, for the outlined variant.
  - `--m3e-outlined-button-focus-unselected-icon-color`: Focus unselected icon color, for the outlined variant.
  - `--m3e-outlined-button-focus-unselected-label-text-color`: Focus unselected label color, for the outlined variant.
  - `--m3e-outlined-button-focus-unselected-state-layer-color`: Focus unselected state layer color, for the outlined variant.
  - `--m3e-outlined-button-focus-selected-icon-color`: Focus selected icon color, for the outlined variant.
  - `--m3e-outlined-button-focus-selected-label-text-color`: Focus selected label color, for the outlined variant.
  - `--m3e-outlined-button-focus-selected-state-layer-color`: Focus selected state layer color, for the outlined variant.
  - `--m3e-outlined-button-pressed-icon-color`: Pressed icon color, for the outlined variant.
  - `--m3e-outlined-button-pressed-label-text-color`: Pressed label color, for the outlined variant.
  - `--m3e-outlined-button-pressed-outline-color`: Pressed outline color, for the outlined variant.
  - `--m3e-outlined-button-pressed-state-layer-color`: Pressed state layer color, for the outlined variant.
  - `--m3e-outlined-button-pressed-state-layer-opacity`: Pressed state layer opacity, for the outlined variant.
  - `--m3e-outlined-button-pressed-unselected-icon-color`: Pressed unselected icon color, for the outlined variant.
  - `--m3e-outlined-button-pressed-unselected-label-text-color`: Pressed unselected label color, for the outlined variant.
  - `--m3e-outlined-button-pressed-unselected-state-layer-color`: Pressed unselected state layer color, for the outlined variant.
  - `--m3e-outlined-button-pressed-selected-icon-color`: Pressed selected icon color, for the outlined variant.
  - `--m3e-outlined-button-pressed-selected-label-text-color`: Pressed selected label color, for the outlined variant.
  - `--m3e-outlined-button-pressed-selected-state-layer-color`: Pressed selected state layer color, for the outlined variant.
  - `--m3e-filled-button-label-text-color`: Label color, for the filled variant.
  - `--m3e-filled-button-icon-color`: Icon color, for the filled variant.
  - `--m3e-filled-button-container-color`: Container background color, for the filled variant.
  - `--m3e-filled-button-container-elevation`: Elevation, for the filled variant.
  - `--m3e-filled-button-unselected-label-text-color`: Unselected label color, for the filled variant.
  - `--m3e-filled-button-unselected-icon-color`: Unselected icon color, for the filled variant.
  - `--m3e-filled-button-unselected-container-color`: Unselected container color, for the filled variant.
  - `--m3e-filled-button-selected-label-text-color`: Selected label color, for the filled variant.
  - `--m3e-filled-button-selected-icon-color`: Selected icon color, for the filled variant.
  - `--m3e-filled-button-selected-container-color`: Selected container color, for the filled variant.
  - `--m3e-filled-button-disabled-container-color`: Disabled container color, for the filled variant.
  - `--m3e-filled-button-disabled-container-opacity`: Disabled container opacity, for the filled variant.
  - `--m3e-filled-button-disabled-icon-color`: Disabled icon color, for the filled variant.
  - `--m3e-filled-button-disabled-icon-opacity`: Disabled icon opacity, for the filled variant.
  - `--m3e-filled-button-disabled-label-text-color`: Disabled label color, for the filled variant.
  - `--m3e-filled-button-disabled-label-text-opacity`: Disabled label opacity, for the filled variant.
  - `--m3e-filled-button-disabled-container-elevation`: Disabled elevation, for the filled variant.
  - `--m3e-filled-button-hover-icon-color`: Hover icon color, for the filled variant.
  - `--m3e-filled-button-hover-label-text-color`: Hover label color, for the filled variant.
  - `--m3e-filled-button-hover-state-layer-color`: Hover state layer color, for the filled variant.
  - `--m3e-filled-button-hover-state-layer-opacity`: Hover state layer opacity, for the filled variant.
  - `--m3e-filled-button-hover-container-elevation`: Hover elevation, for the filled variant.
  - `--m3e-filled-button-hover-unselected-icon-color`: Hover unselected icon color, for the filled variant.
  - `--m3e-filled-button-hover-unselected-label-text-color`: Hover unselected label color, for the filled variant.
  - `--m3e-filled-button-hover-unselected-state-layer-color`: Hover unselected state layer color, for the filled variant.
  - `--m3e-filled-button-hover-selected-icon-color`: Hover selected icon color, for the filled variant.
  - `--m3e-filled-button-hover-selected-label-text-color`: Hover selected label color, for the filled variant.
  - `--m3e-filled-button-hover-selected-state-layer-color`: Hover selected state layer color, for the filled variant.
  - `--m3e-filled-button-focus-icon-color`: Focus icon color, for the filled variant.
  - `--m3e-filled-button-focus-label-text-color`: Focus label color, for the filled variant.
  - `--m3e-filled-button-focus-state-layer-color`: Focus state layer color, for the filled variant.
  - `--m3e-filled-button-focus-state-layer-opacity`: Focus state layer opacity, for the filled variant.
  - `--m3e-filled-button-focus-container-elevation`: Focus elevation, for the filled variant.
  - `--m3e-filled-button-focus-unselected-icon-color`: Focus unselected icon color, for the filled variant.
  - `--m3e-filled-button-focus-unselected-label-text-color`: Focus unselected label color, for the filled variant.
  - `--m3e-filled-button-focus-unselected-state-layer-color`: Focus unselected state layer color, for the filled variant.
  - `--m3e-filled-button-focus-selected-icon-color`: Focus selected icon color, for the filled variant.
  - `--m3e-filled-button-focus-selected-label-text-color`: Focus selected label color, for the filled variant.
  - `--m3e-filled-button-focus-selected-state-layer-color`: Focus selected state layer color, for the filled variant.
  - `--m3e-filled-button-pressed-icon-color`: Pressed icon color, for the filled variant.
  - `--m3e-filled-button-pressed-label-text-color`: Pressed label color, for the filled variant.
  - `--m3e-filled-button-pressed-state-layer-color`: Pressed state layer color, for the filled variant.
  - `--m3e-filled-button-pressed-state-layer-opacity`: Pressed state layer opacity, for the filled variant.
  - `--m3e-filled-button-pressed-container-elevation`: Pressed elevation, for the filled variant.
  - `--m3e-filled-button-pressed-unselected-icon-color`: Pressed unselected icon color, for the filled variant.
  - `--m3e-filled-button-pressed-unselected-label-text-color`: Pressed unselected label color, for the filled variant.
  - `--m3e-filled-button-pressed-unselected-state-layer-color`: Pressed unselected state layer color, for the filled variant.
  - `--m3e-filled-button-pressed-selected-icon-color`: Pressed selected icon color, for the filled variant.
  - `--m3e-filled-button-pressed-selected-label-text-color`: Pressed selected label color, for the filled variant.
  - `--m3e-filled-button-pressed-selected-state-layer-color`: Pressed selected state layer color, for the filled variant.
  - `--m3e-tonal-button-label-text-color`: Label color, for the tonal variant.
  - `--m3e-tonal-button-icon-color`: Icon color, for the tonal variant.
  - `--m3e-tonal-button-container-color`: Container background color, for the tonal variant.
  - `--m3e-tonal-button-container-elevation`: Elevation, for the tonal variant.
  - `--m3e-tonal-button-unselected-label-text-color`: Unselected label color, for the tonal variant.
  - `--m3e-tonal-button-unselected-icon-color`: Unselected icon color, for the tonal variant.
  - `--m3e-tonal-button-unselected-container-color`: Unselected container color, for the tonal variant.
  - `--m3e-tonal-button-selected-label-text-color`: Selected label color, for the tonal variant.
  - `--m3e-tonal-button-selected-icon-color`: Selected icon color, for the tonal variant.
  - `--m3e-tonal-button-selected-container-color`: Selected container color, for the tonal variant.
  - `--m3e-tonal-button-disabled-container-color`: Disabled container color, for the tonal variant.
  - `--m3e-tonal-button-disabled-container-opacity`: Disabled container opacity, for the tonal variant.
  - `--m3e-tonal-button-disabled-icon-color`: Disabled icon color, for the tonal variant.
  - `--m3e-tonal-button-disabled-icon-opacity`: Disabled icon opacity, for the tonal variant.
  - `--m3e-tonal-button-disabled-label-text-color`: Disabled label color, for the tonal variant.
  - `--m3e-tonal-button-disabled-label-text-opacity`: Disabled label opacity, for the tonal variant.
  - `--m3e-tonal-button-disabled-container-elevation`: Disabled elevation, for the tonal variant.
  - `--m3e-tonal-button-hover-icon-color`: Hover icon color, for the tonal variant.
  - `--m3e-tonal-button-hover-label-text-color`: Hover label color, for the tonal variant.
  - `--m3e-tonal-button-hover-state-layer-color`: Hover state layer color, for the tonal variant.
  - `--m3e-tonal-button-hover-state-layer-opacity`: Hover state layer opacity, for the tonal variant.
  - `--m3e-tonal-button-hover-container-elevation`: Hover elevation, for the tonal variant.
  - `--m3e-tonal-button-hover-unselected-icon-color`: Hover unselected icon color, for the tonal variant.
  - `--m3e-tonal-button-hover-unselected-label-text-color`: Hover unselected label color, for the tonal variant.
  - `--m3e-tonal-button-hover-unselected-state-layer-color`: Hover unselected state layer color, for the tonal variant.
  - `--m3e-tonal-button-hover-selected-icon-color`: Hover selected icon color, for the tonal variant.
  - `--m3e-tonal-button-hover-selected-label-text-color`: Hover selected label color, for the tonal variant.
  - `--m3e-tonal-button-hover-selected-state-layer-color`: Hover selected state layer color, for the tonal variant.
  - `--m3e-tonal-button-focus-icon-color`: Focus icon color, for the tonal variant.
  - `--m3e-tonal-button-focus-label-text-color`: Focus label color, for the tonal variant.
  - `--m3e-tonal-button-focus-state-layer-color`: Focus state layer color, for the tonal variant.
  - `--m3e-tonal-button-focus-state-layer-opacity`: Focus state layer opacity, for the tonal variant.
  - `--m3e-tonal-button-focus-container-elevation`: Focus elevation, for the tonal variant.
  - `--m3e-tonal-button-focus-unselected-icon-color`: Focus unselected icon color, for the tonal variant.
  - `--m3e-tonal-button-focus-unselected-label-text-color`: Focus unselected label color, for the tonal variant.
  - `--m3e-tonal-button-focus-unselected-state-layer-color`: Focus unselected state layer color, for the tonal variant.
  - `--m3e-tonal-button-focus-selected-icon-color`: Focus selected icon color, for the tonal variant.
  - `--m3e-tonal-button-focus-selected-label-text-color`: Focus selected label color, for the tonal variant.
  - `--m3e-tonal-button-focus-selected-state-layer-color`: Focus selected state layer color, for the tonal variant.
  - `--m3e-tonal-button-pressed-icon-color`: Pressed icon color, for the tonal variant.
  - `--m3e-tonal-button-pressed-label-text-color`: Pressed label color, for the tonal variant.
  - `--m3e-tonal-button-pressed-state-layer-color`: Pressed state layer color, for the tonal variant.
  - `--m3e-tonal-button-pressed-state-layer-opacity`: Pressed state layer opacity, for the tonal variant.
  - `--m3e-tonal-button-pressed-container-elevation`: Pressed elevation, for the tonal variant.
  - `--m3e-tonal-button-pressed-unselected-icon-color`: Pressed unselected icon color, for the tonal variant.
  - `--m3e-tonal-button-pressed-unselected-label-text-color`: Pressed unselected label color, for the tonal variant.
  - `--m3e-tonal-button-pressed-unselected-state-layer-color`: Pressed unselected state layer color, for the tonal variant.
  - `--m3e-tonal-button-pressed-selected-icon-color`: Pressed selected icon color, for the tonal variant.
  - `--m3e-tonal-button-pressed-selected-label-text-color`: Pressed selected label color, for the tonal variant.
  - `--m3e-tonal-button-pressed-selected-state-layer-color`: Pressed selected state layer color, for the tonal variant.
  - `--m3e-text-button-label-text-color`: Label color, for the text variant.
  - `--m3e-text-button-icon-color`: Icon color, for the text variant.
  - `--m3e-text-button-unselected-label-text-color`: Unselected label color, for the text variant.
  - `--m3e-text-button-unselected-icon-color`: Unselected icon color, for the text variant.
  - `--m3e-text-button-selected-label-text-color`: Selected label color, for the text variant.
  - `--m3e-text-button-selected-icon-color`: Selected icon color, for the text variant.
  - `--m3e-text-button-disabled-container-color`: Disabled container color, for the text variant.
  - `--m3e-text-button-disabled-container-opacity`: Disabled container opacity, for the text variant.
  - `--m3e-text-button-disabled-icon-color`: Disabled icon color, for the text variant.
  - `--m3e-text-button-disabled-icon-opacity`: Disabled icon opacity, for the text variant.
  - `--m3e-text-button-disabled-label-text-color`: Disabled label color, for the text variant.
  - `--m3e-text-button-disabled-label-text-opacity`: Disabled label opacity, for the text variant.
  - `--m3e-text-button-hover-icon-color`: Hover icon color, for the text variant.
  - `--m3e-text-button-hover-label-text-color`: Hover label color, for the text variant.
  - `--m3e-text-button-hover-state-layer-color`: Hover state layer color, for the text variant.
  - `--m3e-text-button-hover-state-layer-opacity`: Hover state layer opacity, for the text variant.
  - `--m3e-text-button-hover-unselected-icon-color`: Hover unselected icon color, for the text variant.
  - `--m3e-text-button-hover-unselected-label-text-color`: Hover unselected label color, for the text variant.
  - `--m3e-text-button-hover-unselected-state-layer-color`: Hover unselected state layer color, for the text variant.
  - `--m3e-text-button-hover-selected-icon-color`: Hover selected icon color, for the text variant.
  - `--m3e-text-button-hover-selected-label-text-color`: Hover selected label color, for the text variant.
  - `--m3e-text-button-hover-selected-state-layer-color`: Hover selected state layer color, for the text variant.
  - `--m3e-text-button-focus-icon-color`: Focus icon color, for the text variant.
  - `--m3e-text-button-focus-label-text-color`: Focus label color, for the text variant.
  - `--m3e-text-button-focus-state-layer-color`: Focus state layer color, for the text variant.
  - `--m3e-text-button-focus-state-layer-opacity`: Focus state layer opacity, for the text variant.
  - `--m3e-text-button-focus-unselected-icon-color`: Focus unselected icon color, for the text variant.
  - `--m3e-text-button-focus-unselected-label-text-color`: Focus unselected label color, for the text variant.
  - `--m3e-text-button-focus-unselected-state-layer-color`: Focus unselected state layer color, for the text variant.
  - `--m3e-text-button-focus-selected-icon-color`: Focus selected icon color, for the text variant.
  - `--m3e-text-button-focus-selected-label-text-color`: Focus selected label color, for the text variant.
  - `--m3e-text-button-focus-selected-state-layer-color`: Focus selected state layer color, for the text variant.
  - `--m3e-text-button-pressed-icon-color`: Pressed icon color, for the text variant.
  - `--m3e-text-button-pressed-label-text-color`: Pressed label color, for the text variant.
  - `--m3e-text-button-pressed-state-layer-color`: Pressed state layer color, for the text variant.
  - `--m3e-text-button-pressed-state-layer-opacity`: Pressed state layer opacity, for the text variant.
  - `--m3e-text-button-pressed-unselected-icon-color`: Pressed unselected icon color, for the text variant.
  - `--m3e-text-button-pressed-unselected-label-text-color`: Pressed unselected label color, for the text variant.
  - `--m3e-text-button-pressed-unselected-state-layer-color`: Pressed unselected state layer color, for the text variant.
  - `--m3e-text-button-pressed-selected-icon-color`: Pressed selected icon color, for the text variant.
  - `--m3e-text-button-pressed-selected-label-text-color`: Pressed selected label color, for the text variant.
  - `--m3e-text-button-pressed-selected-state-layer-color`: Pressed selected state layer color, for the text variant.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-button" attributes children


{-| Whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the element is disabled and interactive. (default: `false`)
-}
disabledInteractive : Bool -> Html.Attribute msg
disabledInteractive val_ =
    Html.Attributes.property "disabled-interactive" (Json.Encode.bool val_)


{-| A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file. (default: `null`)
-}
download : String -> Html.Attribute msg
download val_ =
    Html.Attributes.attribute "download" val_


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> Html.Attribute msg
href val_ =
    Html.Attributes.attribute "href" val_


{-| The name of the element, submitted as a pair with the element's `value` as part of form data, when the element is used to submit a form.
-}
name : String -> Html.Attribute msg
name val_ =
    Html.Attributes.attribute "name" val_


{-| The relationship between the `target` of the link button and the document. (default: `""`)
-}
rel : String -> Html.Attribute msg
rel val_ =
    Html.Attributes.attribute "rel" val_


{-| Whether the toggle button is selected. (default: `false`)
-}
selected : Bool -> Html.Attribute msg
selected =
    Html.Attributes.selected


{-| The shape of the button. (default: `"rounded"`)
-}
shape :
    Cem.M3e.Common.Value
        { rounded : Cem.M3e.Common.Supported
        , square : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
shape =
    Cem.M3e.Common.shape


{-| The size of the button. (default: `"small"`)
-}
size :
    Cem.M3e.Common.Value
        { extraLarge : Cem.M3e.Common.Supported
        , extraSmall : Cem.M3e.Common.Supported
        , large : Cem.M3e.Common.Supported
        , medium : Cem.M3e.Common.Supported
        , small : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
size =
    Cem.M3e.Common.size


{-| The target of the link button. (default: `""`)
-}
target : String -> Html.Attribute msg
target val_ =
    Html.Attributes.attribute "target" val_


{-| Whether the button will toggle between selected and unselected states. (default: `false`)
-}
toggle : Bool -> Html.Attribute msg
toggle val_ =
    Html.Attributes.property "toggle" (Json.Encode.bool val_)


{-| The type of the element. (default: `"button"`)
-}
type_ :
    Cem.M3e.Common.Value
        { button : Cem.M3e.Common.Supported
        , reset : Cem.M3e.Common.Supported
        , submit : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
type_ =
    Cem.M3e.Common.type_


{-| The value associated with the element's name when it's submitted with form data.
-}
value : String -> Html.Attribute msg
value =
    Html.Attributes.value


{-| The appearance variant of the button. (default: `"text"`)
-}
variant :
    Cem.M3e.Common.Value
        { elevated : Cem.M3e.Common.Supported
        , filled : Cem.M3e.Common.Supported
        , outlined : Cem.M3e.Common.Supported
        , text : Cem.M3e.Common.Supported
        , tonal : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant


{-| Dispatched before a toggle button's selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when a toggle button's selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Dispatched when a toggle button's selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched when the element is clicked.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders an icon before the button's label.
-}
iconSlot : Html.Attribute msg
iconSlot =
    Html.Attributes.attribute "slot" "icon"


{-| Renders the label of the button, when selected.
-}
selectedSlot : Html.Attribute msg
selectedSlot =
    Html.Attributes.attribute "slot" "selected"


{-| Renders an icon before the button's label, when selected.
-}
selectedIconSlot : Html.Attribute msg
selectedIconSlot =
    Html.Attributes.attribute "slot" "selected-icon"


{-| Renders an icon after the button's label.
-}
trailingIconSlot : Html.Attribute msg
trailingIconSlot =
    Html.Attributes.attribute "slot" "trailing-icon"
