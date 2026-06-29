module Cem.M3e.BottomSheet exposing
    ( component, detent, handle, handleLabel, hideable, hideFriction
    , modal, open, overshootLimit, onOpening, onClosing, onCancel
    , onOpened, onClosed, headerSlot
    )

{-| A sheet used to show secondary content anchored to the bottom of the screen.


### Omitted Attributes

The following attribute setters were omitted because Elm cannot pass DOM element references:

  - `detents`: string[]

@docs component, detent, handle, handleLabel, hideable, hideFriction
@docs modal, open, overshootLimit, onOpening, onClosing, onCancel
@docs onOpened, onClosed, headerSlot

-}

import Html
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode


{-| A sheet used to show secondary content anchored to the bottom of the screen.

**Events:**

  - `opening`: Dispatched when the sheet begins to open.
  - `closing`: Dispatched when the sheet begins to close.
  - `cancel`: Dispatched when the sheet is cancelled.
  - `opened`: Dispatched when the sheet has opened.
  - `closed`: Dispatched when the sheet has closed.

**Slots:**

  - `header`: Renders the header of the sheet.

**CSS Custom Properties:**

  - `--m3e-bottom-sheet-width`: The width of the sheet.
  - `--m3e-bottom-sheet-max-width`: The maximum width of the sheet.
  - `--m3e-bottom-sheet-container-color`: The background color of the sheet container.
  - `--m3e-bottom-sheet-elevation`: The elevation level when not modal.
  - `--m3e-bottom-sheet-modal-elevation`: The elevation level when modal.
  - `--m3e-bottom-sheet-full-elevation`: The elevation level when full height.
  - `--m3e-bottom-sheet-z-index`: The z-index of the non-modal sheet.
  - `--m3e-bottom-sheet-minimized-container-shape`: The border radius when minimized.
  - `--m3e-bottom-sheet-container-shape`: The border radius of the sheet container.
  - `--m3e-bottom-sheet-full-container-shape`: The border radius when full height.
  - `--m3e-bottom-sheet-scrim-color`: The color of the scrim overlay.
  - `--m3e-bottom-sheet-scrim-opacity`: The opacity of the scrim overlay.
  - `--m3e-bottom-sheet-peek-height`: The visible height when minimized.
  - `--m3e-bottom-sheet-compact-top-space`: The top space in compact mode.
  - `--m3e-bottom-sheet-top-space`: The top space in standard mode.
  - `--m3e-bottom-sheet-padding-block`: The vertical padding.
  - `--m3e-bottom-sheet-padding-inline`: The horizontal padding.
  - `--m3e-bottom-sheet-handle-container-height`: The height of the drag handle container.
  - `--m3e-bottom-sheet-handle-width`: The width of the drag handle.
  - `--m3e-bottom-sheet-handle-height`: The height of the drag handle.
  - `--m3e-bottom-sheet-handle-shape`: The border radius of the handle.
  - `--m3e-bottom-sheet-handle-color`: The color of the drag handle.
  - `--m3e-bottom-sheet-handle-focus-ring-offset`: The offset of the focus ring around the handle.
  - `--m3e-bottom-sheet-color`: The foreground (text) color of the sheet.
  - `--m3e-bottom-sheet-content-font-size`: Font size for the sheet content.
  - `--m3e-bottom-sheet-content-font-weight`: Font weight for the sheet content.
  - `--m3e-bottom-sheet-content-line-height`: Line height for the sheet content.
  - `--m3e-bottom-sheet-content-tracking`: Letter spacing (tracking) for the sheet content.
  - `--m3e-bottom-sheet-header-font-size`: Font size for the sheet header.
  - `--m3e-bottom-sheet-header-font-weight`: Font weight for the sheet header.
  - `--m3e-bottom-sheet-header-line-height`: Line height for the sheet header.
  - `--m3e-bottom-sheet-header-tracking`: Letter spacing (tracking) for the sheet header.

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-bottom-sheet" attributes children


{-| The zero‑based index of the detent the sheet should open to. (default: `0`)
-}
detent : Float -> Html.Attribute msg
detent val_ =
    Html.Attributes.property "detent" (Json.Encode.float val_)


{-| Whether to display a drag handle and enable the top region of the sheet as a gesture
surface for dragging between detents. (default: `false`)
-}
handle : Bool -> Html.Attribute msg
handle val_ =
    Html.Attributes.property "handle" (Json.Encode.bool val_)


{-| The accessible label given to the drag handle. (default: `"Drag handle"`)
-}
handleLabel : String -> Html.Attribute msg
handleLabel val_ =
    Html.Attributes.attribute "handle-label" val_


{-| Whether the bottom sheet can hide when its swiped down. (default: `false`)
-}
hideable : Bool -> Html.Attribute msg
hideable val_ =
    Html.Attributes.property "hideable" (Json.Encode.bool val_)


{-| The friction coefficient to hide the sheet. (default: `0.5`)
-}
hideFriction : Float -> Html.Attribute msg
hideFriction val_ =
    Html.Attributes.property "hide-friction" (Json.Encode.float val_)


{-| Whether the bottom sheet behaves as modal. (default: `false`)
-}
modal : Bool -> Html.Attribute msg
modal val_ =
    Html.Attributes.property "modal" (Json.Encode.bool val_)


{-| Whether the bottom sheet is open. (default: `false`)
-}
open : Bool -> Html.Attribute msg
open val_ =
    Html.Attributes.property "open" (Json.Encode.bool val_)


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`)
-}
overshootLimit : Float -> Html.Attribute msg
overshootLimit val_ =
    Html.Attributes.property "overshoot-limit" (Json.Encode.float val_)


{-| Dispatched when the sheet begins to open.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onOpening : Json.Decode.Decoder msg -> Html.Attribute msg
onOpening decoder =
    Html.Events.on "opening" decoder


{-| Dispatched when the sheet begins to close.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClosing : Json.Decode.Decoder msg -> Html.Attribute msg
onClosing decoder =
    Html.Events.on "closing" decoder


{-| Dispatched when the sheet is cancelled.

**Payload type:** `Event`

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onCancel : Json.Decode.Decoder msg -> Html.Attribute msg
onCancel decoder =
    Html.Events.on "cancel" decoder


{-| Dispatched when the sheet has opened.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onOpened : Json.Decode.Decoder msg -> Html.Attribute msg
onOpened decoder =
    Html.Events.on "opened" decoder


{-| Dispatched when the sheet has closed.

Custom event data is carried on the event's `detail` field — decode it with e.g. `Json.Decode.at [ "detail" ] yourDecoder`.

-}
onClosed : Json.Decode.Decoder msg -> Html.Attribute msg
onClosed decoder =
    Html.Events.on "closed" decoder


{-| Renders the header of the sheet.
-}
headerSlot : Html.Attribute msg
headerSlot =
    Html.Attributes.attribute "slot" "header"
