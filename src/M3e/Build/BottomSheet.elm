module M3e.Build.BottomSheet exposing
    ( Builder, AttrCaps, SlotCaps, bottomSheet, attr, detent
    , detents, handle, handleLabel, hideable, hideFriction, modal
    , open, overshootLimit, onOpening, onClosing, onCancel, onOpened
    , onClosed, header, build
    )

{-| The Build form for `<m3e-bottom-sheet>` — phantom-typed pipeline API. Import qualified: `import M3e.Build.BottomSheet as BottomSheet`.

@docs Builder, AttrCaps, SlotCaps, bottomSheet, attr, detent
@docs detents, handle, handleLabel, hideable, hideFriction, modal
@docs open, overshootLimit, onOpening, onClosing, onCancel, onOpened
@docs onClosed, header, build

-}

import M3e.Build.Internal
import M3e.Element
import M3e.Element.Internal
import M3e.Html.Attr.Internal
import M3e.Html.BottomSheet
import M3e.Node
import M3e.Token


{-| Phantom-typed opaque builder for `<m3e-bottom-sheet>`.
-}
type alias Builder attrCaps slotCaps msg kind =
    M3e.Build.Internal.Builder
        { kind
            | bottomSheet : M3e.Token.Supported
        }
        attrCaps
        slotCaps
        msg


{-| Per-component attribute capability row for the phantom-typed Builder.
-}
type alias AttrCaps =
    { detent : M3e.Build.Internal.Available
    , detents : M3e.Build.Internal.Available
    , handle : M3e.Build.Internal.Available
    , handleLabel : M3e.Build.Internal.Available
    , hideable : M3e.Build.Internal.Available
    , hideFriction : M3e.Build.Internal.Available
    , modal : M3e.Build.Internal.Available
    , open : M3e.Build.Internal.Available
    , overshootLimit : M3e.Build.Internal.Available
    , onOpening : M3e.Build.Internal.Available
    , onClosing : M3e.Build.Internal.Available
    , onCancel : M3e.Build.Internal.Available
    , onOpened : M3e.Build.Internal.Available
    , onClosed : M3e.Build.Internal.Available
    }


{-| Per-component slot capability row for the phantom-typed Builder.
-}
type alias SlotCaps =
    { header : M3e.Build.Internal.Available }


{-| Seed a `Builder` for `<m3e-bottom-sheet>`.
-}
bottomSheet : Builder AttrCaps SlotCaps msg kind
bottomSheet =
    M3e.Build.Internal.wrap_
        (M3e.Node.fromComponent
            (\erased_ ch_ ->
                M3e.Html.BottomSheet.bottomSheet
                    (List.map M3e.Html.Attr.Internal.forget erased_)
                    ch_
            )
            []
            []
        )


{-| Inject an already-built universal `Attr` (e.g. from `M3e.Aria.*`) into the pipeline, appending it to the accumulated attrs. Unlike the typed per-attribute setters it consumes no phantom capability, so it can be applied any number of times.
-}
attr :
    M3e.Html.Attr.Internal.Attr caps msg
    -> Builder a s msg kind
    -> Builder a s msg kind
attr a_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget a_)
            (M3e.Build.Internal.node_ b_)
        )


{-| The zero‑based index of the detent the sheet should open to. (default: `0`)
-}
detent :
    Float
    -> Builder { a | detent : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | detent : M3e.Build.Internal.Used } s msg kind
detent v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.BottomSheet.detent v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Detents (discrete height states) the sheet can snap to. (default: `[]`)
-}
detents :
    String
    -> Builder { a | detents : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | detents : M3e.Build.Internal.Used } s msg kind
detents v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.BottomSheet.detents v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether to display a drag handle and enable the top region of the sheet as a gesture
surface for dragging between detents. (default: `false`)
-}
handle :
    Bool
    -> Builder { a | handle : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | handle : M3e.Build.Internal.Used } s msg kind
handle v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.BottomSheet.handle v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The accessible label given to the drag handle. (default: `"Drag handle"`)
-}
handleLabel :
    String
    -> Builder { a | handleLabel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | handleLabel : M3e.Build.Internal.Used } s msg kind
handleLabel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.BottomSheet.handleLabel v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the bottom sheet can hide when its swiped down. (default: `false`)
-}
hideable :
    Bool
    -> Builder { a | hideable : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | hideable : M3e.Build.Internal.Used } s msg kind
hideable v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.BottomSheet.hideable v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| The friction coefficient to hide the sheet. (default: `0.5`)
-}
hideFriction :
    Float
    -> Builder { a | hideFriction : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | hideFriction : M3e.Build.Internal.Used } s msg kind
hideFriction v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.BottomSheet.hideFriction v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the bottom sheet behaves as modal. (default: `false`)
-}
modal :
    Bool
    -> Builder { a | modal : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | modal : M3e.Build.Internal.Used } s msg kind
modal v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.BottomSheet.modal v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Whether the bottom sheet is open. (default: `false`)
-}
open :
    Bool
    -> Builder { a | open : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | open : M3e.Build.Internal.Used } s msg kind
open v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.BottomSheet.open v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| A fractional value, between 0 and 100, indicating the maximum visual overshoot allowed when dragging past the minimum or maximum size. (default: `4`)
-}
overshootLimit :
    Float
    -> Builder { a | overshootLimit : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | overshootLimit : M3e.Build.Internal.Used } s msg kind
overshootLimit v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget
                (M3e.Html.BottomSheet.overshootLimit v_)
            )
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the sheet begins to open.
-}
onOpening :
    msg
    -> Builder { a | onOpening : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onOpening : M3e.Build.Internal.Used } s msg kind
onOpening v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.BottomSheet.onOpening v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the sheet begins to close.
-}
onClosing :
    msg
    -> Builder { a | onClosing : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClosing : M3e.Build.Internal.Used } s msg kind
onClosing v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.BottomSheet.onClosing v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the sheet is cancelled.
-}
onCancel :
    msg
    -> Builder { a | onCancel : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onCancel : M3e.Build.Internal.Used } s msg kind
onCancel v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.BottomSheet.onCancel v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the sheet has opened.
-}
onOpened :
    msg
    -> Builder { a | onOpened : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onOpened : M3e.Build.Internal.Used } s msg kind
onOpened v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.BottomSheet.onOpened v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Dispatched when the sheet has closed.
-}
onClosed :
    msg
    -> Builder { a | onClosed : M3e.Build.Internal.Available } s msg kind
    -> Builder { a | onClosed : M3e.Build.Internal.Used } s msg kind
onClosed v_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addAttr
            (M3e.Html.Attr.Internal.forget (M3e.Html.BottomSheet.onClosed v_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Place content in the `header` slot.
-}
header :
    M3e.Element.Element any msg
    -> Builder a { s | header : M3e.Build.Internal.Available } msg kind
    -> Builder a { s | header : M3e.Build.Internal.Used } msg kind
header el_ b_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Element.toNode (M3e.Element.withSlot "header" el_))
            (M3e.Build.Internal.node_ b_)
        )


{-| Build the `<m3e-bottom-sheet>` element from a `Builder`.
-}
build :
    Builder a s msg kind
    -> M3e.Element.Element { bottomSheet : M3e.Token.Supported } msg
build b_ =
    M3e.Element.Internal.fromNode (M3e.Build.Internal.node_ b_)
