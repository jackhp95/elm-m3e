module M3e.Family.SegmentedButton.Segment exposing (el, Is, Attrs, Content, IconSlot, ChildAdmittedBy, checked, disabled, value, defaultChecked, defaultValue, onBeforeinput, onInput, onChange, onClick, icon, child)

{-| `ButtonSegment`, grouped under the **SegmentedButton** family as `Segment`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.ButtonSegment`](M3e.Component.ButtonSegment) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, IconSlot, ChildAdmittedBy, checked, disabled, value, defaultChecked, defaultValue, onBeforeinput, onInput, onChange, onClick, icon, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.ButtonSegment as Orig


{-| See [`M3e.Component.ButtonSegment.el`](M3e.Component.ButtonSegment#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.ButtonSegment.Is`](M3e.Component.ButtonSegment#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.ButtonSegment.Attrs`](M3e.Component.ButtonSegment#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.ButtonSegment.Content`](M3e.Component.ButtonSegment#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.ButtonSegment.IconSlot`](M3e.Component.ButtonSegment#IconSlot).
-}
type alias IconSlot =
    Orig.IconSlot


{-| See [`M3e.Component.ButtonSegment.ChildAdmittedBy`](M3e.Component.ButtonSegment#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.ButtonSegment.checked`](M3e.Component.ButtonSegment#checked).
-}
checked : Bool -> Attr { c | checked : Supported } msg
checked =
    Orig.checked


{-| See [`M3e.Component.ButtonSegment.disabled`](M3e.Component.ButtonSegment#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.ButtonSegment.value`](M3e.Component.ButtonSegment#value).
-}
value : String -> Attr { c | value : Supported } msg
value =
    Orig.value


{-| See [`M3e.Component.ButtonSegment.defaultChecked`](M3e.Component.ButtonSegment#defaultChecked).
-}
defaultChecked : Bool -> Attr { c | checked : Supported } msg
defaultChecked =
    Orig.defaultChecked


{-| See [`M3e.Component.ButtonSegment.defaultValue`](M3e.Component.ButtonSegment#defaultValue).
-}
defaultValue : String -> Attr { c | value : Supported } msg
defaultValue =
    Orig.defaultValue


{-| See [`M3e.Component.ButtonSegment.onBeforeinput`](M3e.Component.ButtonSegment#onBeforeinput).
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput =
    Orig.onBeforeinput


{-| See [`M3e.Component.ButtonSegment.onInput`](M3e.Component.ButtonSegment#onInput).
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    Orig.onInput


{-| See [`M3e.Component.ButtonSegment.onChange`](M3e.Component.ButtonSegment#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.ButtonSegment.onClick`](M3e.Component.ButtonSegment#onClick).
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Orig.onClick


{-| See [`M3e.Component.ButtonSegment.icon`](M3e.Component.ButtonSegment#icon).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon =
    Orig.icon


{-| See [`M3e.Component.ButtonSegment.child`](M3e.Component.ButtonSegment#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
