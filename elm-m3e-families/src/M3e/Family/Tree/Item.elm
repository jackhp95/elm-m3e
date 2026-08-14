module M3e.Family.Tree.Item exposing (el, Is, Attrs, Content, IconSlot, LabelSlot, OpenToggleIconSlot, SelectedIconSlot, ToggleIconSlot, ChildAdmittedBy, disabled, indeterminate, open, selected, defaultSelected, onOpening, onOpened, onClosing, onClosed, onClick, icon, label, openToggleIcon, selectedIcon, toggleIcon, child)

{-| `TreeItem`, grouped under the **Tree** family as `Item`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.TreeItem`](M3e.Component.TreeItem) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, IconSlot, LabelSlot, OpenToggleIconSlot, SelectedIconSlot, ToggleIconSlot, ChildAdmittedBy, disabled, indeterminate, open, selected, defaultSelected, onOpening, onOpened, onClosing, onClosed, onClick, icon, label, openToggleIcon, selectedIcon, toggleIcon, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.TreeItem as Orig


{-| See [`M3e.Component.TreeItem.el`](M3e.Component.TreeItem#el).
-}
el :
    { label : Element LabelSlot (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.TreeItem.Is`](M3e.Component.TreeItem#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.TreeItem.Attrs`](M3e.Component.TreeItem#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.TreeItem.Content`](M3e.Component.TreeItem#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.TreeItem.IconSlot`](M3e.Component.TreeItem#IconSlot).
-}
type alias IconSlot =
    Orig.IconSlot


{-| See [`M3e.Component.TreeItem.LabelSlot`](M3e.Component.TreeItem#LabelSlot).
-}
type alias LabelSlot =
    Orig.LabelSlot


{-| See [`M3e.Component.TreeItem.OpenToggleIconSlot`](M3e.Component.TreeItem#OpenToggleIconSlot).
-}
type alias OpenToggleIconSlot =
    Orig.OpenToggleIconSlot


{-| See [`M3e.Component.TreeItem.SelectedIconSlot`](M3e.Component.TreeItem#SelectedIconSlot).
-}
type alias SelectedIconSlot =
    Orig.SelectedIconSlot


{-| See [`M3e.Component.TreeItem.ToggleIconSlot`](M3e.Component.TreeItem#ToggleIconSlot).
-}
type alias ToggleIconSlot =
    Orig.ToggleIconSlot


{-| See [`M3e.Component.TreeItem.ChildAdmittedBy`](M3e.Component.TreeItem#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.TreeItem.disabled`](M3e.Component.TreeItem#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.TreeItem.indeterminate`](M3e.Component.TreeItem#indeterminate).
-}
indeterminate : Bool -> Attr { c | indeterminate : Supported } msg
indeterminate =
    Orig.indeterminate


{-| See [`M3e.Component.TreeItem.open`](M3e.Component.TreeItem#open).
-}
open : Bool -> Attr { c | open : Supported } msg
open =
    Orig.open


{-| See [`M3e.Component.TreeItem.selected`](M3e.Component.TreeItem#selected).
-}
selected : Bool -> Attr { c | selected : Supported } msg
selected =
    Orig.selected


{-| See [`M3e.Component.TreeItem.defaultSelected`](M3e.Component.TreeItem#defaultSelected).
-}
defaultSelected : Bool -> Attr { c | selected : Supported } msg
defaultSelected =
    Orig.defaultSelected


{-| See [`M3e.Component.TreeItem.onOpening`](M3e.Component.TreeItem#onOpening).
-}
onOpening : msg -> Attr { c | onOpening : Supported } msg
onOpening =
    Orig.onOpening


{-| See [`M3e.Component.TreeItem.onOpened`](M3e.Component.TreeItem#onOpened).
-}
onOpened : msg -> Attr { c | onOpened : Supported } msg
onOpened =
    Orig.onOpened


{-| See [`M3e.Component.TreeItem.onClosing`](M3e.Component.TreeItem#onClosing).
-}
onClosing : msg -> Attr { c | onClosing : Supported } msg
onClosing =
    Orig.onClosing


{-| See [`M3e.Component.TreeItem.onClosed`](M3e.Component.TreeItem#onClosed).
-}
onClosed : msg -> Attr { c | onClosed : Supported } msg
onClosed =
    Orig.onClosed


{-| See [`M3e.Component.TreeItem.onClick`](M3e.Component.TreeItem#onClick).
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Orig.onClick


{-| See [`M3e.Component.TreeItem.icon`](M3e.Component.TreeItem#icon).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon =
    Orig.icon


{-| See [`M3e.Component.TreeItem.label`](M3e.Component.TreeItem#label).
-}
label : Element LabelSlot admittedBy msg -> Element free freeAdmittedBy msg
label =
    Orig.label


{-| See [`M3e.Component.TreeItem.openToggleIcon`](M3e.Component.TreeItem#openToggleIcon).
-}
openToggleIcon : Element OpenToggleIconSlot admittedBy msg -> Element free freeAdmittedBy msg
openToggleIcon =
    Orig.openToggleIcon


{-| See [`M3e.Component.TreeItem.selectedIcon`](M3e.Component.TreeItem#selectedIcon).
-}
selectedIcon : Element SelectedIconSlot admittedBy msg -> Element free freeAdmittedBy msg
selectedIcon =
    Orig.selectedIcon


{-| See [`M3e.Component.TreeItem.toggleIcon`](M3e.Component.TreeItem#toggleIcon).
-}
toggleIcon : Element ToggleIconSlot admittedBy msg -> Element free freeAdmittedBy msg
toggleIcon =
    Orig.toggleIcon


{-| See [`M3e.Component.TreeItem.child`](M3e.Component.TreeItem#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
