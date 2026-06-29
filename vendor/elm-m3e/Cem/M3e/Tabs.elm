module Cem.M3e.Tabs exposing
    ( component, disablePagination, headerPosition, nextPageLabel, previousPageLabel, stretch
    , variant, selectedindex, onChange, onBeforeinput, onInput, panelSlot
    , nextIconSlot, prevIconSlot
    )

{-| Organizes content into separate views where only one view can be visible at a time.

@docs component, disablePagination, headerPosition, nextPageLabel, previousPageLabel, stretch
@docs variant, selectedindex, onChange, onBeforeinput, onInput, panelSlot
@docs nextIconSlot, prevIconSlot

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Organizes content into separate views where only one view can be visible at a time.

**Events:**

  - `change`: Dispatched when the selected tab changes.
  - `beforeinput`: Dispatched before the selected state of a tab changes.
  - `input`: Dispatched when the selected state of a tab changes.

**Slots:**

  - `panel`: Renders the panels of the tabs.
  - `next-icon`: Renders the icon to present for the next button used to paginate.
  - `prev-icon`: Renders the icon to present for the previous button used to paginate.

**CSS Custom Properties:**

  - `--m3e-tabs-paginator-button-icon-size`: Overrides the icon size for paginator buttons.
  - `--m3e-tabs-active-indicator-color`: Color of the active tab indicator.
  - `--m3e-tabs-primary-before-active-indicator-shape`: Border radius for active indicator when header is before and variant is primary.
  - `--m3e-tabs-primary-after-active-indicator-shape`: Border radius for active indicator when header is after and variant is primary.
  - `--m3e-tabs-primary-active-indicator-inset`: Inset for primary variant's active indicator.
  - `--m3e-tabs-primary-active-indicator-thickness`: Thickness for primary variant's active indicator.
  - `--m3e-tabs-secondary-active-indicator-thickness`: Thickness for secondary variant's active indicator.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-tabs" attributes children


{-| Whether scroll buttons are disabled.
-}
disablePagination : String -> Html.Attribute msg
disablePagination val_ =
    Html.Attributes.attribute "disable-pagination" val_


{-| The position of the tab headers. (default: `"before"`)
-}
headerPosition :
    Cem.M3e.Common.Value
        { after : Cem.M3e.Common.Supported
        , before : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
headerPosition =
    Cem.M3e.Common.headerPosition


{-| The accessible label given to the button used to move to the next page. (default: `"Next page"`)
-}
nextPageLabel : String -> Html.Attribute msg
nextPageLabel val_ =
    Html.Attributes.attribute "next-page-label" val_


{-| The accessible label given to the button used to move to the previous page. (default: `"Previous page"`)
-}
previousPageLabel : String -> Html.Attribute msg
previousPageLabel val_ =
    Html.Attributes.attribute "previous-page-label" val_


{-| Whether tabs are stretched to fill the header. (default: `false`)
-}
stretch : Bool -> Html.Attribute msg
stretch val_ =
    Html.Attributes.property "stretch" (Json.Encode.bool val_)


{-| The appearance variant of the tabs. (default: `"secondary"`)
-}
variant :
    Cem.M3e.Common.Value
        { primary : Cem.M3e.Common.Supported
        , secondary : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
variant =
    Cem.M3e.Common.variant


{-| The zero-based index of the selected tab.
-}
selectedindex : Float -> Html.Attribute msg
selectedindex val_ =
    Html.Attributes.property "selectedIndex" (Json.Encode.float val_)


{-| Dispatched when the selected tab changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder


{-| Dispatched before the selected state of a tab changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onBeforeinput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onBeforeinput : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforeinput decoder =
    Html.Events.on "beforeinput" decoder


{-| Dispatched when the selected state of a tab changes.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `Cem.M3e.Common`, e.g. `onInput (Json.Decode.map ValueChanged Cem.M3e.Common.targetValue)`.

-}
onInput : Json.Decode.Decoder msg -> Html.Attribute msg
onInput decoder =
    Html.Events.on "input" decoder


{-| Renders the panels of the tabs.
-}
panelSlot : Html.Attribute msg
panelSlot =
    Html.Attributes.attribute "slot" "panel"


{-| Renders the icon to present for the next button used to paginate.
-}
nextIconSlot : Html.Attribute msg
nextIconSlot =
    Html.Attributes.attribute "slot" "next-icon"


{-| Renders the icon to present for the previous button used to paginate.
-}
prevIconSlot : Html.Attribute msg
prevIconSlot =
    Html.Attributes.attribute "slot" "prev-icon"
