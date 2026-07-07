module M3e.BottomSheet exposing
    ( view, detent, handle, handleLabel, hideable, hideFriction
    , modal, open, overshootLimit, onOpening, onClosing, onCancel, onOpened
    , onClosed, header
    )

{-|
A sheet used to show secondary content anchored to the bottom of the screen.

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

<!-- elm-cem:docmeta category=Containment -->

## Examples

### Examples

<!-- elm-cem:example title="Choose a destination" -->
```elm
M3e.BottomSheet.view [ M3e.BottomSheet.modal True, M3e.BottomSheet.handle True, M3e.BottomSheet.hideable True ] [ M3e.BottomSheet.header (M3e.Heading.view [ M3e.Heading.variant M3e.Value.title, M3e.Heading.size M3e.Value.large ] [ M3e.Heading.child (Kit.text "Choose a destination") ]) ]
```

@docs view, detent, handle, handleLabel, hideable, hideFriction
@docs modal, open, overshootLimit, onOpening, onClosing, onCancel
@docs onOpened, onClosed, header
-}


import M3e.Cem.Attr
import M3e.Cem.Attr.Internal
import M3e.Cem.BottomSheet
import M3e.Element
import M3e.Element.Internal
import M3e.Node
import M3e.Value


{-| Build the `<m3e-bottom-sheet>` element (lazy IR). -}
view :
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
    -> List (M3e.Element.Element any msg)
    -> M3e.Element.Element { s | bottomSheet : M3e.Value.Supported } msg
view attributes children =
    M3e.Element.Internal.fromNode
        (M3e.Node.fromComponent
             (\erased ch ->
                  M3e.Cem.BottomSheet.bottomSheet
                      (List.map M3e.Cem.Attr.Internal.forget erased)
                      ch
             )
             (List.map M3e.Cem.Attr.Internal.forget attributes)
             (List.map M3e.Element.toNode children)
        )


{-| The zero‑based index of the detent the sheet should open to. (default: `0`) -}
detent : Float -> M3e.Cem.Attr.Attr { c | detent : M3e.Value.Supported } msg
detent =
    M3e.Cem.BottomSheet.detent


{-| Whether to display a drag handle and enable the top region of the sheet as a gesture
surface for dragging between detents. (default: `false`)
-}
handle : Bool -> M3e.Cem.Attr.Attr { c | handle : M3e.Value.Supported } msg
handle =
    M3e.Cem.BottomSheet.handle


{-| The accessible label given to the drag handle. (default: `"Drag handle"`) -}
handleLabel :
    String -> M3e.Cem.Attr.Attr { c | handleLabel : M3e.Value.Supported } msg
handleLabel =
    M3e.Cem.BottomSheet.handleLabel


{-| Whether the bottom sheet can hide when its swiped down. (default: `false`) -}
hideable : Bool -> M3e.Cem.Attr.Attr { c | hideable : M3e.Value.Supported } msg
hideable =
    M3e.Cem.BottomSheet.hideable


{-| The friction coefficient to hide the sheet. (default: `0.5`) -}
hideFriction :
    Float -> M3e.Cem.Attr.Attr { c | hideFriction : M3e.Value.Supported } msg
hideFriction =
    M3e.Cem.BottomSheet.hideFriction


{-| Whether the bottom sheet behaves as modal. (default: `false`) -}
modal : Bool -> M3e.Cem.Attr.Attr { c | modal : M3e.Value.Supported } msg
modal =
    M3e.Cem.BottomSheet.modal


{-| Whether the bottom sheet is open. (default: `false`) -}
open : Bool -> M3e.Cem.Attr.Attr { c | open : M3e.Value.Supported } msg
open =
    M3e.Cem.BottomSheet.open


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`) -}
overshootLimit :
    Float -> M3e.Cem.Attr.Attr { c | overshootLimit : M3e.Value.Supported } msg
overshootLimit =
    M3e.Cem.BottomSheet.overshootLimit


{-| Listen for `opening` events. -}
onOpening : msg -> M3e.Cem.Attr.Attr { c | onOpening : M3e.Value.Supported } msg
onOpening =
    M3e.Cem.BottomSheet.onOpening


{-| Listen for `closing` events. -}
onClosing : msg -> M3e.Cem.Attr.Attr { c | onClosing : M3e.Value.Supported } msg
onClosing =
    M3e.Cem.BottomSheet.onClosing


{-| Listen for `cancel` events. -}
onCancel : msg -> M3e.Cem.Attr.Attr { c | onCancel : M3e.Value.Supported } msg
onCancel =
    M3e.Cem.BottomSheet.onCancel


{-| Listen for `opened` events. -}
onOpened : msg -> M3e.Cem.Attr.Attr { c | onOpened : M3e.Value.Supported } msg
onOpened =
    M3e.Cem.BottomSheet.onOpened


{-| Listen for `closed` events. -}
onClosed : msg -> M3e.Cem.Attr.Attr { c | onClosed : M3e.Value.Supported } msg
onClosed =
    M3e.Cem.BottomSheet.onClosed


{-| Place content in the `header` slot. -}
header : M3e.Element.Element any msg -> M3e.Element.Element k msg
header el =
    M3e.Element.Internal.placeSlot "header" el