module M3e.Family.Tabs.Tab exposing (el, Is, Attrs, Content, IconSlot, ChildAdmittedBy, disabled, for, selected, defaultSelected, onBeforeinput, onInput, onChange, onClick, icon, child)

{-| `Tab`, grouped under the **Tabs** family as `Tab`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.Tab`](M3e.Component.Tab) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, IconSlot, ChildAdmittedBy, disabled, for, selected, defaultSelected, onBeforeinput, onInput, onChange, onClick, icon, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.Tab as Orig


{-| See [`M3e.Component.Tab.el`](M3e.Component.Tab#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.Tab.Is`](M3e.Component.Tab#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.Tab.Attrs`](M3e.Component.Tab#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.Tab.Content`](M3e.Component.Tab#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.Tab.IconSlot`](M3e.Component.Tab#IconSlot).
-}
type alias IconSlot =
    Orig.IconSlot


{-| See [`M3e.Component.Tab.ChildAdmittedBy`](M3e.Component.Tab#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.Tab.disabled`](M3e.Component.Tab#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.Tab.for`](M3e.Component.Tab#for).
-}
for : String -> Attr { c | for : Supported } msg
for =
    Orig.for


{-| See [`M3e.Component.Tab.selected`](M3e.Component.Tab#selected).
-}
selected : Bool -> Attr { c | selected : Supported } msg
selected =
    Orig.selected


{-| See [`M3e.Component.Tab.defaultSelected`](M3e.Component.Tab#defaultSelected).
-}
defaultSelected : Bool -> Attr { c | selected : Supported } msg
defaultSelected =
    Orig.defaultSelected


{-| See [`M3e.Component.Tab.onBeforeinput`](M3e.Component.Tab#onBeforeinput).
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput =
    Orig.onBeforeinput


{-| See [`M3e.Component.Tab.onInput`](M3e.Component.Tab#onInput).
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    Orig.onInput


{-| See [`M3e.Component.Tab.onChange`](M3e.Component.Tab#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.Tab.onClick`](M3e.Component.Tab#onClick).
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Orig.onClick


{-| See [`M3e.Component.Tab.icon`](M3e.Component.Tab#icon).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon =
    Orig.icon


{-| See [`M3e.Component.Tab.child`](M3e.Component.Tab#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
