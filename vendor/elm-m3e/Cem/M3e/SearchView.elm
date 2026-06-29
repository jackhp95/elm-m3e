module Cem.M3e.SearchView exposing
    ( component, contained, mode, open, clearLabel, closeLabel
    , hideSearchIcon, onQuery, onClear, onBeforetoggle, onToggle, inputSlot
    , openLeadingSlot, openTrailingSlot, closedLeadingSlot, closedTrailingSlot
    )

{-| A surface that presents suggestions and results for a search.

@docs component, contained, mode, open, clearLabel, closeLabel
@docs hideSearchIcon, onQuery, onClear, onBeforetoggle, onToggle, inputSlot
@docs openLeadingSlot, openTrailingSlot, closedLeadingSlot, closedTrailingSlot

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A surface that presents suggestions and results for a search.

**Events:**

  - `query`: Dispatched when the view is opened or when the user modifies the search term.
  - `clear`: Dispatched when the search term is cleared.
  - `beforetoggle`: Dispatched before the toggle state changes.
  - `toggle`: Dispatched after the toggle state has changed.

**Slots:**

  - `input`: Renders the input of the view.
  - `open-leading`: When open, renders content before the input of the view.
  - `open-trailing`: When open, renders content after the input of the view.
  - `closed-leading`: When closed, renders content before the input of the view.
  - `closed-trailing`: When closed, renders content after the input of the view.

**CSS Custom Properties:**

  - `--m3e-search-view-container-color`: Background color of the view container.
  - `--m3e-search-view-contained-container-color`: Background color of the contained view container.
  - `--m3e-search-view-divider-color`: Color of the divider separating header and results.
  - `--m3e-search-view-divider-thickness`: Thickness of the divider separating header and results.
  - `--m3e-search-view-full-screen-container-shape`: Shape of the fullscreen view container.
  - `--m3e-search-view-full-screen-header-container-height`: Height of the header container in fullscreen mode.
  - `--m3e-search-view-docked-container-shape`: Shape of the docked view container.
  - `--m3e-search-view-docked-header-container-height`: Height of the header container in docked mode.
  - `--m3e-search-view-contained-leading-margin`: Leading margin for the contained view.
  - `--m3e-search-view-contained-trailing-margin`: Trailing margin for the contained view.
  - `--m3e-search-view-contained-focused-leading-margin`: Leading margin when the contained view is focused.
  - `--m3e-search-view-contained-focused-trailing-margin`: Trailing margin when the contained view is focused.
  - `--m3e-search-view-contained-docked-bar-results-gap`: Gap between the contained docked bar and results.
  - `--m3e-search-view-contained-docked-results-shape`: Shape of the results container in contained docked mode.
  - `--m3e-search-view-contained-docked-bar-shape`: Shape of the bar in contained docked mode.
  - `--m3e-search-view-contained-full-screen-bar-container-height`: Height of the bar container in contained fullscreen mode.
  - `--m3e-search-view-docked-container-min-height`: Minimum height of the docked view container.
  - `--m3e-search-view-docked-container-max-height`: Maximum height of the docked view container.
  - `--m3e-search-view-contained-docked-results-space`: Space above the results in contained docked mode.
  - `--m3e-search-view-docked-results-bottom-space`: Space below the results in docked mode.
  - `--m3e-search-view-docked-scrim-color`: Color of the scrim behind the docked view.
  - `--m3e-search-view-docked-scrim-opacity`: Opacity of the scrim behind the docked view.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-search-view" attributes children


{-| Whether the view features a persistent, filled search container. (default: `false`)
-}
contained : Bool -> Html.Attribute msg
contained val_ =
    Html.Attributes.property "contained" (Json.Encode.bool val_)


{-| The behavior mode of the view. (default: `"docked"`)
-}
mode :
    Cem.M3e.Common.Value
        { auto : Cem.M3e.Common.Supported
        , docked : Cem.M3e.Common.Supported
        , fullscreen : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
mode =
    Cem.M3e.Common.mode


{-| Whether the view is expanded to show results. (default: `false`)
-}
open : Bool -> Html.Attribute msg
open val_ =
    Html.Attributes.property "open" (Json.Encode.bool val_)


{-| The accessible label given to the button used to clear the search term. (default: `"Clear"`)
-}
clearLabel : String -> Html.Attribute msg
clearLabel val_ =
    Html.Attributes.attribute "clear-label" val_


{-| The accessible label given to the button used to collapse the view. (default: `"Close"`)
-}
closeLabel : String -> Html.Attribute msg
closeLabel val_ =
    Html.Attributes.attribute "close-label" val_


{-| Whether to hide the search icon. (default: `false`)
-}
hideSearchIcon : Bool -> Html.Attribute msg
hideSearchIcon val_ =
    Html.Attributes.property "hide-search-icon" (Json.Encode.bool val_)


{-| Dispatched when the view is opened or when the user modifies the search term.

**Payload type:** `CustomEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onQuery : Json.Decode.Decoder msg -> Html.Attribute msg
onQuery decoder =
    Html.Events.on "query" decoder


{-| Dispatched when the search term is cleared.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClear : Json.Decode.Decoder msg -> Html.Attribute msg
onClear decoder =
    Html.Events.on "clear" decoder


{-| Dispatched before the toggle state changes.

**Payload type:** `ToggleEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onBeforetoggle : Json.Decode.Decoder msg -> Html.Attribute msg
onBeforetoggle decoder =
    Html.Events.on "beforetoggle" decoder


{-| Dispatched after the toggle state has changed.

**Payload type:** `ToggleEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onToggle : Json.Decode.Decoder msg -> Html.Attribute msg
onToggle decoder =
    Html.Events.on "toggle" decoder


{-| Renders the input of the view.
-}
inputSlot : Html.Attribute msg
inputSlot =
    Html.Attributes.attribute "slot" "input"


{-| When open, renders content before the input of the view.
-}
openLeadingSlot : Html.Attribute msg
openLeadingSlot =
    Html.Attributes.attribute "slot" "open-leading"


{-| When open, renders content after the input of the view.
-}
openTrailingSlot : Html.Attribute msg
openTrailingSlot =
    Html.Attributes.attribute "slot" "open-trailing"


{-| When closed, renders content before the input of the view.
-}
closedLeadingSlot : Html.Attribute msg
closedLeadingSlot =
    Html.Attributes.attribute "slot" "closed-leading"


{-| When closed, renders content after the input of the view.
-}
closedTrailingSlot : Html.Attribute msg
closedTrailingSlot =
    Html.Attributes.attribute "slot" "closed-trailing"
