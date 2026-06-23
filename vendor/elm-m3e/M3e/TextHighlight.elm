module M3e.TextHighlight exposing
    ( component
    , onHighlight
    )

{-| Highlights text which matches a given search term.


## Component

@docs component


### Events

@docs onHighlight

-}

import Html
import Html.Events
import Json.Decode


{-| Highlights text which matches a given search term.

**Events:**

  - `highlight`: Dispatched when content is highlighted.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-text-highlight" attributes children


{-| Dispatched when content is highlighted.

**Payload type:** `CustomEvent`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onHighlight : Json.Decode.Decoder msg -> Html.Attribute msg
onHighlight decoder =
    Html.Events.on "highlight" decoder
