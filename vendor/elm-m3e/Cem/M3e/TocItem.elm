module Cem.M3e.TocItem exposing (component, disabled, selected, onClick)

{-| An item in a table of contents.

@docs component, disabled, selected, onClick

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| An item in a table of contents.

**Events:**

  - `click`: Dispatched when the element is clicked.

**CSS Custom Properties:**

  - `--m3e-toc-item-shape`: Border radius of the TOC item.
  - `--m3e-toc-item-padding-block`: Block padding for the TOC item.
  - `--m3e-toc-item-padding`: Inline padding for the TOC item.
  - `--m3e-toc-item-inset`: Indentation per level for the TOC item.
  - `--m3e-toc-active-indicator-animation-duration`: Animation duration for the active indicator.
  - `--m3e-toc-item-font-size`: Font size for unselected items.
  - `--m3e-toc-item-font-weight`: Font weight for unselected items.
  - `--m3e-toc-item-line-height`: Line height for unselected items.
  - `--m3e-toc-item-tracking`: Letter spacing for unselected items.
  - `--m3e-toc-item-color`: Text color for unselected items.
  - `--m3e-toc-item-selected-font-size`: Font size for selected items.
  - `--m3e-toc-item-selected-font-weight`: Font weight for selected items.
  - `--m3e-toc-item-selected-line-height`: Line height for selected items.
  - `--m3e-toc-item-selected-tracking`: Letter spacing for selected items.
  - `--m3e-toc-item-selected-color`: Text color for selected items.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-toc-item" attributes children


{-| A value indicating whether the element is disabled. (default: `false`)
-}
disabled : Bool -> Html.Attribute msg
disabled val_ =
    Html.Attributes.property "disabled" (Json.Encode.bool val_)


{-| Whether the element is selected. (default: `false`)
-}
selected : Bool -> Html.Attribute msg
selected =
    Html.Attributes.selected


{-| Dispatched when the element is clicked.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder
