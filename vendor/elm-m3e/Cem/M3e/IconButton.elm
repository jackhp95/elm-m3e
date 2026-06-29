module Cem.M3e.IconButton exposing
    ( component, disabled, disabledInteractive, download, href, name
    , rel, selected, shape, size, target, toggle
    , type_, value, variant, width, onBeforeinput, onInput
    , onChange, onClick, selectedSlot
    )

{-| An icon button users interact with to perform a supplementary action.

@docs component, disabled, disabledInteractive, download, href, name
@docs rel, selected, shape, size, target, toggle
@docs type_, value, variant, width, onBeforeinput, onInput
@docs onChange, onClick, selectedSlot

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| An icon button users interact with to perform a supplementary action.

**Events:**

  - `beforeinput`: Dispatched before a toggle button's selected state changes.
  - `input`: Dispatched when a toggle button's selected state changes.
  - `change`: Dispatched when a toggle button's selected state changes.
  - `click`: Dispatched when the element is clicked.

**Slots:**

  - `selected`: Renders an icon, when selected.

**CSS Custom Properties:**

  - `--m3e-icon-button-container-height`: Height of the container for all size variants.
  - `--m3e-icon-button-outline-thickness`: Outline thickness for all size variants.
  - `--m3e-icon-button-icon-size`: Icon size for all size variants.
  - `--m3e-icon-button-shape-round`: Corner radius for all round size variants.
  - `--m3e-icon-button-shape-square`: Corner radius for all square size variants.
  - `--m3e-icon-button-selected-shape-round`: Corner radius for all selected round size variants.
  - `--m3e-icon-button-selected-shape-square`: Corner radius for all selected square size variants.
  - `--m3e-icon-button-shape-pressed-morph`: Corner radius for all pressed size variants.
  - `--m3e-icon-button-narrow-leading-space`: Leading space for all size variants (narrow).
  - `--m3e-icon-button-narrow-trailing-space`: Trailing space for all size variants (narrow).
  - `--m3e-icon-button-default-leading-space`: Leading space for all size variants (default).
  - `--m3e-icon-button-default-trailing-space`: Trailing space for all size variants (default).
  - `--m3e-icon-button-wide-leading-space`: Leading space for all size variants (wide).
  - `--m3e-icon-button-wide-trailing-space`: Trailing space for all size variants (wide).
  - `--m3e-icon-button-extra-small-container-height`: Height of the extra-small container.
  - `--m3e-icon-button-extra-small-outline-thickness`: Outline thickness for extra-small.
  - `--m3e-icon-button-extra-small-icon-size`: Icon size for extra-small.
  - `--m3e-icon-button-extra-small-shape-round`: Corner radius for round extra-small.
  - `--m3e-icon-button-extra-small-shape-square`: Corner radius for square extra-small.
  - `--m3e-icon-button-extra-small-selected-shape-round`: Corner radius for selected round extra-small.
  - `--m3e-icon-button-extra-small-selected-shape-square`: Corner radius for selected square extra-small.
  - `--m3e-icon-button-extra-small-shape-pressed-morph`: Corner radius for pressed extra-small.
  - `--m3e-icon-button-extra-small-narrow-leading-space`: Leading space for extra-small (narrow).
  - `--m3e-icon-button-extra-small-narrow-trailing-space`: Trailing space for extra-small (narrow).
  - `--m3e-icon-button-extra-small-default-leading-space`: Leading space for extra-small (default).
  - `--m3e-icon-button-extra-small-default-trailing-space`: Trailing space for extra-small (default).
  - `--m3e-icon-button-extra-small-wide-leading-space`: Leading space for extra-small (wide).
  - `--m3e-icon-button-extra-small-wide-trailing-space`: Trailing space for extra-small (wide).
  - `--m3e-icon-button-small-container-height`: Height of the small container.
  - `--m3e-icon-button-small-outline-thickness`: Outline thickness for small.
  - `--m3e-icon-button-small-icon-size`: Icon size for small.
  - `--m3e-icon-button-small-shape-round`: Corner radius for round small.
  - `--m3e-icon-button-small-shape-square`: Corner radius for square small.
  - `--m3e-icon-button-small-selected-shape-round`: Corner radius for selected round small.
  - `--m3e-icon-button-small-selected-shape-square`: Corner radius for selected square small.
  - `--m3e-icon-button-small-shape-pressed-morph`: Corner radius for pressed small.
  - `--m3e-icon-button-small-narrow-leading-space`: Leading space for small (narrow).
  - `--m3e-icon-button-small-narrow-trailing-space`: Trailing space for small (narrow).
  - `--m3e-icon-button-small-default-leading-space`: Leading space for small (default).
  - `--m3e-icon-button-small-default-trailing-space`: Trailing space for small (default).
  - `--m3e-icon-button-small-wide-leading-space`: Leading space for small (wide).
  - `--m3e-icon-button-small-wide-trailing-space`: Trailing space for small (wide).
  - `--m3e-icon-button-medium-container-height`: Height of the medium container.
  - `--m3e-icon-button-medium-outline-thickness`: Outline thickness for medium.
  - `--m3e-icon-button-medium-icon-size`: Icon size for medium.
  - `--m3e-icon-button-medium-shape-round`: Corner radius for round medium.
  - `--m3e-icon-button-medium-shape-square`: Corner radius for square medium.
  - `--m3e-icon-button-medium-selected-shape-round`: Corner radius for selected round medium.
  - `--m3e-icon-button-medium-selected-shape-square`: Corner radius for selected square medium.
  - `--m3e-icon-button-medium-shape-pressed-morph`: Corner radius for pressed medium.
  - `--m3e-icon-button-medium-narrow-leading-space`: Leading space for medium (narrow).
  - `--m3e-icon-button-medium-narrow-trailing-space`: Trailing space for medium (narrow).
  - `--m3e-icon-button-medium-default-leading-space`: Leading space for medium (default).
  - `--m3e-icon-button-medium-default-trailing-space`: Trailing space for medium (default).
  - `--m3e-icon-button-medium-wide-leading-space`: Leading space for medium (wide).
  - `--m3e-icon-button-medium-wide-trailing-space`: Trailing space for medium (wide).
  - `--m3e-icon-button-large-container-height`: Height of the large container.
  - `--m3e-icon-button-large-outline-thickness`: Outline thickness for large.
  - `--m3e-icon-button-large-icon-size`: Icon size for large.
  - `--m3e-icon-button-large-shape-round`: Corner radius for round large.
  - `--m3e-icon-button-large-shape-square`: Corner radius for square large.
  - `--m3e-icon-button-large-selected-shape-round`: Corner radius for selected round large.
  - `--m3e-icon-button-large-selected-shape-square`: Corner radius for selected square large.
  - `--m3e-icon-button-large-shape-pressed-morph`: Corner radius for pressed large.
  - `--m3e-icon-button-large-narrow-leading-space`: Leading space for large (narrow).
  - `--m3e-icon-button-large-narrow-trailing-space`: Trailing space for large (narrow).
  - `--m3e-icon-button-large-default-leading-space`: Leading space for large (default).
  - `--m3e-icon-button-large-default-trailing-space`: Trailing space for large (default).
  - `--m3e-icon-button-large-wide-leading-space`: Leading space for large (wide).
  - `--m3e-icon-button-large-wide-trailing-space`: Trailing space for large (wide).
  - `--m3e-icon-button-extra-large-container-height`: Height of the extra-large container.
  - `--m3e-icon-button-extra-large-outline-thickness`: Outline thickness for extra-large.
  - `--m3e-icon-button-extra-large-icon-size`: Icon size for extra-large.
  - `--m3e-icon-button-extra-large-shape-round`: Corner radius for round extra-large.
  - `--m3e-icon-button-extra-large-shape-square`: Corner radius for square extra-large.
  - `--m3e-icon-button-extra-large-selected-shape-round`: Corner radius for selected round extra-large.
  - `--m3e-icon-button-extra-large-selected-shape-square`: Corner radius for selected square extra-large.
  - `--m3e-icon-button-extra-large-shape-pressed-morph`: Corner radius for pressed extra-large.
  - `--m3e-icon-button-extra-large-narrow-leading-space`: Leading space for extra-large (narrow).
  - `--m3e-icon-button-extra-large-narrow-trailing-space`: Trailing space for extra-large (narrow).
  - `--m3e-icon-button-extra-large-default-leading-space`: Leading space for extra-large (default).
  - `--m3e-icon-button-extra-large-default-trailing-space`: Trailing space for extra-large (default).
  - `--m3e-icon-button-extra-large-wide-leading-space`: Leading space for extra-large (wide).
  - `--m3e-icon-button-extra-large-wide-trailing-space`: Trailing space for extra-large (wide).
  - `--m3e-icon-button-outline-color`: Default outline color for all variants.
  - `--m3e-icon-button-disabled-outline-color`: Outline color when disabled (all variants).
  - `--m3e-icon-button-hover-outline-color`: Outline color on hover (all variants).
  - `--m3e-icon-button-focus-outline-color`: Outline color on focus (all variants).
  - `--m3e-icon-button-pressed-outline-color`: Outline color on pressed (all variants).
  - `--m3e-icon-button-container-color`: Default container background color for all variants.
  - `--m3e-icon-button-unselected-container-color`: Unselected container background color for all variants.
  - `--m3e-icon-button-selected-container-color`: Selected container background color for all variants.
  - `--m3e-icon-button-icon-color`: Default icon color for tonal variant.
  - `--m3e-icon-button-container-color`: Default container background color for tonal variant.
  - `--m3e-icon-button-unselected-icon-color`: Unselected icon color for tonal variant.
  - `--m3e-icon-button-unselected-container-color`: Unselected container background color for tonal variant.
  - `--m3e-icon-button-selected-icon-color`: Selected icon color for tonal variant.
  - `--m3e-icon-button-selected-container-color`: Selected container background color for tonal variant.
  - `--m3e-icon-button-icon-color`: Default icon color for all variants.
  - `--m3e-icon-button-unselected-icon-color`: Unselected icon color for all variants.
  - `--m3e-icon-button-selected-icon-color`: Selected icon color for all variants.
  - `--m3e-icon-button-disabled-container-color`: Container background color when disabled (all variants).
  - `--m3e-icon-button-disabled-container-opacity`: Opacity of container when disabled (all variants).
  - `--m3e-icon-button-disabled-icon-color`: Icon color when disabled (all variants).
  - `--m3e-icon-button-disabled-icon-opacity`: Icon opacity when disabled (all variants).
  - `--m3e-icon-button-hover-icon-color`: Icon color on hover (all variants).
  - `--m3e-icon-button-hover-state-layer-color`: State layer color on hover (all variants).
  - `--m3e-icon-button-hover-state-layer-opacity`: State layer opacity on hover (all variants).
  - `--m3e-icon-button-hover-unselected-icon-color`: Unselected icon color on hover (all variants).
  - `--m3e-icon-button-hover-unselected-state-layer-color`: Unselected state layer color on hover (all variants).
  - `--m3e-icon-button-hover-selected-icon-color`: Selected icon color on hover (all variants).
  - `--m3e-icon-button-hover-selected-state-layer-color`: Selected state layer color on hover (all variants).
  - `--m3e-icon-button-focus-icon-color`: Icon color on focus (all variants).
  - `--m3e-icon-button-focus-state-layer-color`: State layer color on focus (all variants).
  - `--m3e-icon-button-focus-state-layer-opacity`: State layer opacity on focus (all variants).
  - `--m3e-icon-button-focus-unselected-icon-color`: Unselected icon color on focus (all variants).
  - `--m3e-icon-button-focus-unselected-state-layer-color`: Unselected state layer color on focus (all variants).
  - `--m3e-icon-button-focus-selected-icon-color`: Selected icon color on focus (all variants).
  - `--m3e-icon-button-focus-selected-state-layer-color`: Selected state layer color on focus (all variants).
  - `--m3e-icon-button-pressed-icon-color`: Icon color on pressed (all variants).
  - `--m3e-icon-button-pressed-state-layer-color`: State layer color on pressed (all variants).
  - `--m3e-icon-button-pressed-state-layer-opacity`: State layer opacity on pressed (all variants).
  - `--m3e-icon-button-pressed-unselected-icon-color`: Unselected icon color on pressed (all variants).
  - `--m3e-icon-button-pressed-unselected-state-layer-color`: Unselected state layer color on pressed (all variants).
  - `--m3e-icon-button-pressed-selected-icon-color`: Selected icon color on pressed (all variants).
  - `--m3e-icon-button-pressed-selected-state-layer-color`: Selected state layer color on pressed (all variants).
  - `--m3e-outlined-icon-button-icon-color`: Default icon color for outlined variant.
  - `--m3e-outlined-icon-button-outline-color`: Default outline color for outlined variant.
  - `--m3e-outlined-icon-button-unselected-icon-color`: Unselected icon color for outlined variant.
  - `--m3e-outlined-icon-button-selected-icon-color`: Selected icon color for outlined variant.
  - `--m3e-outlined-icon-button-selected-container-color`: Selected container background color for outlined variant.
  - `--m3e-outlined-icon-button-disabled-container-color`: Container background color when disabled (outlined).
  - `--m3e-outlined-icon-button-disabled-container-opacity`: Opacity of container when disabled (outlined).
  - `--m3e-outlined-icon-button-disabled-icon-color`: Icon color when disabled (outlined).
  - `--m3e-outlined-icon-button-disabled-icon-opacity`: Icon opacity when disabled (outlined).
  - `--m3e-outlined-icon-button-disabled-outline-color`: Outline color when disabled (outlined).
  - `--m3e-outlined-icon-button-hover-icon-color`: Icon color on hover (outlined).
  - `--m3e-outlined-icon-button-hover-outline-color`: Outline color on hover (outlined).
  - `--m3e-outlined-icon-button-hover-state-layer-color`: State layer color on hover (outlined).
  - `--m3e-outlined-icon-button-hover-state-layer-opacity`: State layer opacity on hover (outlined).
  - `--m3e-outlined-icon-button-hover-unselected-icon-color`: Unselected icon color on hover (outlined).
  - `--m3e-outlined-icon-button-hover-unselected-state-layer-color`: Unselected state layer color on hover (outlined).
  - `--m3e-outlined-icon-button-hover-selected-icon-color`: Selected icon color on hover (outlined).
  - `--m3e-outlined-icon-button-hover-selected-state-layer-color`: Selected state layer color on hover (outlined).
  - `--m3e-outlined-icon-button-focus-icon-color`: Icon color on focus (outlined).
  - `--m3e-outlined-icon-button-focus-outline-color`: Outline color on focus (outlined).
  - `--m3e-outlined-icon-button-focus-state-layer-color`: State layer color on focus (outlined).
  - `--m3e-outlined-icon-button-focus-state-layer-opacity`: State layer opacity on focus (outlined).
  - `--m3e-outlined-icon-button-focus-unselected-icon-color`: Unselected icon color on focus (outlined).
  - `--m3e-outlined-icon-button-focus-unselected-state-layer-color`: Unselected state layer color on focus (outlined).
  - `--m3e-outlined-icon-button-focus-selected-icon-color`: Selected icon color on focus (outlined).
  - `--m3e-outlined-icon-button-focus-selected-state-layer-color`: Selected state layer color on focus (outlined).
  - `--m3e-outlined-icon-button-pressed-icon-color`: Icon color on pressed (outlined).
  - `--m3e-outlined-icon-button-pressed-outline-color`: Outline color on pressed (outlined).
  - `--m3e-outlined-icon-button-pressed-state-layer-color`: State layer color on pressed (outlined).
  - `--m3e-outlined-icon-button-pressed-state-layer-opacity`: State layer opacity on pressed (outlined).
  - `--m3e-outlined-icon-button-pressed-unselected-icon-color`: Unselected icon color on pressed (outlined).
  - `--m3e-outlined-icon-button-pressed-unselected-state-layer-color`: Unselected state layer color on pressed (outlined).
  - `--m3e-outlined-icon-button-pressed-selected-icon-color`: Selected icon color on pressed (outlined).
  - `--m3e-outlined-icon-button-pressed-selected-state-layer-color`: Selected state layer color on pressed (outlined).
  - `--m3e-filled-icon-button-icon-color`: Default icon color for filled variant.
  - `--m3e-filled-icon-button-container-color`: Default container background color for filled variant.
  - `--m3e-filled-icon-button-unselected-icon-color`: Unselected icon color for filled variant.
  - `--m3e-filled-icon-button-unselected-container-color`: Unselected container background color for filled variant.
  - `--m3e-filled-icon-button-selected-icon-color`: Selected icon color for filled variant.
  - `--m3e-filled-icon-button-selected-container-color`: Selected container background color for filled variant.
  - `--m3e-filled-icon-button-disabled-container-color`: Container background color when disabled (filled).
  - `--m3e-filled-icon-button-disabled-container-opacity`: Opacity of container when disabled (filled).
  - `--m3e-filled-icon-button-disabled-icon-color`: Icon color when disabled (filled).
  - `--m3e-filled-icon-button-disabled-icon-opacity`: Icon opacity when disabled (filled).
  - `--m3e-filled-icon-button-hover-icon-color`: Icon color on hover (filled).
  - `--m3e-filled-icon-button-hover-state-layer-color`: State layer color on hover (filled).
  - `--m3e-filled-icon-button-hover-state-layer-opacity`: State layer opacity on hover (filled).
  - `--m3e-filled-icon-button-hover-unselected-icon-color`: Unselected icon color on hover (filled).
  - `--m3e-filled-icon-button-hover-unselected-state-layer-color`: Unselected state layer color on hover (filled).
  - `--m3e-filled-icon-button-hover-selected-icon-color`: Selected icon color on hover (filled).
  - `--m3e-filled-icon-button-hover-selected-state-layer-color`: Selected state layer color on hover (filled).
  - `--m3e-filled-icon-button-focus-icon-color`: Icon color on focus (filled).
  - `--m3e-filled-icon-button-focus-state-layer-color`: State layer color on focus (filled).
  - `--m3e-filled-icon-button-focus-state-layer-opacity`: State layer opacity on focus (filled).
  - `--m3e-filled-icon-button-focus-unselected-icon-color`: Unselected icon color on focus (filled).
  - `--m3e-filled-icon-button-focus-unselected-state-layer-color`: Unselected state layer color on focus (filled).
  - `--m3e-filled-icon-button-focus-selected-icon-color`: Selected icon color on focus (filled).
  - `--m3e-filled-icon-button-focus-selected-state-layer-color`: Selected state layer color on focus (filled).
  - `--m3e-filled-icon-button-pressed-icon-color`: Icon color on pressed (filled).
  - `--m3e-filled-icon-button-pressed-state-layer-color`: State layer color on pressed (filled).
  - `--m3e-filled-icon-button-pressed-state-layer-opacity`: State layer opacity on pressed (filled).
  - `--m3e-filled-icon-button-pressed-unselected-icon-color`: Unselected icon color on pressed (filled).
  - `--m3e-filled-icon-button-pressed-unselected-state-layer-color`: Unselected state layer color on pressed (filled).
  - `--m3e-filled-icon-button-pressed-selected-icon-color`: Selected icon color on pressed (filled).
  - `--m3e-filled-icon-button-pressed-selected-state-layer-color`: Selected state layer color on pressed (filled).
  - `--m3e-tonal-icon-button-icon-color`: Default icon color for tonal variant.
  - `--m3e-tonal-icon-button-container-color`: Default container background color for tonal variant.
  - `--m3e-tonal-icon-button-unselected-icon-color`: Unselected icon color for tonal variant.
  - `--m3e-tonal-icon-button-unselected-container-color`: Unselected container background color for tonal variant.
  - `--m3e-tonal-icon-button-selected-icon-color`: Selected icon color for tonal variant.
  - `--m3e-tonal-icon-button-selected-container-color`: Selected container background color for tonal variant.
  - `--m3e-tonal-icon-button-disabled-container-color`: Container background color when disabled (tonal).
  - `--m3e-tonal-icon-button-disabled-container-opacity`: Opacity of container when disabled (tonal).
  - `--m3e-tonal-icon-button-disabled-icon-color`: Icon color when disabled (tonal).
  - `--m3e-tonal-icon-button-disabled-icon-opacity`: Icon opacity when disabled (tonal).
  - `--m3e-tonal-icon-button-hover-icon-color`: Icon color on hover (tonal).
  - `--m3e-tonal-icon-button-hover-state-layer-color`: State layer color on hover (tonal).
  - `--m3e-tonal-icon-button-hover-state-layer-opacity`: State layer opacity on hover (tonal).
  - `--m3e-tonal-icon-button-hover-unselected-icon-color`: Unselected icon color on hover (tonal).
  - `--m3e-tonal-icon-button-hover-unselected-state-layer-color`: Unselected state layer color on hover (tonal).
  - `--m3e-tonal-icon-button-hover-selected-icon-color`: Selected icon color on hover (tonal).
  - `--m3e-tonal-icon-button-hover-selected-state-layer-color`: Selected state layer color on hover (tonal).
  - `--m3e-tonal-icon-button-focus-icon-color`: Icon color on focus (tonal).
  - `--m3e-tonal-icon-button-focus-state-layer-color`: State layer color on focus (tonal).
  - `--m3e-tonal-icon-button-focus-state-layer-opacity`: State layer opacity on focus (tonal).
  - `--m3e-tonal-icon-button-focus-unselected-icon-color`: Unselected icon color on focus (tonal).
  - `--m3e-tonal-icon-button-focus-unselected-state-layer-color`: Unselected state layer color on focus (tonal).
  - `--m3e-tonal-icon-button-focus-selected-icon-color`: Selected icon color on focus (tonal).
  - `--m3e-tonal-icon-button-focus-selected-state-layer-color`: Selected state layer color on focus (tonal).
  - `--m3e-tonal-icon-button-pressed-icon-color`: Icon color on pressed (tonal).
  - `--m3e-tonal-icon-button-pressed-state-layer-color`: State layer color on pressed (tonal).
  - `--m3e-tonal-icon-button-pressed-state-layer-opacity`: State layer opacity on pressed (tonal).
  - `--m3e-tonal-icon-button-pressed-unselected-icon-color`: Unselected icon color on pressed (tonal).
  - `--m3e-tonal-icon-button-pressed-unselected-state-layer-color`: Unselected state layer color on pressed (tonal).
  - `--m3e-tonal-icon-button-pressed-selected-icon-color`: Selected icon color on pressed (tonal).
  - `--m3e-tonal-icon-button-pressed-selected-state-layer-color`: Selected state layer color on pressed (tonal).
  - `--m3e-standard-icon-button-icon-color`: Default icon color for standard variant.
  - `--m3e-standard-icon-button-unselected-icon-color`: Unselected icon color for standard variant.
  - `--m3e-standard-icon-button-selected-icon-color`: Selected icon color for standard variant.
  - `--m3e-standard-icon-button-disabled-container-color`: Container background color when disabled (standard).
  - `--m3e-standard-icon-button-disabled-container-opacity`: Opacity of container when disabled (standard).
  - `--m3e-standard-icon-button-disabled-icon-color`: Icon color when disabled (standard).
  - `--m3e-standard-icon-button-disabled-icon-opacity`: Icon opacity when disabled (standard).
  - `--m3e-standard-icon-button-hover-icon-color`: Icon color on hover (standard).
  - `--m3e-standard-icon-button-hover-state-layer-color`: State layer color on hover (standard).
  - `--m3e-standard-icon-button-hover-state-layer-opacity`: State layer opacity on hover (standard).
  - `--m3e-standard-icon-button-hover-unselected-icon-color`: Unselected icon color on hover (standard).
  - `--m3e-standard-icon-button-hover-unselected-state-layer-color`: Unselected state layer color on hover (standard).
  - `--m3e-standard-icon-button-hover-selected-icon-color`: Selected icon color on hover (standard).
  - `--m3e-standard-icon-button-hover-selected-state-layer-color`: Selected state layer color on hover (standard).
  - `--m3e-standard-icon-button-focus-icon-color`: Icon color on focus (standard).
  - `--m3e-standard-icon-button-focus-state-layer-color`: State layer color on focus (standard).
  - `--m3e-standard-icon-button-focus-state-layer-opacity`: State layer opacity on focus (standard).
  - `--m3e-standard-icon-button-focus-unselected-icon-color`: Unselected icon color on focus (standard).
  - `--m3e-standard-icon-button-focus-unselected-state-layer-color`: Unselected state layer color on focus (standard).
  - `--m3e-standard-icon-button-focus-selected-icon-color`: Selected icon color on focus (standard).
  - `--m3e-standard-icon-button-focus-selected-state-layer-color`: Selected state layer color on focus (standard).
  - `--m3e-standard-icon-button-pressed-icon-color`: Icon color on pressed (standard).
  - `--m3e-standard-icon-button-pressed-state-layer-color`: State layer color on pressed (standard).
  - `--m3e-standard-icon-button-pressed-state-layer-opacity`: State layer opacity on pressed (standard).
  - `--m3e-standard-icon-button-pressed-unselected-icon-color`: Unselected icon color on pressed (standard).
  - `--m3e-standard-icon-button-pressed-unselected-state-layer-color`: Unselected state layer color on pressed (standard).
  - `--m3e-standard-icon-button-pressed-selected-icon-color`: Selected icon color on pressed (standard).
  - `--m3e-standard-icon-button-pressed-selected-state-layer-color`: Selected state layer color on pressed (standard).

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-icon-button" attributes children


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


{-| The appearance variant of the button. (default: `"standard"`)
-}
variant :
    Cem.M3e.Common.Value
        { filled : Cem.M3e.Common.Supported
        , outlined : Cem.M3e.Common.Supported
        , standard : Cem.M3e.Common.Supported
        , tonal : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant


{-| The width of the button. (default: `"default"`)
-}
width :
    Cem.M3e.Common.Value
        { default : Cem.M3e.Common.Supported
        , narrow : Cem.M3e.Common.Supported
        , wide : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
width =
    Cem.M3e.Common.width


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


{-| Renders an icon, when selected.
-}
selectedSlot : Html.Attribute msg
selectedSlot =
    Html.Attributes.attribute "slot" "selected"
