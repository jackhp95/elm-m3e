module M3e.SearchBar exposing
    ( component
    , onClear
    , leadingSlot, inputSlot, trailingSlot
    )

{-| A bar that provides a prominent entry point for search.


## Component

@docs component


### Events

@docs onClear


### Slots

@docs leadingSlot, inputSlot, trailingSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode


{-| A bar that provides a prominent entry point for search.

**Events:**

  - `clear`: Dispatched when the search term is cleared.

**Slots:**

  - `leading`: Renders content before the input of the bar.
  - `input`: Renders the input of the bar.
  - `trailing`: Renders content after the input of the bar.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-search-bar" attributes children


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
