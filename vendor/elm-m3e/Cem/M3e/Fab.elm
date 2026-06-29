module Cem.M3e.Fab exposing
    ( component, disabled, disabledInteractive, download, extended, href
    , lowered, name, rel, size, target, type_
    , value, variant, onClick, labelSlot, closeIconSlot
    )

{-| A floating action button (FAB) used to present important actions.

@docs component, disabled, disabledInteractive, download, extended, href
@docs lowered, name, rel, size, target, type_
@docs value, variant, onClick, labelSlot, closeIconSlot

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A floating action button (FAB) used to present important actions.

**Events:**

  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `label`: Renders the label of an extended button.
  - `close-icon`: Renders the close icon when used to open a FAB menu.

**CSS Custom Properties:**

  - `--m3e-fab-container-height`: Height of the FAB container for all size variants.
  - `--m3e-fab-label-text-font-size`: Font size for the FAB label text for all size variants.
  - `--m3e-fab-label-text-font-weight`: Font weight for the FAB label text for all size variants.
  - `--m3e-fab-label-text-line-height`: Line height for the FAB label text for all size variants.
  - `--m3e-fab-label-text-tracking`: Letter spacing (tracking) for the FAB label text for all size variants.
  - `--m3e-fab-icon-size`: Icon size for the FAB for all size variants.
  - `--m3e-fab-shape`: Border radius for the FAB for all size variants.
  - `--m3e-fab-leading-space`: Leading space for the FAB for all size variants.
  - `--m3e-fab-trailing-space`: Trailing space for the FAB for all size variants.
  - `--m3e-fab-icon-label-space`: Space between icon and label for the FAB for all size variants.
  - `--m3e-fab-small-container-height`: Height of the small FAB container.
  - `--m3e-fab-small-label-text-font-size`: Font size for the small FAB label text.
  - `--m3e-fab-small-label-text-font-weight`: Font weight for the small FAB label text.
  - `--m3e-fab-small-label-text-line-height`: Line height for the small FAB label text.
  - `--m3e-fab-small-label-text-tracking`: Letter spacing (tracking) for the small FAB label text.
  - `--m3e-fab-small-icon-size`: Icon size for the small FAB.
  - `--m3e-fab-small-shape`: Border radius for the small FAB.
  - `--m3e-fab-small-leading-space`: Leading space for the small FAB.
  - `--m3e-fab-small-trailing-space`: Trailing space for the small FAB.
  - `--m3e-fab-small-icon-label-space`: Space between icon and label for the small FAB.
  - `--m3e-fab-medium-container-height`: Height of the medium FAB container.
  - `--m3e-fab-medium-label-text-font-size`: Font size for the medium FAB label text.
  - `--m3e-fab-medium-label-text-font-weight`: Font weight for the medium FAB label text.
  - `--m3e-fab-medium-label-text-line-height`: Line height for the medium FAB label text.
  - `--m3e-fab-medium-label-text-tracking`: Letter spacing (tracking) for the medium FAB label text.
  - `--m3e-fab-medium-icon-size`: Icon size for the medium FAB.
  - `--m3e-fab-medium-shape`: Border radius for the medium FAB.
  - `--m3e-fab-medium-leading-space`: Leading space for the medium FAB.
  - `--m3e-fab-medium-trailing-space`: Trailing space for the medium FAB.
  - `--m3e-fab-medium-icon-label-space`: Space between icon and label for the medium FAB.
  - `--m3e-fab-large-container-height`: Height of the large FAB container.
  - `--m3e-fab-large-label-text-font-size`: Font size for the large FAB label text.
  - `--m3e-fab-large-label-text-font-weight`: Font weight for the large FAB label text.
  - `--m3e-fab-large-label-text-line-height`: Line height for the large FAB label text.
  - `--m3e-fab-large-label-text-tracking`: Letter spacing (tracking) for the large FAB label text.
  - `--m3e-fab-large-icon-size`: Icon size for the large FAB.
  - `--m3e-fab-large-shape`: Border radius for the large FAB.
  - `--m3e-fab-large-leading-space`: Leading space for the large FAB.
  - `--m3e-fab-large-trailing-space`: Trailing space for the large FAB.
  - `--m3e-fab-large-icon-label-space`: Space between icon and label for the large FAB.
  - `--m3e-fab-label-text-color`: Default label text color for FAB (all variants).
  - `--m3e-fab-icon-color`: Default icon color for FAB (all variants).
  - `--m3e-fab-container-color`: Default container background color for FAB (all variants).
  - `--m3e-fab-container-elevation`: Resting elevation for FAB (all variants).
  - `--m3e-fab-lowered-container-elevation`: Lowered resting elevation for FAB (all variants).
  - `--m3e-fab-disabled-container-color`: Container background color when disabled (all variants).
  - `--m3e-fab-disabled-container-opacity`: Opacity of container when disabled (all variants).
  - `--m3e-fab-disabled-icon-color`: Icon color when disabled (all variants).
  - `--m3e-fab-disabled-icon-opacity`: Icon opacity when disabled (all variants).
  - `--m3e-fab-disabled-label-text-color`: Label text color when disabled (all variants).
  - `--m3e-fab-disabled-label-text-opacity`: Label text opacity when disabled (all variants).
  - `--m3e-fab-disabled-container-elevation`: Elevation when disabled (all variants).
  - `--m3e-fab-lowered-disabled-container-elevation`: Lowered elevation when disabled (all variants).
  - `--m3e-fab-hover-icon-color`: Icon color on hover (all variants).
  - `--m3e-fab-hover-label-text-color`: Label text color on hover (all variants).
  - `--m3e-fab-hover-state-layer-color`: State layer color on hover (all variants).
  - `--m3e-fab-hover-state-layer-opacity`: State layer opacity on hover (all variants).
  - `--m3e-fab-hover-container-elevation`: Elevation on hover (all variants).
  - `--m3e-fab-lowered-hover-container-elevation`: Lowered elevation on hover (all variants).
  - `--m3e-fab-focus-icon-color`: Icon color on focus (all variants).
  - `--m3e-fab-focus-label-text-color`: Label text color on focus (all variants).
  - `--m3e-fab-focus-state-layer-color`: State layer color on focus (all variants).
  - `--m3e-fab-focus-state-layer-opacity`: State layer opacity on focus (all variants).
  - `--m3e-fab-focus-container-elevation`: Elevation on focus (all variants).
  - `--m3e-fab-lowered-focus-container-elevation`: Lowered elevation on focus (all variants).
  - `--m3e-fab-pressed-icon-color`: Icon color on pressed (all variants).
  - `--m3e-fab-pressed-label-text-color`: Label text color on pressed (all variants).
  - `--m3e-fab-pressed-state-layer-color`: State layer color on pressed (all variants).
  - `--m3e-fab-pressed-state-layer-opacity`: State layer opacity on pressed (all variants).
  - `--m3e-fab-pressed-container-elevation`: Elevation on pressed (all variants).
  - `--m3e-fab-lowered-pressed-container-elevation`: Lowered elevation on pressed (all variants).
  - `--m3e-primary-fab-label-text-color`: Default label text color for primary FAB.
  - `--m3e-primary-fab-icon-color`: Default icon color for primary FAB.
  - `--m3e-primary-fab-container-color`: Default container background color for primary FAB.
  - `--m3e-primary-fab-container-elevation`: Resting elevation for primary FAB.
  - `--m3e-primary-fab-lowered-container-elevation`: Lowered resting elevation for primary FAB.
  - `--m3e-primary-fab-disabled-container-color`: Container background color when disabled (primary).
  - `--m3e-primary-fab-disabled-container-opacity`: Opacity of container when disabled (primary).
  - `--m3e-primary-fab-disabled-icon-color`: Icon color when disabled (primary).
  - `--m3e-primary-fab-disabled-icon-opacity`: Icon opacity when disabled (primary).
  - `--m3e-primary-fab-disabled-label-text-color`: Label text color when disabled (primary).
  - `--m3e-primary-fab-disabled-label-text-opacity`: Label text opacity when disabled (primary).
  - `--m3e-primary-fab-disabled-container-elevation`: Elevation when disabled (primary).
  - `--m3e-primary-fab-lowered-disabled-container-elevation`: Lowered elevation when disabled (primary).
  - `--m3e-primary-fab-hover-icon-color`: Icon color on hover (primary).
  - `--m3e-primary-fab-hover-label-text-color`: Label text color on hover (primary).
  - `--m3e-primary-fab-hover-state-layer-color`: State layer color on hover (primary).
  - `--m3e-primary-fab-hover-state-layer-opacity`: State layer opacity on hover (primary).
  - `--m3e-primary-fab-hover-container-elevation`: Elevation on hover (primary).
  - `--m3e-primary-fab-lowered-hover-container-elevation`: Lowered elevation on hover (primary).
  - `--m3e-primary-fab-focus-icon-color`: Icon color on focus (primary).
  - `--m3e-primary-fab-focus-label-text-color`: Label text color on focus (primary).
  - `--m3e-primary-fab-focus-state-layer-color`: State layer color on focus (primary).
  - `--m3e-primary-fab-focus-state-layer-opacity`: State layer opacity on focus (primary).
  - `--m3e-primary-fab-focus-container-elevation`: Elevation on focus (primary).
  - `--m3e-primary-fab-lowered-focus-container-elevation`: Lowered elevation on focus (primary).
  - `--m3e-primary-fab-pressed-icon-color`: Icon color on pressed (primary).
  - `--m3e-primary-fab-pressed-label-text-color`: Label text color on pressed (primary).
  - `--m3e-primary-fab-pressed-state-layer-color`: State layer color on pressed (primary).
  - `--m3e-primary-fab-pressed-state-layer-opacity`: State layer opacity on pressed (primary).
  - `--m3e-primary-fab-pressed-container-elevation`: Elevation on pressed (primary).
  - `--m3e-primary-fab-lowered-pressed-container-elevation`: Lowered elevation on pressed (primary).
  - `--m3e-secondary-fab-label-text-color`: Default label text color for secondary FAB.
  - `--m3e-secondary-fab-icon-color`: Default icon color for secondary FAB.
  - `--m3e-secondary-fab-container-color`: Default container background color for secondary FAB.
  - `--m3e-secondary-fab-container-elevation`: Resting elevation for secondary FAB.
  - `--m3e-secondary-fab-lowered-container-elevation`: Lowered resting elevation for secondary FAB.
  - `--m3e-secondary-fab-disabled-container-color`: Container background color when disabled (secondary).
  - `--m3e-secondary-fab-disabled-container-opacity`: Opacity of container when disabled (secondary).
  - `--m3e-secondary-fab-disabled-icon-color`: Icon color when disabled (secondary).
  - `--m3e-secondary-fab-disabled-icon-opacity`: Icon opacity when disabled (secondary).
  - `--m3e-secondary-fab-disabled-label-text-color`: Label text color when disabled (secondary).
  - `--m3e-secondary-fab-disabled-label-text-opacity`: Label text opacity when disabled (secondary).
  - `--m3e-secondary-fab-disabled-container-elevation`: Elevation when disabled (secondary).
  - `--m3e-secondary-fab-lowered-disabled-container-elevation`: Lowered elevation when disabled (secondary).
  - `--m3e-secondary-fab-hover-icon-color`: Icon color on hover (secondary).
  - `--m3e-secondary-fab-hover-label-text-color`: Label text color on hover (secondary).
  - `--m3e-secondary-fab-hover-state-layer-color`: State layer color on hover (secondary).
  - `--m3e-secondary-fab-hover-state-layer-opacity`: State layer opacity on hover (secondary).
  - `--m3e-secondary-fab-hover-container-elevation`: Elevation on hover (secondary).
  - `--m3e-secondary-fab-lowered-hover-container-elevation`: Lowered elevation on hover (secondary).
  - `--m3e-secondary-fab-focus-icon-color`: Icon color on focus (secondary).
  - `--m3e-secondary-fab-focus-label-text-color`: Label text color on focus (secondary).
  - `--m3e-secondary-fab-focus-state-layer-color`: State layer color on focus (secondary).
  - `--m3e-secondary-fab-focus-state-layer-opacity`: State layer opacity on focus (secondary).
  - `--m3e-secondary-fab-focus-container-elevation`: Elevation on focus (secondary).
  - `--m3e-secondary-fab-lowered-focus-container-elevation`: Lowered elevation on focus (secondary).
  - `--m3e-secondary-fab-pressed-icon-color`: Icon color on pressed (secondary).
  - `--m3e-secondary-fab-pressed-label-text-color`: Label text color on pressed (secondary).
  - `--m3e-secondary-fab-pressed-state-layer-color`: State layer color on pressed (secondary).
  - `--m3e-secondary-fab-pressed-state-layer-opacity`: State layer opacity on pressed (secondary).
  - `--m3e-secondary-fab-pressed-container-elevation`: Elevation on pressed (secondary).
  - `--m3e-secondary-fab-lowered-pressed-container-elevation`: Lowered elevation on pressed (secondary).
  - `--m3e-tertiary-fab-label-text-color`: Default label text color for tertiary FAB.
  - `--m3e-tertiary-fab-icon-color`: Default icon color for tertiary FAB.
  - `--m3e-tertiary-fab-container-color`: Default container background color for tertiary FAB.
  - `--m3e-tertiary-fab-container-elevation`: Resting elevation for tertiary FAB.
  - `--m3e-tertiary-fab-lowered-container-elevation`: Lowered resting elevation for tertiary FAB.
  - `--m3e-tertiary-fab-disabled-container-color`: Container background color when disabled (tertiary).
  - `--m3e-tertiary-fab-disabled-container-opacity`: Opacity of container when disabled (tertiary).
  - `--m3e-tertiary-fab-disabled-icon-color`: Icon color when disabled (tertiary).
  - `--m3e-tertiary-fab-disabled-icon-opacity`: Icon opacity when disabled (tertiary).
  - `--m3e-tertiary-fab-disabled-label-text-color`: Label text color when disabled (tertiary).
  - `--m3e-tertiary-fab-disabled-label-text-opacity`: Label text opacity when disabled (tertiary).
  - `--m3e-tertiary-fab-disabled-container-elevation`: Elevation when disabled (tertiary).
  - `--m3e-tertiary-fab-lowered-disabled-container-elevation`: Lowered elevation when disabled (tertiary).
  - `--m3e-tertiary-fab-hover-icon-color`: Icon color on hover (tertiary).
  - `--m3e-tertiary-fab-hover-label-text-color`: Label text color on hover (tertiary).
  - `--m3e-tertiary-fab-hover-state-layer-color`: State layer color on hover (tertiary).
  - `--m3e-tertiary-fab-hover-state-layer-opacity`: State layer opacity on hover (tertiary).
  - `--m3e-tertiary-fab-hover-container-elevation`: Elevation on hover (tertiary).
  - `--m3e-tertiary-fab-lowered-hover-container-elevation`: Lowered elevation on hover (tertiary).
  - `--m3e-tertiary-fab-focus-icon-color`: Icon color on focus (tertiary).
  - `--m3e-tertiary-fab-focus-label-text-color`: Label text color on focus (tertiary).
  - `--m3e-tertiary-fab-focus-state-layer-color`: State layer color on focus (tertiary).
  - `--m3e-tertiary-fab-focus-state-layer-opacity`: State layer opacity on focus (tertiary).
  - `--m3e-tertiary-fab-focus-container-elevation`: Elevation on focus (tertiary).
  - `--m3e-tertiary-fab-lowered-focus-container-elevation`: Lowered elevation on focus (tertiary).
  - `--m3e-tertiary-fab-pressed-icon-color`: Icon color on pressed (tertiary).
  - `--m3e-tertiary-fab-pressed-label-text-color`: Label text color on pressed (tertiary).
  - `--m3e-tertiary-fab-pressed-state-layer-color`: State layer color on pressed (tertiary).
  - `--m3e-tertiary-fab-pressed-state-layer-opacity`: State layer opacity on pressed (tertiary).
  - `--m3e-tertiary-fab-pressed-container-elevation`: Elevation on pressed (tertiary).
  - `--m3e-tertiary-fab-lowered-pressed-container-elevation`: Lowered elevation on pressed (tertiary).
  - `--m3e-primary-container-fab-label-text-color`: Default label text color for primary-container FAB.
  - `--m3e-primary-container-fab-icon-color`: Default icon color for primary-container FAB.
  - `--m3e-primary-container-fab-container-color`: Default container background color for primary-container FAB.
  - `--m3e-primary-container-fab-container-elevation`: Resting elevation for primary-container FAB.
  - `--m3e-primary-container-fab-lowered-container-elevation`: Lowered resting elevation for primary-container FAB.
  - `--m3e-primary-container-fab-disabled-container-color`: Container background color when disabled (primary-container).
  - `--m3e-primary-container-fab-disabled-container-opacity`: Opacity of container when disabled (primary-container).
  - `--m3e-primary-container-fab-disabled-icon-color`: Icon color when disabled (primary-container).
  - `--m3e-primary-container-fab-disabled-icon-opacity`: Icon opacity when disabled (primary-container).
  - `--m3e-primary-container-fab-disabled-label-text-color`: Label text color when disabled (primary-container).
  - `--m3e-primary-container-fab-disabled-label-text-opacity`: Label text opacity when disabled (primary-container).
  - `--m3e-primary-container-fab-disabled-container-elevation`: Elevation when disabled (primary-container).
  - `--m3e-primary-container-fab-lowered-disabled-container-elevation`: Lowered elevation when disabled (primary-container).
  - `--m3e-primary-container-fab-hover-icon-color`: Icon color on hover (primary-container).
  - `--m3e-primary-container-fab-hover-label-text-color`: Label text color on hover (primary-container).
  - `--m3e-primary-container-fab-hover-state-layer-color`: State layer color on hover (primary-container).
  - `--m3e-primary-container-fab-hover-state-layer-opacity`: State layer opacity on hover (primary-container).
  - `--m3e-primary-container-fab-hover-container-elevation`: Elevation on hover (primary-container).
  - `--m3e-primary-container-fab-lowered-hover-container-elevation`: Lowered elevation on hover (primary-container).
  - `--m3e-primary-container-fab-focus-icon-color`: Icon color on focus (primary-container).
  - `--m3e-primary-container-fab-focus-label-text-color`: Label text color on focus (primary-container).
  - `--m3e-primary-container-fab-focus-state-layer-color`: State layer color on focus (primary-container).
  - `--m3e-primary-container-fab-focus-state-layer-opacity`: State layer opacity on focus (primary-container).
  - `--m3e-primary-container-fab-focus-container-elevation`: Elevation on focus (primary-container).
  - `--m3e-primary-container-fab-lowered-focus-container-elevation`: Lowered elevation on focus (primary-container).
  - `--m3e-primary-container-fab-pressed-icon-color`: Icon color on pressed (primary-container).
  - `--m3e-primary-container-fab-pressed-label-text-color`: Label text color on pressed (primary-container).
  - `--m3e-primary-container-fab-pressed-state-layer-color`: State layer color on pressed (primary-container).
  - `--m3e-primary-container-fab-pressed-state-layer-opacity`: State layer opacity on pressed (primary-container).
  - `--m3e-primary-container-fab-pressed-container-elevation`: Elevation on pressed (primary-container).
  - `--m3e-primary-container-fab-lowered-pressed-container-elevation`: Lowered elevation on pressed (primary-container).
  - `--m3e-secondary-container-fab-label-text-color`: Default label text color for secondary-container FAB.
  - `--m3e-secondary-container-fab-icon-color`: Default icon color for secondary-container FAB.
  - `--m3e-secondary-container-fab-container-color`: Default container background color for secondary-container FAB.
  - `--m3e-secondary-container-fab-container-elevation`: Resting elevation for secondary-container FAB.
  - `--m3e-secondary-container-fab-lowered-container-elevation`: Lowered resting elevation for secondary-container FAB.
  - `--m3e-secondary-container-fab-disabled-container-color`: Container background color when disabled (secondary-container).
  - `--m3e-secondary-container-fab-disabled-container-opacity`: Opacity of container when disabled (secondary-container).
  - `--m3e-secondary-container-fab-disabled-icon-color`: Icon color when disabled (secondary-container).
  - `--m3e-secondary-container-fab-disabled-icon-opacity`: Icon opacity when disabled (secondary-container).
  - `--m3e-secondary-container-fab-disabled-label-text-color`: Label text color when disabled (secondary-container).
  - `--m3e-secondary-container-fab-disabled-label-text-opacity`: Label text opacity when disabled (secondary-container).
  - `--m3e-secondary-container-fab-disabled-container-elevation`: Elevation when disabled (secondary-container).
  - `--m3e-secondary-container-fab-lowered-disabled-container-elevation`: Lowered elevation when disabled (secondary-container).
  - `--m3e-secondary-container-fab-hover-icon-color`: Icon color on hover (secondary-container).
  - `--m3e-secondary-container-fab-hover-label-text-color`: Label text color on hover (secondary-container).
  - `--m3e-secondary-container-fab-hover-state-layer-color`: State layer color on hover (secondary-container).
  - `--m3e-secondary-container-fab-hover-state-layer-opacity`: State layer opacity on hover (secondary-container).
  - `--m3e-secondary-container-fab-hover-container-elevation`: Elevation on hover (secondary-container).
  - `--m3e-secondary-container-fab-lowered-hover-container-elevation`: Lowered elevation on hover (secondary-container).
  - `--m3e-secondary-container-fab-focus-icon-color`: Icon color on focus (secondary-container).
  - `--m3e-secondary-container-fab-focus-label-text-color`: Label text color on focus (secondary-container).
  - `--m3e-secondary-container-fab-focus-state-layer-color`: State layer color on focus (secondary-container).
  - `--m3e-secondary-container-fab-focus-state-layer-opacity`: State layer opacity on focus (secondary-container).
  - `--m3e-secondary-container-fab-focus-container-elevation`: Elevation on focus (secondary-container).
  - `--m3e-secondary-container-fab-lowered-focus-container-elevation`: Lowered elevation on focus (secondary-container).
  - `--m3e-secondary-container-fab-pressed-icon-color`: Icon color on pressed (secondary-container).
  - `--m3e-secondary-container-fab-pressed-label-text-color`: Label text color on pressed (secondary-container).
  - `--m3e-secondary-container-fab-pressed-state-layer-color`: State layer color on pressed (secondary-container).
  - `--m3e-secondary-container-fab-pressed-state-layer-opacity`: State layer opacity on pressed (secondary-container).
  - `--m3e-secondary-container-fab-pressed-container-elevation`: Elevation on pressed (secondary-container).
  - `--m3e-secondary-container-fab-lowered-pressed-container-elevation`: Lowered elevation on pressed (secondary-container).
  - `--m3e-tertiary-container-fab-label-text-color`: Default label text color for tertiary-container FAB.
  - `--m3e-tertiary-container-fab-icon-color`: Default icon color for tertiary-container FAB.
  - `--m3e-tertiary-container-fab-container-color`: Default container background color for tertiary-container FAB.
  - `--m3e-tertiary-container-fab-container-elevation`: Resting elevation for tertiary-container FAB.
  - `--m3e-tertiary-container-fab-lowered-container-elevation`: Lowered resting elevation for tertiary-container FAB.
  - `--m3e-tertiary-container-fab-disabled-container-color`: Container background color when disabled (tertiary-container).
  - `--m3e-tertiary-container-fab-disabled-container-opacity`: Opacity of container when disabled (tertiary-container).
  - `--m3e-tertiary-container-fab-disabled-icon-color`: Icon color when disabled (tertiary-container).
  - `--m3e-tertiary-container-fab-disabled-icon-opacity`: Icon opacity when disabled (tertiary-container).
  - `--m3e-tertiary-container-fab-disabled-label-text-color`: Label text color when disabled (tertiary-container).
  - `--m3e-tertiary-container-fab-disabled-label-text-opacity`: Label text opacity when disabled (tertiary-container).
  - `--m3e-tertiary-container-fab-disabled-container-elevation`: Elevation when disabled (tertiary-container).
  - `--m3e-tertiary-container-fab-lowered-disabled-container-elevation`: Lowered elevation when disabled (tertiary-container).
  - `--m3e-tertiary-container-fab-hover-icon-color`: Icon color on hover (tertiary-container).
  - `--m3e-tertiary-container-fab-hover-label-text-color`: Label text color on hover (tertiary-container).
  - `--m3e-tertiary-container-fab-hover-state-layer-color`: State layer color on hover (tertiary-container).
  - `--m3e-tertiary-container-fab-hover-state-layer-opacity`: State layer opacity on hover (tertiary-container).
  - `--m3e-tertiary-container-fab-hover-container-elevation`: Elevation on hover (tertiary-container).
  - `--m3e-tertiary-container-fab-lowered-hover-container-elevation`: Lowered elevation on hover (tertiary-container).
  - `--m3e-tertiary-container-fab-focus-icon-color`: Icon color on focus (tertiary-container).
  - `--m3e-tertiary-container-fab-focus-label-text-color`: Label text color on focus (tertiary-container).
  - `--m3e-tertiary-container-fab-focus-state-layer-color`: State layer color on focus (tertiary-container).
  - `--m3e-tertiary-container-fab-focus-state-layer-opacity`: State layer opacity on focus (tertiary-container).
  - `--m3e-tertiary-container-fab-focus-container-elevation`: Elevation on focus (tertiary-container).
  - `--m3e-tertiary-container-fab-lowered-focus-container-elevation`: Lowered elevation on focus (tertiary-container).
  - `--m3e-tertiary-container-fab-pressed-icon-color`: Icon color on pressed (tertiary-container).
  - `--m3e-tertiary-container-fab-pressed-label-text-color`: Label text color on pressed (tertiary-container).
  - `--m3e-tertiary-container-fab-pressed-state-layer-color`: State layer color on pressed (tertiary-container).
  - `--m3e-tertiary-container-fab-pressed-state-layer-opacity`: State layer opacity on pressed (tertiary-container).
  - `--m3e-tertiary-container-fab-pressed-container-elevation`: Elevation on pressed (tertiary-container).
  - `--m3e-tertiary-container-fab-lowered-pressed-container-elevation`: Lowered elevation on pressed (tertiary-container).
  - `--m3e-surface-fab-label-text-color`: Default label text color for surface FAB.
  - `--m3e-surface-fab-icon-color`: Default icon color for surface FAB.
  - `--m3e-surface-fab-container-color`: Default container background color for surface FAB.
  - `--m3e-surface-fab-container-elevation`: Resting elevation for surface FAB.
  - `--m3e-surface-fab-lowered-container-elevation`: Lowered resting elevation for surface FAB.
  - `--m3e-surface-fab-lowered-container-color`: Lowered container background color for surface FAB.
  - `--m3e-surface-fab-disabled-container-color`: Container background color when disabled (surface).
  - `--m3e-surface-fab-disabled-container-opacity`: Opacity of container when disabled (surface).
  - `--m3e-surface-fab-disabled-icon-color`: Icon color when disabled (surface).
  - `--m3e-surface-fab-disabled-icon-opacity`: Icon opacity when disabled (surface).
  - `--m3e-surface-fab-disabled-label-text-color`: Label text color when disabled (surface).
  - `--m3e-surface-fab-disabled-label-text-opacity`: Label text opacity when disabled (surface).
  - `--m3e-surface-fab-disabled-container-elevation`: Elevation when disabled (surface).
  - `--m3e-surface-fab-lowered-disabled-container-elevation`: Lowered elevation when disabled (surface).
  - `--m3e-surface-fab-hover-icon-color`: Icon color on hover (surface).
  - `--m3e-surface-fab-hover-label-text-color`: Label text color on hover (surface).
  - `--m3e-surface-fab-hover-state-layer-color`: State layer color on hover (surface).
  - `--m3e-surface-fab-hover-state-layer-opacity`: State layer opacity on hover (surface).
  - `--m3e-surface-fab-hover-container-elevation`: Elevation on hover (surface).
  - `--m3e-surface-fab-lowered-hover-container-elevation`: Lowered elevation on hover (surface).
  - `--m3e-surface-fab-focus-icon-color`: Icon color on focus (surface).
  - `--m3e-surface-fab-focus-label-text-color`: Label text color on focus (surface).
  - `--m3e-surface-fab-focus-state-layer-color`: State layer color on focus (surface).
  - `--m3e-surface-fab-focus-state-layer-opacity`: State layer opacity on focus (surface).
  - `--m3e-surface-fab-focus-container-elevation`: Elevation on focus (surface).
  - `--m3e-surface-fab-lowered-focus-container-elevation`: Lowered elevation on focus (surface).
  - `--m3e-surface-fab-pressed-icon-color`: Icon color on pressed (surface).
  - `--m3e-surface-fab-pressed-label-text-color`: Label text color on pressed (surface).
  - `--m3e-surface-fab-pressed-state-layer-color`: State layer color on pressed (surface).
  - `--m3e-surface-fab-pressed-state-layer-opacity`: State layer opacity on pressed (surface).
  - `--m3e-surface-fab-pressed-container-elevation`: Elevation on pressed (surface).
  - `--m3e-surface-fab-lowered-pressed-container-elevation`: Lowered elevation on pressed (surface).

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-fab" attributes children


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


{-| Whether the button is extended to show the label. (default: `false`)
-}
extended : Bool -> Html.Attribute msg
extended val_ =
    Html.Attributes.property "extended" (Json.Encode.bool val_)


{-| The URL to which the link button points. (default: `""`)
-}
href : String -> Html.Attribute msg
href val_ =
    Html.Attributes.attribute "href" val_


{-| Whether to present a lowered elevation. (default: `false`)
-}
lowered : Bool -> Html.Attribute msg
lowered val_ =
    Html.Attributes.property "lowered" (Json.Encode.bool val_)


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


{-| The size of the button. (default: `"medium"`)
-}
size :
    Cem.M3e.Common.Value
        { large : Cem.M3e.Common.Supported
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


{-| The appearance variant of the button. (default: `"primary-container"`)
-}
variant :
    Cem.M3e.Common.Value
        { primary : Cem.M3e.Common.Supported
        , primaryContainer : Cem.M3e.Common.Supported
        , secondary : Cem.M3e.Common.Supported
        , secondaryContainer : Cem.M3e.Common.Supported
        , surface : Cem.M3e.Common.Supported
        , tertiary : Cem.M3e.Common.Supported
        , tertiaryContainer : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant


{-| Dispatched when the element is clicked.

**Payload type:** `MouseEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder


{-| Renders the label of an extended button.
-}
labelSlot : Html.Attribute msg
labelSlot =
    Html.Attributes.attribute "slot" "label"


{-| Renders the close icon when used to open a FAB menu.
-}
closeIconSlot : Html.Attribute msg
closeIconSlot =
    Html.Attributes.attribute "slot" "close-icon"
