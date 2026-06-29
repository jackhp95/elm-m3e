module Cem.M3e.Collapsible exposing
    ( component, open, orientation, noAnimate, onOpening, onOpened
    , onClosing, onClosed
    )

{-| A container used to expand and collapse content.

@docs component, open, orientation, noAnimate, onOpening, onOpened
@docs onClosing, onClosed

-}

import Cem.M3e.Common
import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A container used to expand and collapse content.

**Events:**

  - `opening`: Dispatched when the collapsible begins to open.
  - `opened`: Dispatched when the collapsible has opened.
  - `closing`: Dispatched when the collapsible begins to close.
  - `closed`: Dispatched when the collapsible has closed.

**CSS Custom Properties:**

  - `--m3e-collapsible-animation-duration`: The duration of the expand / collapse animation.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-collapsible" attributes children


{-| Whether content is visible. (default: `false`)
-}
open : Bool -> Html.Attribute msg
open val_ =
    Html.Attributes.property "open" (Json.Encode.bool val_)


{-| Orientation of collapsible content. (default: `"vertical"`)
-}
orientation :
    Cem.M3e.Common.Value
        { horizontal : Cem.M3e.Common.Supported
        , vertical : Cem.M3e.Common.Supported
        }
    -> Html.Attribute msg
orientation =
    Cem.M3e.Common.orientation


{-| Whether to disable animation. (default: `false`)
-}
noAnimate : Bool -> Html.Attribute msg
noAnimate val_ =
    Html.Attributes.property "no-animate" (Json.Encode.bool val_)


{-| Dispatched when the collapsible begins to open.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onOpening : Json.Decode.Decoder msg -> Html.Attribute msg
onOpening decoder =
    Html.Events.on "opening" decoder


{-| Dispatched when the collapsible has opened.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onOpened : Json.Decode.Decoder msg -> Html.Attribute msg
onOpened decoder =
    Html.Events.on "opened" decoder


{-| Dispatched when the collapsible begins to close.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClosing : Json.Decode.Decoder msg -> Html.Attribute msg
onClosing decoder =
    Html.Events.on "closing" decoder


{-| Dispatched when the collapsible has closed.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClosed : Json.Decode.Decoder msg -> Html.Attribute msg
onClosed decoder =
    Html.Events.on "closed" decoder
