module M3e.Family.Stepper.Step exposing (el, Is, Attrs, Content, DoneIconSlot, EditIconSlot, ErrorSlot, ErrorIconSlot, HintSlot, IconSlot, ChildAdmittedBy, completed, disabled, editable, for, invalid, optional, selected, defaultSelected, onBeforeinput, onInput, onChange, onClick, doneIcon, editIcon, error, errorIcon, hint, icon, child)

{-| `Step`, grouped under the **Stepper** family as `Step`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.Step`](M3e.Component.Step) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, DoneIconSlot, EditIconSlot, ErrorSlot, ErrorIconSlot, HintSlot, IconSlot, ChildAdmittedBy, completed, disabled, editable, for, invalid, optional, selected, defaultSelected, onBeforeinput, onInput, onChange, onClick, doneIcon, editIcon, error, errorIcon, hint, icon, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.Step as Orig


{-| See [`M3e.Component.Step.el`](M3e.Component.Step#el).
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.Step.Is`](M3e.Component.Step#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.Step.Attrs`](M3e.Component.Step#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.Step.Content`](M3e.Component.Step#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.Step.DoneIconSlot`](M3e.Component.Step#DoneIconSlot).
-}
type alias DoneIconSlot =
    Orig.DoneIconSlot


{-| See [`M3e.Component.Step.EditIconSlot`](M3e.Component.Step#EditIconSlot).
-}
type alias EditIconSlot =
    Orig.EditIconSlot


{-| See [`M3e.Component.Step.ErrorSlot`](M3e.Component.Step#ErrorSlot).
-}
type alias ErrorSlot =
    Orig.ErrorSlot


{-| See [`M3e.Component.Step.ErrorIconSlot`](M3e.Component.Step#ErrorIconSlot).
-}
type alias ErrorIconSlot =
    Orig.ErrorIconSlot


{-| See [`M3e.Component.Step.HintSlot`](M3e.Component.Step#HintSlot).
-}
type alias HintSlot =
    Orig.HintSlot


{-| See [`M3e.Component.Step.IconSlot`](M3e.Component.Step#IconSlot).
-}
type alias IconSlot =
    Orig.IconSlot


{-| See [`M3e.Component.Step.ChildAdmittedBy`](M3e.Component.Step#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.Step.completed`](M3e.Component.Step#completed).
-}
completed : Bool -> Attr { c | completed : Supported } msg
completed =
    Orig.completed


{-| See [`M3e.Component.Step.disabled`](M3e.Component.Step#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.Step.editable`](M3e.Component.Step#editable).
-}
editable : Bool -> Attr { c | editable : Supported } msg
editable =
    Orig.editable


{-| See [`M3e.Component.Step.for`](M3e.Component.Step#for).
-}
for : String -> Attr { c | for : Supported } msg
for =
    Orig.for


{-| See [`M3e.Component.Step.invalid`](M3e.Component.Step#invalid).
-}
invalid : Bool -> Attr { c | invalid : Supported } msg
invalid =
    Orig.invalid


{-| See [`M3e.Component.Step.optional`](M3e.Component.Step#optional).
-}
optional : Bool -> Attr { c | optional : Supported } msg
optional =
    Orig.optional


{-| See [`M3e.Component.Step.selected`](M3e.Component.Step#selected).
-}
selected : Bool -> Attr { c | selected : Supported } msg
selected =
    Orig.selected


{-| See [`M3e.Component.Step.defaultSelected`](M3e.Component.Step#defaultSelected).
-}
defaultSelected : Bool -> Attr { c | selected : Supported } msg
defaultSelected =
    Orig.defaultSelected


{-| See [`M3e.Component.Step.onBeforeinput`](M3e.Component.Step#onBeforeinput).
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput =
    Orig.onBeforeinput


{-| See [`M3e.Component.Step.onInput`](M3e.Component.Step#onInput).
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    Orig.onInput


{-| See [`M3e.Component.Step.onChange`](M3e.Component.Step#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.Step.onClick`](M3e.Component.Step#onClick).
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Orig.onClick


{-| See [`M3e.Component.Step.doneIcon`](M3e.Component.Step#doneIcon).
-}
doneIcon : Element DoneIconSlot admittedBy msg -> Element free freeAdmittedBy msg
doneIcon =
    Orig.doneIcon


{-| See [`M3e.Component.Step.editIcon`](M3e.Component.Step#editIcon).
-}
editIcon : Element EditIconSlot admittedBy msg -> Element free freeAdmittedBy msg
editIcon =
    Orig.editIcon


{-| See [`M3e.Component.Step.error`](M3e.Component.Step#error).
-}
error : Element ErrorSlot admittedBy msg -> Element free freeAdmittedBy msg
error =
    Orig.error


{-| See [`M3e.Component.Step.errorIcon`](M3e.Component.Step#errorIcon).
-}
errorIcon : Element ErrorIconSlot admittedBy msg -> Element free freeAdmittedBy msg
errorIcon =
    Orig.errorIcon


{-| See [`M3e.Component.Step.hint`](M3e.Component.Step#hint).
-}
hint : Element HintSlot admittedBy msg -> Element free freeAdmittedBy msg
hint =
    Orig.hint


{-| See [`M3e.Component.Step.icon`](M3e.Component.Step#icon).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon =
    Orig.icon


{-| See [`M3e.Component.Step.child`](M3e.Component.Step#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
