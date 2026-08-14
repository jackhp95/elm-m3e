module M3e.Family.BottomSheet exposing (el, Is, Attrs, ChildAdmittedBy, detent, detents, handle, handleLabel, hideFriction, hideable, modal, open, overshootLimit, onOpening, onClosing, onCancel, onOpened, onClosed, header, child)

{-| The **BottomSheet** family root — re-export of `M3e.Component.BottomSheet`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.BottomSheet`](M3e.Component.BottomSheet) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, detent, detents, handle, handleLabel, hideFriction, hideable, modal, open, overshootLimit, onOpening, onClosing, onCancel, onOpened, onClosed, header, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.BottomSheet as Orig


{-| See [`M3e.Component.BottomSheet.el`](M3e.Component.BottomSheet#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.BottomSheet.Is`](M3e.Component.BottomSheet#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.BottomSheet.Attrs`](M3e.Component.BottomSheet#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.BottomSheet.ChildAdmittedBy`](M3e.Component.BottomSheet#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.BottomSheet.detent`](M3e.Component.BottomSheet#detent).
-}
detent : Float -> Attr { c | detent : Supported } msg
detent =
    Orig.detent


{-| See [`M3e.Component.BottomSheet.detents`](M3e.Component.BottomSheet#detents).
-}
detents : String -> Attr { c | detents : Supported } msg
detents =
    Orig.detents


{-| See [`M3e.Component.BottomSheet.handle`](M3e.Component.BottomSheet#handle).
-}
handle : Bool -> Attr { c | handle : Supported } msg
handle =
    Orig.handle


{-| See [`M3e.Component.BottomSheet.handleLabel`](M3e.Component.BottomSheet#handleLabel).
-}
handleLabel : String -> Attr { c | handleLabel : Supported } msg
handleLabel =
    Orig.handleLabel


{-| See [`M3e.Component.BottomSheet.hideFriction`](M3e.Component.BottomSheet#hideFriction).
-}
hideFriction : Float -> Attr { c | hideFriction : Supported } msg
hideFriction =
    Orig.hideFriction


{-| See [`M3e.Component.BottomSheet.hideable`](M3e.Component.BottomSheet#hideable).
-}
hideable : Bool -> Attr { c | hideable : Supported } msg
hideable =
    Orig.hideable


{-| See [`M3e.Component.BottomSheet.modal`](M3e.Component.BottomSheet#modal).
-}
modal : Bool -> Attr { c | modal : Supported } msg
modal =
    Orig.modal


{-| See [`M3e.Component.BottomSheet.open`](M3e.Component.BottomSheet#open).
-}
open : Bool -> Attr { c | open : Supported } msg
open =
    Orig.open


{-| See [`M3e.Component.BottomSheet.overshootLimit`](M3e.Component.BottomSheet#overshootLimit).
-}
overshootLimit : Float -> Attr { c | overshootLimit : Supported } msg
overshootLimit =
    Orig.overshootLimit


{-| See [`M3e.Component.BottomSheet.onOpening`](M3e.Component.BottomSheet#onOpening).
-}
onOpening : msg -> Attr { c | onOpening : Supported } msg
onOpening =
    Orig.onOpening


{-| See [`M3e.Component.BottomSheet.onClosing`](M3e.Component.BottomSheet#onClosing).
-}
onClosing : msg -> Attr { c | onClosing : Supported } msg
onClosing =
    Orig.onClosing


{-| See [`M3e.Component.BottomSheet.onCancel`](M3e.Component.BottomSheet#onCancel).
-}
onCancel : msg -> Attr { c | onCancel : Supported } msg
onCancel =
    Orig.onCancel


{-| See [`M3e.Component.BottomSheet.onOpened`](M3e.Component.BottomSheet#onOpened).
-}
onOpened : msg -> Attr { c | onOpened : Supported } msg
onOpened =
    Orig.onOpened


{-| See [`M3e.Component.BottomSheet.onClosed`](M3e.Component.BottomSheet#onClosed).
-}
onClosed : msg -> Attr { c | onClosed : Supported } msg
onClosed =
    Orig.onClosed


{-| See [`M3e.Component.BottomSheet.header`](M3e.Component.BottomSheet#header).
-}
header : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
header =
    Orig.header


{-| See [`M3e.Component.BottomSheet.child`](M3e.Component.BottomSheet#child).
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
