module Cem.M3e.SearchBar exposing
    ( component, clearable, clearLabel, onClear, leadingSlot, inputSlot
    , trailingSlot
    )

{-| A bar that provides a prominent entry point for search.

@docs component, clearable, clearLabel, onClear, leadingSlot, inputSlot
@docs trailingSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A bar that provides a prominent entry point for search.

**Events:**

  - `clear`: Dispatched when the search term is cleared.

**Slots:**

  - `leading`: Renders content before the input of the bar.
  - `input`: Renders the input of the bar.
  - `trailing`: Renders content after the input of the bar.

**CSS Custom Properties:**

  - `--m3e-search-bar-container-color`: Background color of the search bar container.
  - `--m3e-search-bar-leading-icon-color`: Color of the leading icon.
  - `--m3e-search-bar-trailing-icon-color`: Color of the trailing icon.
  - `--m3e-search-bar-container-height`: Height of the search bar container.
  - `--m3e-search-bar-container-shape`: Shape (border radius) of the search bar container.
  - `--m3e-search-bar-icon-size`: Size of icons inside the search bar.
  - `--m3e-search-bar-supporting-text-color`: Color of the supporting text.
  - `--m3e-search-bar-supporting-text-font-size`: Font size of the supporting text.
  - `--m3e-search-bar-supporting-text-font-weight`: Font weight of the supporting text.
  - `--m3e-search-bar-supporting-text-line-height`: Line height of the supporting text.
  - `--m3e-search-bar-supporting-text-tracking`: Letter spacing of the supporting text.
  - `--m3e-search-bar-input-color`: Color of the input text.
  - `--m3e-search-bar-input-text-font-size`: Font size of the input text.
  - `--m3e-search-bar-input-text-font-weight`: Font weight of the input text.
  - `--m3e-search-bar-input-text-line-height`: Line height of the input text.
  - `--m3e-search-bar-input-text-tracking`: Letter spacing of the input text.
  - `--m3e-search-bar-leading-space`: Space before the leading icon.
  - `--m3e-search-bar-trailing-space`: Space after the trailing icon.
  - `--m3e-search-bar-no-actions-leading-space`: Leading padding when no actions are present.
  - `--m3e-search-bar-no-actions-trailing-space`: Trailing padding when no actions are present.
  - `--m3e-search-bar-leading-actions-trailing-space`: Space between leading actions and the input.
  - `--m3e-search-bar-trailing-actions-leading-space`: Space between the input and trailing actions.
  - `--m3e-search-bar-actions-gap`: Gap between action icons.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-search-bar" attributes children


{-| Whether the bar presents a button used to clear the search term. (default: `false`)
-}
clearable : Bool -> Html.Attribute msg
clearable val_ =
    Html.Attributes.property "clearable" (Json.Encode.bool val_)


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`)
-}
clearLabel : String -> Html.Attribute msg
clearLabel val_ =
    Html.Attributes.attribute "clear-label" val_


{-| Dispatched when the search term is cleared.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClear : Json.Decode.Decoder msg -> Html.Attribute msg
onClear decoder =
    Html.Events.on "clear" decoder


{-| Renders content before the input of the bar.
-}
leadingSlot : Html.Attribute msg
leadingSlot =
    Html.Attributes.attribute "slot" "leading"


{-| Renders the input of the bar.
-}
inputSlot : Html.Attribute msg
inputSlot =
    Html.Attributes.attribute "slot" "input"


{-| Renders content after the input of the bar.
-}
trailingSlot : Html.Attribute msg
trailingSlot =
    Html.Attributes.attribute "slot" "trailing"
