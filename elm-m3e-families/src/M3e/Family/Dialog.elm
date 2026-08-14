module M3e.Family.Dialog exposing (el, Is, Attrs, CloseIconSlot, HeaderSlot, ChildAdmittedBy, alert, closeLabel, disableClose, dismissible, noFocusTrap, open, onOpening, onOpened, onClosing, onClosed, onCancel, actions, closeIcon, header, child)

{-| The **Dialog** family root — re-export of `M3e.Component.Dialog`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.Dialog`](M3e.Component.Dialog) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, CloseIconSlot, HeaderSlot, ChildAdmittedBy, alert, closeLabel, disableClose, dismissible, noFocusTrap, open, onOpening, onOpened, onClosing, onClosed, onCancel, actions, closeIcon, header, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.Dialog as Orig


{-| See [`M3e.Component.Dialog.el`](M3e.Component.Dialog#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.Dialog.Is`](M3e.Component.Dialog#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.Dialog.Attrs`](M3e.Component.Dialog#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.Dialog.CloseIconSlot`](M3e.Component.Dialog#CloseIconSlot).
-}
type alias CloseIconSlot =
    Orig.CloseIconSlot


{-| See [`M3e.Component.Dialog.HeaderSlot`](M3e.Component.Dialog#HeaderSlot).
-}
type alias HeaderSlot =
    Orig.HeaderSlot


{-| See [`M3e.Component.Dialog.ChildAdmittedBy`](M3e.Component.Dialog#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.Dialog.alert`](M3e.Component.Dialog#alert).
-}
alert : Bool -> Attr { c | alert : Supported } msg
alert =
    Orig.alert


{-| See [`M3e.Component.Dialog.closeLabel`](M3e.Component.Dialog#closeLabel).
-}
closeLabel : String -> Attr { c | closeLabel : Supported } msg
closeLabel =
    Orig.closeLabel


{-| See [`M3e.Component.Dialog.disableClose`](M3e.Component.Dialog#disableClose).
-}
disableClose : Bool -> Attr { c | disableClose : Supported } msg
disableClose =
    Orig.disableClose


{-| See [`M3e.Component.Dialog.dismissible`](M3e.Component.Dialog#dismissible).
-}
dismissible : Bool -> Attr { c | dismissible : Supported } msg
dismissible =
    Orig.dismissible


{-| See [`M3e.Component.Dialog.noFocusTrap`](M3e.Component.Dialog#noFocusTrap).
-}
noFocusTrap : Bool -> Attr { c | noFocusTrap : Supported } msg
noFocusTrap =
    Orig.noFocusTrap


{-| See [`M3e.Component.Dialog.open`](M3e.Component.Dialog#open).
-}
open : Bool -> Attr { c | open : Supported } msg
open =
    Orig.open


{-| See [`M3e.Component.Dialog.onOpening`](M3e.Component.Dialog#onOpening).
-}
onOpening : msg -> Attr { c | onOpening : Supported } msg
onOpening =
    Orig.onOpening


{-| See [`M3e.Component.Dialog.onOpened`](M3e.Component.Dialog#onOpened).
-}
onOpened : msg -> Attr { c | onOpened : Supported } msg
onOpened =
    Orig.onOpened


{-| See [`M3e.Component.Dialog.onClosing`](M3e.Component.Dialog#onClosing).
-}
onClosing : msg -> Attr { c | onClosing : Supported } msg
onClosing =
    Orig.onClosing


{-| See [`M3e.Component.Dialog.onClosed`](M3e.Component.Dialog#onClosed).
-}
onClosed : msg -> Attr { c | onClosed : Supported } msg
onClosed =
    Orig.onClosed


{-| See [`M3e.Component.Dialog.onCancel`](M3e.Component.Dialog#onCancel).
-}
onCancel : msg -> Attr { c | onCancel : Supported } msg
onCancel =
    Orig.onCancel


{-| See [`M3e.Component.Dialog.actions`](M3e.Component.Dialog#actions).
-}
actions : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
actions =
    Orig.actions


{-| See [`M3e.Component.Dialog.closeIcon`](M3e.Component.Dialog#closeIcon).
-}
closeIcon : Element CloseIconSlot admittedBy msg -> Element free freeAdmittedBy msg
closeIcon =
    Orig.closeIcon


{-| See [`M3e.Component.Dialog.header`](M3e.Component.Dialog#header).
-}
header : Element HeaderSlot admittedBy msg -> Element free freeAdmittedBy msg
header =
    Orig.header


{-| See [`M3e.Component.Dialog.child`](M3e.Component.Dialog#child).
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
