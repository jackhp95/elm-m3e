module M3e.BottomSheet exposing
    ( component
    , handle, handleLabel, hideable, hideFriction, modal, open
    , onOpening, onClosing, onCancel, onOpened, onClosed
    , headerSlot
    )

{-| A sheet used to show secondary content anchored to the bottom of the screen.


## Component

@docs component


### Attributes

@docs handle, handleLabel, hideable, hideFriction, modal, open


### Events

@docs onOpening, onClosing, onCancel, onOpened, onClosed


### Slots

@docs headerSlot


### Omitted Attributes

The following attribute setters were omitted because Elm cannot pass DOM element references:

  - `detents`: string[]

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

-}
component : List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg
component attributes children =
    Html.node "m3e-bottom-sheet" attributes children


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
