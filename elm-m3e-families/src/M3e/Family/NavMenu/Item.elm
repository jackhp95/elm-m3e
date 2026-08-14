module M3e.Family.NavMenu.Item exposing (el, Is, Attrs, Content, BadgeSlot, IconSlot, LabelSlot, SelectedIconSlot, ToggleIconSlot, ChildAdmittedBy, disabled, open, selected, defaultSelected, onOpening, onOpened, onClosing, onClosed, onClick, badge, icon, label, selectedIcon, toggleIcon, child)

{-| `NavMenuItem`, grouped under the **NavMenu** family as `Item`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.NavMenuItem`](M3e.Component.NavMenuItem) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, BadgeSlot, IconSlot, LabelSlot, SelectedIconSlot, ToggleIconSlot, ChildAdmittedBy, disabled, open, selected, defaultSelected, onOpening, onOpened, onClosing, onClosed, onClick, badge, icon, label, selectedIcon, toggleIcon, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.NavMenuItem as Orig


{-| See [`M3e.Component.NavMenuItem.el`](M3e.Component.NavMenuItem#el).
-}
el :
    { label : Element LabelSlot (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.NavMenuItem.Is`](M3e.Component.NavMenuItem#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.NavMenuItem.Attrs`](M3e.Component.NavMenuItem#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.NavMenuItem.Content`](M3e.Component.NavMenuItem#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.NavMenuItem.BadgeSlot`](M3e.Component.NavMenuItem#BadgeSlot).
-}
type alias BadgeSlot =
    Orig.BadgeSlot


{-| See [`M3e.Component.NavMenuItem.IconSlot`](M3e.Component.NavMenuItem#IconSlot).
-}
type alias IconSlot =
    Orig.IconSlot


{-| See [`M3e.Component.NavMenuItem.LabelSlot`](M3e.Component.NavMenuItem#LabelSlot).
-}
type alias LabelSlot =
    Orig.LabelSlot


{-| See [`M3e.Component.NavMenuItem.SelectedIconSlot`](M3e.Component.NavMenuItem#SelectedIconSlot).
-}
type alias SelectedIconSlot =
    Orig.SelectedIconSlot


{-| See [`M3e.Component.NavMenuItem.ToggleIconSlot`](M3e.Component.NavMenuItem#ToggleIconSlot).
-}
type alias ToggleIconSlot =
    Orig.ToggleIconSlot


{-| See [`M3e.Component.NavMenuItem.ChildAdmittedBy`](M3e.Component.NavMenuItem#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.NavMenuItem.disabled`](M3e.Component.NavMenuItem#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.NavMenuItem.open`](M3e.Component.NavMenuItem#open).
-}
open : Bool -> Attr { c | open : Supported } msg
open =
    Orig.open


{-| See [`M3e.Component.NavMenuItem.selected`](M3e.Component.NavMenuItem#selected).
-}
selected : Bool -> Attr { c | selected : Supported } msg
selected =
    Orig.selected


{-| See [`M3e.Component.NavMenuItem.defaultSelected`](M3e.Component.NavMenuItem#defaultSelected).
-}
defaultSelected : Bool -> Attr { c | selected : Supported } msg
defaultSelected =
    Orig.defaultSelected


{-| See [`M3e.Component.NavMenuItem.onOpening`](M3e.Component.NavMenuItem#onOpening).
-}
onOpening : msg -> Attr { c | onOpening : Supported } msg
onOpening =
    Orig.onOpening


{-| See [`M3e.Component.NavMenuItem.onOpened`](M3e.Component.NavMenuItem#onOpened).
-}
onOpened : msg -> Attr { c | onOpened : Supported } msg
onOpened =
    Orig.onOpened


{-| See [`M3e.Component.NavMenuItem.onClosing`](M3e.Component.NavMenuItem#onClosing).
-}
onClosing : msg -> Attr { c | onClosing : Supported } msg
onClosing =
    Orig.onClosing


{-| See [`M3e.Component.NavMenuItem.onClosed`](M3e.Component.NavMenuItem#onClosed).
-}
onClosed : msg -> Attr { c | onClosed : Supported } msg
onClosed =
    Orig.onClosed


{-| See [`M3e.Component.NavMenuItem.onClick`](M3e.Component.NavMenuItem#onClick).
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Orig.onClick


{-| See [`M3e.Component.NavMenuItem.badge`](M3e.Component.NavMenuItem#badge).
-}
badge : Element BadgeSlot admittedBy msg -> Element free freeAdmittedBy msg
badge =
    Orig.badge


{-| See [`M3e.Component.NavMenuItem.icon`](M3e.Component.NavMenuItem#icon).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon =
    Orig.icon


{-| See [`M3e.Component.NavMenuItem.label`](M3e.Component.NavMenuItem#label).
-}
label : Element LabelSlot admittedBy msg -> Element free freeAdmittedBy msg
label =
    Orig.label


{-| See [`M3e.Component.NavMenuItem.selectedIcon`](M3e.Component.NavMenuItem#selectedIcon).
-}
selectedIcon : Element SelectedIconSlot admittedBy msg -> Element free freeAdmittedBy msg
selectedIcon =
    Orig.selectedIcon


{-| See [`M3e.Component.NavMenuItem.toggleIcon`](M3e.Component.NavMenuItem#toggleIcon).
-}
toggleIcon : Element ToggleIconSlot admittedBy msg -> Element free freeAdmittedBy msg
toggleIcon =
    Orig.toggleIcon


{-| See [`M3e.Component.NavMenuItem.child`](M3e.Component.NavMenuItem#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
