module M3e.Tree exposing
    ( component
    , cascade
    , onChange
    )

{-| Presents hierarchical data in a tree structure.


## Component

@docs component


### Attributes

@docs cascade


### Events

@docs onChange

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| Presents hierarchical data in a tree structure.

**Events:**

  - `change`: Dispatched when the selected state changes.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-tree" attributes children


{-| Whether multiple item selection cascades to child items. (default: `false`)
-}
cascade : Bool -> Html.Attribute msg
cascade val_ =
    Html.Attributes.property "cascade" (Json.Encode.bool val_)


{-| Dispatched when the selected state changes.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

For the control's current value, use the `targetValue` decoder from `M3e.Common`, e.g. `onChange (Json.Decode.map ValueChanged M3e.Common.targetValue)`.

-}
onChange : Json.Decode.Decoder msg -> Html.Attribute msg
onChange decoder =
    Html.Events.on "change" decoder
