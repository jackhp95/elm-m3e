module M3e.Family.Accordion.Panel exposing (el, Is, Attrs, ToggleIconSlot, ChildAdmittedBy, ToggleDirection, toggleDirection, TogglePosition, togglePosition, disabled, hideToggle, open, onOpening, onOpened, onClosing, onClosed, actions, header, toggleIcon, child)

{-| `ExpansionPanel`, grouped under the **Accordion** family as `Panel`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.ExpansionPanel`](M3e.Component.ExpansionPanel) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ToggleIconSlot, ChildAdmittedBy, ToggleDirection, toggleDirection, TogglePosition, togglePosition, disabled, hideToggle, open, onOpening, onOpened, onClosing, onClosed, actions, header, toggleIcon, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.ExpansionPanel as Orig


{-| See [`M3e.Component.ExpansionPanel.el`](M3e.Component.ExpansionPanel#el).
-}
el :
    { header : Element childAccepts (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.ExpansionPanel.Is`](M3e.Component.ExpansionPanel#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.ExpansionPanel.Attrs`](M3e.Component.ExpansionPanel#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.ExpansionPanel.ToggleIconSlot`](M3e.Component.ExpansionPanel#ToggleIconSlot).
-}
type alias ToggleIconSlot =
    Orig.ToggleIconSlot


{-| See [`M3e.Component.ExpansionPanel.ChildAdmittedBy`](M3e.Component.ExpansionPanel#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.ExpansionPanel.ToggleDirection`](M3e.Component.ExpansionPanel#ToggleDirection).
-}
type alias ToggleDirection =
    Orig.ToggleDirection


{-| See [`M3e.Component.ExpansionPanel.toggleDirection`](M3e.Component.ExpansionPanel#toggleDirection).
-}
toggleDirection : Value ToggleDirection -> Attr { c | toggleDirection : Supported } msg
toggleDirection =
    Orig.toggleDirection


{-| See [`M3e.Component.ExpansionPanel.TogglePosition`](M3e.Component.ExpansionPanel#TogglePosition).
-}
type alias TogglePosition =
    Orig.TogglePosition


{-| See [`M3e.Component.ExpansionPanel.togglePosition`](M3e.Component.ExpansionPanel#togglePosition).
-}
togglePosition : Value TogglePosition -> Attr { c | togglePosition : Supported } msg
togglePosition =
    Orig.togglePosition


{-| See [`M3e.Component.ExpansionPanel.disabled`](M3e.Component.ExpansionPanel#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.ExpansionPanel.hideToggle`](M3e.Component.ExpansionPanel#hideToggle).
-}
hideToggle : Bool -> Attr { c | hideToggle : Supported } msg
hideToggle =
    Orig.hideToggle


{-| See [`M3e.Component.ExpansionPanel.open`](M3e.Component.ExpansionPanel#open).
-}
open : Bool -> Attr { c | open : Supported } msg
open =
    Orig.open


{-| See [`M3e.Component.ExpansionPanel.onOpening`](M3e.Component.ExpansionPanel#onOpening).
-}
onOpening : msg -> Attr { c | onOpening : Supported } msg
onOpening =
    Orig.onOpening


{-| See [`M3e.Component.ExpansionPanel.onOpened`](M3e.Component.ExpansionPanel#onOpened).
-}
onOpened : msg -> Attr { c | onOpened : Supported } msg
onOpened =
    Orig.onOpened


{-| See [`M3e.Component.ExpansionPanel.onClosing`](M3e.Component.ExpansionPanel#onClosing).
-}
onClosing : msg -> Attr { c | onClosing : Supported } msg
onClosing =
    Orig.onClosing


{-| See [`M3e.Component.ExpansionPanel.onClosed`](M3e.Component.ExpansionPanel#onClosed).
-}
onClosed : msg -> Attr { c | onClosed : Supported } msg
onClosed =
    Orig.onClosed


{-| See [`M3e.Component.ExpansionPanel.actions`](M3e.Component.ExpansionPanel#actions).
-}
actions : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
actions =
    Orig.actions


{-| See [`M3e.Component.ExpansionPanel.header`](M3e.Component.ExpansionPanel#header).
-}
header : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
header =
    Orig.header


{-| See [`M3e.Component.ExpansionPanel.toggleIcon`](M3e.Component.ExpansionPanel#toggleIcon).
-}
toggleIcon : Element ToggleIconSlot admittedBy msg -> Element free freeAdmittedBy msg
toggleIcon =
    Orig.toggleIcon


{-| See [`M3e.Component.ExpansionPanel.child`](M3e.Component.ExpansionPanel#child).
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
