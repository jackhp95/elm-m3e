module Cem.M3e.Toc exposing (component, for, maxDepth, overlineSlot, titleSlot)

{-| A table of contents that provides in-page scroll navigation.

@docs component, for, maxDepth, overlineSlot, titleSlot

-}

import Html
import Html.Attributes
import Json.Encode


{-| A table of contents that provides in-page scroll navigation.

**Slots:**

  - `overline`: Renders the overline of the table of contents.
  - `title`: Renders the title of the table of contents.

**CSS Custom Properties:**

  - `--m3e-toc-width`: Width of the table of contents.
  - `--m3e-toc-container-color`: Background color of the table of contents container.
  - `--m3e-toc-container-padding-inline`: Inline padding of the table of contents container.
  - `--m3e-toc-container-padding-block`: Block padding of the table of contents container.
  - `--m3e-toc-item-shape`: Border radius of TOC items and active indicator.
  - `--m3e-toc-active-indicator-color`: Border color of the active indicator.
  - `--m3e-toc-active-indicator-animation-duration`: Animation duration for the active indicator.
  - `--m3e-toc-item-padding`: Inline padding for TOC items and header.
  - `--m3e-toc-header-space`: Block space below and between header elements.
  - `--m3e-toc-overline-font-size`: Font size for the overline slot.
  - `--m3e-toc-overline-font-weight`: Font weight for the overline slot.
  - `--m3e-toc-overline-line-height`: Line height for the overline slot.
  - `--m3e-toc-overline-tracking`: Letter spacing for the overline slot.
  - `--m3e-toc-overline-color`: Text color for the overline slot.
  - `--m3e-toc-title-font-size`: Font size for the title slot.
  - `--m3e-toc-title-font-weight`: Font weight for the title slot.
  - `--m3e-toc-title-line-height`: Line height for the title slot.
  - `--m3e-toc-title-tracking`: Letter spacing for the title slot.
  - `--m3e-toc-title-color`: Text color for the title slot.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-toc" attributes children


{-| The identifier of the interactive control to which this element is attached. (default: `null`)
-}
for : String -> Html.Attribute msg
for val_ =
    Html.Attributes.attribute "for" val_


{-| The maximum depth of the table of contents. (default: `2`)
-}
maxDepth : Float -> Html.Attribute msg
maxDepth val_ =
    Html.Attributes.property "max-depth" (Json.Encode.float val_)


{-| Renders the overline of the table of contents.
-}
overlineSlot : Html.Attribute msg
overlineSlot =
    Html.Attributes.attribute "slot" "overline"


{-| Renders the title of the table of contents.
-}
titleSlot : Html.Attribute msg
titleSlot =
    Html.Attributes.attribute "slot" "title"
