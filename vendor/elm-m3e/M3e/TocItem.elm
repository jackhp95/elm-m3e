module M3e.TocItem exposing
    ( component
    , onClick
    )

{-| An item in a table of contents.


## Component

@docs component


### Events

@docs onClick

-}

import Html
import Html.Events
import Json.Decode


{-| An item in a table of contents.

**Events:**

  - `click`: Dispatched when the element is clicked.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-toc-item" attributes children


{-| Dispatched when the element is clicked.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClick : Json.Decode.Decoder msg -> Html.Attribute msg
onClick decoder =
    Html.Events.on "click" decoder
