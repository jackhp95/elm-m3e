module M3e.SearchView exposing
    ( component
    , contained, open, hideSearchIcon
    , onQuery, onClear, onBeforetoggle, onToggle
    , inputSlot, openLeadingSlot, openTrailingSlot, closedLeadingSlot, closedTrailingSlot
    )

{-| A surface that presents suggestions and results for a search.


## Component

@docs component


### Attributes

@docs contained, open, hideSearchIcon


### Events

@docs onQuery, onClear, onBeforetoggle, onToggle


### Slots

@docs inputSlot, openLeadingSlot, openTrailingSlot, closedLeadingSlot, closedTrailingSlot

-}

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

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-search-view" attributes children


{-| Whether the view features a persistent, filled search container. (default: `false`)
-}
contained : Bool -> Html.Attribute msg
contained val_ =
    Html.Attributes.property "contained" (Json.Encode.bool val_)


{-| Whether the view is expanded to show results. (default: `false`)
-}
open : Bool -> Html.Attribute msg
open val_ =
    Html.Attributes.property "open" (Json.Encode.bool val_)


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
