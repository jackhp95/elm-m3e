module M3e.Cem.BottomSheet exposing
    ( bottomSheet, detent, handle, handleLabel, hideable, hideFriction
    , modal, open, overshootLimit, onOpening, onClosing, onCancel, onOpened
    , onClosed
    )

{-|
Middle layer for `<m3e-bottom-sheet>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.BottomSheet` module for everyday use.

@docs bottomSheet, detent, handle, handleLabel, hideable, hideFriction
@docs modal, open, overshootLimit, onOpening, onClosing, onCancel
@docs onOpened, onClosed
-}


import Html
import Json.Decode
import M3e.Cem.Attr
import M3e.Cem.Html.BottomSheet
import M3e.Value


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
bottomSheet :
    List (M3e.Cem.Attr.Attr { detent : M3e.Value.Supported
    , handle : M3e.Value.Supported
    , handleLabel : M3e.Value.Supported
    , hideable : M3e.Value.Supported
    , hideFriction : M3e.Value.Supported
    , modal : M3e.Value.Supported
    , open : M3e.Value.Supported
    , overshootLimit : M3e.Value.Supported
    , onOpening : M3e.Value.Supported
    , onClosing : M3e.Value.Supported
    , onCancel : M3e.Value.Supported
    , onOpened : M3e.Value.Supported
    , onClosed : M3e.Value.Supported
    , slot : M3e.Value.Supported
    } msg)
    -> List (Html.Html msg)
    -> Html.Html msg
bottomSheet attributes children =
    M3e.Cem.Html.BottomSheet.bottomSheet
        (List.map M3e.Cem.Attr.toAttribute attributes)
        children


{-| The zero‑based index of the detent the sheet should open to. (default: `0`) -}
detent : Float -> M3e.Cem.Attr.Attr { c | detent : M3e.Value.Supported } msg
detent =
    M3e.Cem.Attr.attribute M3e.Cem.Html.BottomSheet.detent


{-| Whether to display a drag handle and enable the top region of the sheet as a gesture
surface for dragging between detents. (default: `false`)
-}
handle : Bool -> M3e.Cem.Attr.Attr { c | handle : M3e.Value.Supported } msg
handle =
    M3e.Cem.Attr.attribute M3e.Cem.Html.BottomSheet.handle


{-| The accessible label given to the drag handle. (default: `"Drag handle"`) -}
handleLabel :
    String -> M3e.Cem.Attr.Attr { c | handleLabel : M3e.Value.Supported } msg
handleLabel =
    M3e.Cem.Attr.attribute M3e.Cem.Html.BottomSheet.handleLabel


{-| Whether the bottom sheet can hide when its swiped down. (default: `false`) -}
hideable : Bool -> M3e.Cem.Attr.Attr { c | hideable : M3e.Value.Supported } msg
hideable =
    M3e.Cem.Attr.attribute M3e.Cem.Html.BottomSheet.hideable


{-| The friction coefficient to hide the sheet. (default: `0.5`) -}
hideFriction :
    Float -> M3e.Cem.Attr.Attr { c | hideFriction : M3e.Value.Supported } msg
hideFriction =
    M3e.Cem.Attr.attribute M3e.Cem.Html.BottomSheet.hideFriction


{-| Whether the bottom sheet behaves as modal. (default: `false`) -}
modal : Bool -> M3e.Cem.Attr.Attr { c | modal : M3e.Value.Supported } msg
modal =
    M3e.Cem.Attr.attribute M3e.Cem.Html.BottomSheet.modal


{-| Whether the bottom sheet is open. (default: `false`) -}
open : Bool -> M3e.Cem.Attr.Attr { c | open : M3e.Value.Supported } msg
open =
    M3e.Cem.Attr.attribute M3e.Cem.Html.BottomSheet.open


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`) -}
overshootLimit :
    Float -> M3e.Cem.Attr.Attr { c | overshootLimit : M3e.Value.Supported } msg
overshootLimit =
    M3e.Cem.Attr.attribute M3e.Cem.Html.BottomSheet.overshootLimit


{-| Listen for `opening` events. -}
onOpening : msg -> M3e.Cem.Attr.Attr { c | onOpening : M3e.Value.Supported } msg
onOpening f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.BottomSheet.onOpening
        (Json.Decode.succeed f_)


{-| Listen for `closing` events. -}
onClosing : msg -> M3e.Cem.Attr.Attr { c | onClosing : M3e.Value.Supported } msg
onClosing f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.BottomSheet.onClosing
        (Json.Decode.succeed f_)


{-| Listen for `cancel` events. -}
onCancel : msg -> M3e.Cem.Attr.Attr { c | onCancel : M3e.Value.Supported } msg
onCancel f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.BottomSheet.onCancel
        (Json.Decode.succeed f_)


{-| Listen for `opened` events. -}
onOpened : msg -> M3e.Cem.Attr.Attr { c | onOpened : M3e.Value.Supported } msg
onOpened f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.BottomSheet.onOpened
        (Json.Decode.succeed f_)


{-| Listen for `closed` events. -}
onClosed : msg -> M3e.Cem.Attr.Attr { c | onClosed : M3e.Value.Supported } msg
onClosed f_ =
    M3e.Cem.Attr.attribute
        M3e.Cem.Html.BottomSheet.onClosed
        (Json.Decode.succeed f_)