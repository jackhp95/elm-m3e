module M3e.Html.BottomSheet exposing
    ( bottomSheet, detent, detents, handle, handleLabel, hideable
    , hideFriction, modal, open, overshootLimit, onOpening, onClosing
    , onCancel, onOpened, onClosed
    )

{-| Middle layer for `<m3e-bottom-sheet>`: the phantom-typed `Attr` setters (each an OPEN capability row) and an eager component that evaluates them onto the bottom `elm/html` layer. This is the loose, escape-hatch form; prefer the strict `M3e.BottomSheet` module for everyday use.

@docs bottomSheet, detent, detents, handle, handleLabel, hideable
@docs hideFriction, modal, open, overshootLimit, onOpening, onClosing
@docs onCancel, onOpened, onClosed

-}

import Html
import Json.Decode
import M3e.Html.Attr
import M3e.Html.Attr.Internal
import M3e.Raw.BottomSheet
import M3e.Token


{-| A sheet used to show secondary content anchored to the bottom of the screen.

**Component Info:**

  - **Extends:** `LitElement`

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
    List
        (M3e.Html.Attr.Attr
            { detent : M3e.Token.Supported
            , detents : M3e.Token.Supported
            , handle : M3e.Token.Supported
            , handleLabel : M3e.Token.Supported
            , hideable : M3e.Token.Supported
            , hideFriction : M3e.Token.Supported
            , modal : M3e.Token.Supported
            , open : M3e.Token.Supported
            , overshootLimit : M3e.Token.Supported
            , onOpening : M3e.Token.Supported
            , onClosing : M3e.Token.Supported
            , onCancel : M3e.Token.Supported
            , onOpened : M3e.Token.Supported
            , onClosed : M3e.Token.Supported
            , slot : M3e.Token.Supported
            }
            msg
        )
    -> List (Html.Html msg)
    -> Html.Html msg
bottomSheet attributes children =
    M3e.Raw.BottomSheet.bottomSheet
        (List.map M3e.Html.Attr.toAttribute attributes)
        children


{-| The zero‑based index of the detent the sheet should open to. (default: `0`)
-}
detent : Float -> M3e.Html.Attr.Attr { c | detent : M3e.Token.Supported } msg
detent =
    M3e.Html.Attr.Internal.attribute M3e.Raw.BottomSheet.detent


{-| Detents (discrete height states) the sheet can snap to. (default: `[]`)
-}
detents : String -> M3e.Html.Attr.Attr { c | detents : M3e.Token.Supported } msg
detents =
    M3e.Html.Attr.Internal.attribute M3e.Raw.BottomSheet.detents


{-| Whether to display a drag handle and enable the top region of the sheet as a gesture
surface for dragging between detents. (default: `false`)
-}
handle : Bool -> M3e.Html.Attr.Attr { c | handle : M3e.Token.Supported } msg
handle =
    M3e.Html.Attr.Internal.attribute M3e.Raw.BottomSheet.handle


{-| The accessible label given to the drag handle. (default: `"Drag handle"`)
-}
handleLabel : String -> M3e.Html.Attr.Attr { c | handleLabel : M3e.Token.Supported } msg
handleLabel =
    M3e.Html.Attr.Internal.attribute M3e.Raw.BottomSheet.handleLabel


{-| Whether the bottom sheet can hide when its swiped down. (default: `false`)
-}
hideable : Bool -> M3e.Html.Attr.Attr { c | hideable : M3e.Token.Supported } msg
hideable =
    M3e.Html.Attr.Internal.attribute M3e.Raw.BottomSheet.hideable


{-| The friction coefficient to hide the sheet. (default: `0.5`)
-}
hideFriction : Float -> M3e.Html.Attr.Attr { c | hideFriction : M3e.Token.Supported } msg
hideFriction =
    M3e.Html.Attr.Internal.attribute M3e.Raw.BottomSheet.hideFriction


{-| Whether the bottom sheet behaves as modal. (default: `false`)
-}
modal : Bool -> M3e.Html.Attr.Attr { c | modal : M3e.Token.Supported } msg
modal =
    M3e.Html.Attr.Internal.attribute M3e.Raw.BottomSheet.modal


{-| Whether the bottom sheet is open. (default: `false`)
-}
open : Bool -> M3e.Html.Attr.Attr { c | open : M3e.Token.Supported } msg
open =
    M3e.Html.Attr.Internal.attribute M3e.Raw.BottomSheet.open


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`)
-}
overshootLimit : Float -> M3e.Html.Attr.Attr { c | overshootLimit : M3e.Token.Supported } msg
overshootLimit =
    M3e.Html.Attr.Internal.attribute M3e.Raw.BottomSheet.overshootLimit


{-| Listen for `opening` events.
-}
onOpening : msg -> M3e.Html.Attr.Attr { c | onOpening : M3e.Token.Supported } msg
onOpening f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.BottomSheet.onOpening
        (Json.Decode.succeed f_)


{-| Listen for `closing` events.
-}
onClosing : msg -> M3e.Html.Attr.Attr { c | onClosing : M3e.Token.Supported } msg
onClosing f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.BottomSheet.onClosing
        (Json.Decode.succeed f_)


{-| Listen for `cancel` events.
-}
onCancel : msg -> M3e.Html.Attr.Attr { c | onCancel : M3e.Token.Supported } msg
onCancel f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.BottomSheet.onCancel
        (Json.Decode.succeed f_)


{-| Listen for `opened` events.
-}
onOpened : msg -> M3e.Html.Attr.Attr { c | onOpened : M3e.Token.Supported } msg
onOpened f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.BottomSheet.onOpened
        (Json.Decode.succeed f_)


{-| Listen for `closed` events.
-}
onClosed : msg -> M3e.Html.Attr.Attr { c | onClosed : M3e.Token.Supported } msg
onClosed f_ =
    M3e.Html.Attr.Internal.attribute
        M3e.Raw.BottomSheet.onClosed
        (Json.Decode.succeed f_)
