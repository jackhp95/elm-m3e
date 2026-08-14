module M3e.Family.RichTooltip exposing (el, Is, Attrs, Content, SubheadSlot, ChildAdmittedBy, Position, position, TouchGestures, touchGestures, disabled, for, hideDelay, showDelay, onBeforetoggle, onToggle, actions, subhead, child)

{-| The **RichTooltip** family root — re-export of `M3e.Component.RichTooltip`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.RichTooltip`](M3e.Component.RichTooltip) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, SubheadSlot, ChildAdmittedBy, Position, position, TouchGestures, touchGestures, disabled, for, hideDelay, showDelay, onBeforetoggle, onToggle, actions, subhead, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.RichTooltip as Orig


{-| See [`M3e.Component.RichTooltip.el`](M3e.Component.RichTooltip#el).
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.RichTooltip.Is`](M3e.Component.RichTooltip#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.RichTooltip.Attrs`](M3e.Component.RichTooltip#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.RichTooltip.Content`](M3e.Component.RichTooltip#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.RichTooltip.SubheadSlot`](M3e.Component.RichTooltip#SubheadSlot).
-}
type alias SubheadSlot =
    Orig.SubheadSlot


{-| See [`M3e.Component.RichTooltip.ChildAdmittedBy`](M3e.Component.RichTooltip#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.RichTooltip.Position`](M3e.Component.RichTooltip#Position).
-}
type alias Position =
    Orig.Position


{-| See [`M3e.Component.RichTooltip.position`](M3e.Component.RichTooltip#position).
-}
position : Value Position -> Attr { c | position : Supported } msg
position =
    Orig.position


{-| See [`M3e.Component.RichTooltip.TouchGestures`](M3e.Component.RichTooltip#TouchGestures).
-}
type alias TouchGestures =
    Orig.TouchGestures


{-| See [`M3e.Component.RichTooltip.touchGestures`](M3e.Component.RichTooltip#touchGestures).
-}
touchGestures : Value TouchGestures -> Attr { c | touchGestures : Supported } msg
touchGestures =
    Orig.touchGestures


{-| See [`M3e.Component.RichTooltip.disabled`](M3e.Component.RichTooltip#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.RichTooltip.for`](M3e.Component.RichTooltip#for).
-}
for : String -> Attr { c | for : Supported } msg
for =
    Orig.for


{-| See [`M3e.Component.RichTooltip.hideDelay`](M3e.Component.RichTooltip#hideDelay).
-}
hideDelay : Float -> Attr { c | hideDelay : Supported } msg
hideDelay =
    Orig.hideDelay


{-| See [`M3e.Component.RichTooltip.showDelay`](M3e.Component.RichTooltip#showDelay).
-}
showDelay : Float -> Attr { c | showDelay : Supported } msg
showDelay =
    Orig.showDelay


{-| See [`M3e.Component.RichTooltip.onBeforetoggle`](M3e.Component.RichTooltip#onBeforetoggle).
-}
onBeforetoggle : msg -> Attr { c | onBeforetoggle : Supported } msg
onBeforetoggle =
    Orig.onBeforetoggle


{-| See [`M3e.Component.RichTooltip.onToggle`](M3e.Component.RichTooltip#onToggle).
-}
onToggle : msg -> Attr { c | onToggle : Supported } msg
onToggle =
    Orig.onToggle


{-| See [`M3e.Component.RichTooltip.actions`](M3e.Component.RichTooltip#actions).
-}
actions : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
actions =
    Orig.actions


{-| See [`M3e.Component.RichTooltip.subhead`](M3e.Component.RichTooltip#subhead).
-}
subhead : Element SubheadSlot admittedBy msg -> Element free freeAdmittedBy msg
subhead =
    Orig.subhead


{-| See [`M3e.Component.RichTooltip.child`](M3e.Component.RichTooltip#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
