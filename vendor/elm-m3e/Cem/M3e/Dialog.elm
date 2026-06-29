module Cem.M3e.Dialog exposing
    ( component, alert, closeLabel, disableClose, dismissible, noFocusTrap
    , open, returnvalue, onOpening, onOpened, onClosing, onClosed
    , onCancel, headerSlot, actionsSlot, closeIconSlot
    )

{-| A dialog that provides important prompts in a user flow.

@docs component, alert, closeLabel, disableClose, dismissible, noFocusTrap
@docs open, returnvalue, onOpening, onOpened, onClosing, onClosed
@docs onCancel, headerSlot, actionsSlot, closeIconSlot

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

**CSS Custom Properties:**

  - `--m3e-dialog-shape`: Border radius of the dialog container.
  - `--m3e-dialog-min-width`: Minimum width of the dialog.
  - `--m3e-dialog-max-width`: Maximum width of the dialog.
  - `--m3e-dialog-color`: Foreground color of the dialog.
  - `--m3e-dialog-container-color`: Background color of the dialog container.
  - `--m3e-dialog-scrim-color`: Color of the scrim (backdrop overlay).
  - `--m3e-dialog-scrim-opacity`: Opacity of the scrim when open.
  - `--m3e-dialog-header-container-color`: Background color of the dialog header.
  - `--m3e-dialog-header-color`: Foreground color of the dialog header.
  - `--m3e-dialog-header-font-size`: Font size for the dialog header.
  - `--m3e-dialog-header-font-weight`: Font weight for the dialog header.
  - `--m3e-dialog-header-line-height`: Line height for the dialog header.
  - `--m3e-dialog-header-tracking`: Letter spacing for the dialog header.
  - `--m3e-dialog-content-color`: Foreground color of the dialog content.
  - `--m3e-dialog-content-font-size`: Font size for the dialog content.
  - `--m3e-dialog-content-font-weight`: Font weight for the dialog content.
  - `--m3e-dialog-content-line-height`: Line height for the dialog content.
  - `--m3e-dialog-content-tracking`: Letter spacing for the dialog content.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-dialog" attributes children


{-| Whether the dialog is an alert. (default: `false`)
-}
alert : Bool -> Html.Attribute msg
alert val_ =
    Html.Attributes.property "alert" (Json.Encode.bool val_)


{-| The accessible label given to the button used to dismiss the dialog. (default: `"Close"`)
-}
closeLabel : String -> Html.Attribute msg
closeLabel val_ =
    Html.Attributes.attribute "close-label" val_


{-| Whether users cannot click the backdrop or press ESC to dismiss the dialog. (default: `false`)
-}
disableClose : Bool -> Html.Attribute msg
disableClose val_ =
    Html.Attributes.property "disable-close" (Json.Encode.bool val_)


{-| Whether a button is presented that can be used to close the dialog. (default: `false`)
-}
dismissible : Bool -> Html.Attribute msg
dismissible val_ =
    Html.Attributes.property "dismissible" (Json.Encode.bool val_)


{-| Whether to disable focus trapping, which keeps keyboard `Tab` navigation within the dialog. (default: `false`)
-}
noFocusTrap : Bool -> Html.Attribute msg
noFocusTrap val_ =
    Html.Attributes.property "no-focus-trap" (Json.Encode.bool val_)


{-| Whether the dialog is open. (default: `false`)
-}
open : String -> Html.Attribute msg
open val_ =
    Html.Attributes.attribute "open" val_


{-| The return value of the dialog. (default: `""`)
-}
returnvalue : String -> Html.Attribute msg
returnvalue val_ =
    Html.Attributes.property "returnValue" (Json.Encode.string val_)


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


{-| Renders the header of the dialog.
-}
headerSlot : Html.Attribute msg
headerSlot =
    Html.Attributes.attribute "slot" "header"


{-| Renders the actions of the dialog.
-}
actionsSlot : Html.Attribute msg
actionsSlot =
    Html.Attributes.attribute "slot" "actions"


{-| Renders the icon of the button used to close the dialog.
-}
closeIconSlot : Html.Attribute msg
closeIconSlot =
    Html.Attributes.attribute "slot" "close-icon"
