module M3e.Dialog exposing (actionsSlot, alert, closeIconSlot, component, disableClose, headerSlot, noFocusTrap, onCancel, onClosed, onClosing, onOpened, onOpening, open)

{-| 
A dialog that provides important prompts in a user flow.

## Component

@docs component

### Attributes

@docs alert, disableClose, noFocusTrap, open

### Events

@docs onOpening, onOpened, onClosing, onClosed, onCancel

### Slots

@docs headerSlot, actionsSlot, closeIconSlot
-}


import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A dialog that provides important prompts in a user flow.

**Events:**
- `opening`: Dispatched when the dialog begins to open.
- `opened`: Dispatched when the dialog has opened.
- `closing`: Dispatched when the dialog begins to close.
- `closed`: Dispatched when the dialog has closed.
- `cancel`: Dispatched when the dialog is cancelled.

**Slots:**
- `header`: Renders the header of the dialog.
- `actions`: Renders the actions of the dialog.
- `close-icon`: Renders the icon of the button used to close the dialog.
-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-dialog" attributes children


{-| Whether the dialog is an alert. (default: `false`) -}
alert : Bool -> Html.Attribute msg
alert val_ =
    Html.Attributes.property "alert" (Json.Encode.bool val_)


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`) -}
disableClose : Bool -> Html.Attribute msg
disableClose val_ =
    Html.Attributes.property "disable-close" (Json.Encode.bool val_)


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`) -}
noFocusTrap : Bool -> Html.Attribute msg
noFocusTrap val_ =
    Html.Attributes.property "no-focus-trap" (Json.Encode.bool val_)


{-| Whether the dialog is open. (default: `false`) -}
open : String -> Html.Attribute msg
open val_ =
    Html.Attributes.attribute "open" val_


{-| Dispatched when the dialog begins to open.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onOpening : Json.Decode.Decoder msg -> Html.Attribute msg
onOpening decoder =
    Html.Events.on "opening" decoder


{-| Dispatched when the dialog has opened.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onOpened : Json.Decode.Decoder msg -> Html.Attribute msg
onOpened decoder =
    Html.Events.on "opened" decoder


{-| Dispatched when the dialog begins to close.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClosing : Json.Decode.Decoder msg -> Html.Attribute msg
onClosing decoder =
    Html.Events.on "closing" decoder


{-| Dispatched when the dialog has closed.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onClosed : Json.Decode.Decoder msg -> Html.Attribute msg
onClosed decoder =
    Html.Events.on "closed" decoder


{-| Dispatched when the dialog is cancelled.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.
-}
onCancel : Json.Decode.Decoder msg -> Html.Attribute msg
onCancel decoder =
    Html.Events.on "cancel" decoder


{-| Renders the header of the dialog. -}
headerSlot : Html.Attribute msg
headerSlot =
    Html.Attributes.attribute "slot" "header"


{-| Renders the actions of the dialog. -}
actionsSlot : Html.Attribute msg
actionsSlot =
    Html.Attributes.attribute "slot" "actions"


{-| Renders the icon of the button used to close the dialog. -}
closeIconSlot : Html.Attribute msg
closeIconSlot =
    Html.Attributes.attribute "slot" "close-icon"