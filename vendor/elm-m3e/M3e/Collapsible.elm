module M3e.Collapsible exposing (Orientation(..), component, noAnimate, onClosed, onClosing, onOpened, onOpening, open, orientation)

{-| 
A container used to expand and collapse content.

## Component

@docs component

### Attributes

@docs open, Orientation, orientation, noAnimate

### Events

@docs onOpening, onOpened, onClosing, onClosed
-}


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
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-collapsible" attributes children


{-| Whether content is visible. (default: `false`) -}
open : Bool -> Html.Attribute msg
open val_ =
    Html.Attributes.property "open" (Json.Encode.bool val_)


{-| Values for the `orientation` attribute. -}
type Orientation
    = Horizontal
    | Vertical


{-| Orientation of collapsible content. (default: `"vertical"`) -}
orientation : Orientation -> Html.Attribute msg
orientation val_ =
    Html.Attributes.attribute "orientation" (orientationToString val_)


orientationToString : Orientation -> String
orientationToString val_ =
    case val_ of
        Horizontal ->
            "horizontal"
    
        Vertical ->
            "vertical"


{-| Whether to disable animation. (default: `false`) -}
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