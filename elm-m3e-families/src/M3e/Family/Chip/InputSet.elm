module M3e.Family.Chip.InputSet exposing (el, Is, Attrs, Content, ChildAdmittedBy, disabled, name, required, validationmessages, vertical, onChange, input, child)

{-| `InputChipSet`, grouped under the **Chip** family as `InputSet`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.InputChipSet`](M3e.Component.InputChipSet) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, ChildAdmittedBy, disabled, name, required, validationmessages, vertical, onChange, input, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.InputChipSet as Orig


{-| See [`M3e.Component.InputChipSet.el`](M3e.Component.InputChipSet#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.InputChipSet.Is`](M3e.Component.InputChipSet#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.InputChipSet.Attrs`](M3e.Component.InputChipSet#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.InputChipSet.Content`](M3e.Component.InputChipSet#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.InputChipSet.ChildAdmittedBy`](M3e.Component.InputChipSet#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.InputChipSet.disabled`](M3e.Component.InputChipSet#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.InputChipSet.name`](M3e.Component.InputChipSet#name).
-}
name : String -> Attr { c | name : Supported } msg
name =
    Orig.name


{-| See [`M3e.Component.InputChipSet.required`](M3e.Component.InputChipSet#required).
-}
required : Bool -> Attr { c | required : Supported } msg
required =
    Orig.required


{-| See [`M3e.Component.InputChipSet.validationmessages`](M3e.Component.InputChipSet#validationmessages).
-}
validationmessages : String -> Attr { c | validationmessages : Supported } msg
validationmessages =
    Orig.validationmessages


{-| See [`M3e.Component.InputChipSet.vertical`](M3e.Component.InputChipSet#vertical).
-}
vertical : Bool -> Attr { c | vertical : Supported } msg
vertical =
    Orig.vertical


{-| See [`M3e.Component.InputChipSet.onChange`](M3e.Component.InputChipSet#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.InputChipSet.input`](M3e.Component.InputChipSet#input).
-}
input : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
input =
    Orig.input


{-| See [`M3e.Component.InputChipSet.child`](M3e.Component.InputChipSet#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
