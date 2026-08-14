module M3e.Family.Chip.Input exposing (el, Is, Attrs, Content, AvatarSlot, IconSlot, RemoveIconSlot, ChildAdmittedBy, Variant, variant, disabled, disabledInteractive, removable, removeLabel, value, defaultValue, onRemove, onClick, avatar, icon, removeIcon, child)

{-| `InputChip`, grouped under the **Chip** family as `Input`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.InputChip`](M3e.Component.InputChip) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, AvatarSlot, IconSlot, RemoveIconSlot, ChildAdmittedBy, Variant, variant, disabled, disabledInteractive, removable, removeLabel, value, defaultValue, onRemove, onClick, avatar, icon, removeIcon, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.InputChip as Orig


{-| See [`M3e.Component.InputChip.el`](M3e.Component.InputChip#el).
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.InputChip.Is`](M3e.Component.InputChip#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.InputChip.Attrs`](M3e.Component.InputChip#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.InputChip.Content`](M3e.Component.InputChip#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.InputChip.AvatarSlot`](M3e.Component.InputChip#AvatarSlot).
-}
type alias AvatarSlot =
    Orig.AvatarSlot


{-| See [`M3e.Component.InputChip.IconSlot`](M3e.Component.InputChip#IconSlot).
-}
type alias IconSlot =
    Orig.IconSlot


{-| See [`M3e.Component.InputChip.RemoveIconSlot`](M3e.Component.InputChip#RemoveIconSlot).
-}
type alias RemoveIconSlot =
    Orig.RemoveIconSlot


{-| See [`M3e.Component.InputChip.ChildAdmittedBy`](M3e.Component.InputChip#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.InputChip.Variant`](M3e.Component.InputChip#Variant).
-}
type alias Variant =
    Orig.Variant


{-| See [`M3e.Component.InputChip.variant`](M3e.Component.InputChip#variant).
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant =
    Orig.variant


{-| See [`M3e.Component.InputChip.disabled`](M3e.Component.InputChip#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.InputChip.disabledInteractive`](M3e.Component.InputChip#disabledInteractive).
-}
disabledInteractive : Bool -> Attr { c | disabledInteractive : Supported } msg
disabledInteractive =
    Orig.disabledInteractive


{-| See [`M3e.Component.InputChip.removable`](M3e.Component.InputChip#removable).
-}
removable : Bool -> Attr { c | removable : Supported } msg
removable =
    Orig.removable


{-| See [`M3e.Component.InputChip.removeLabel`](M3e.Component.InputChip#removeLabel).
-}
removeLabel : String -> Attr { c | removeLabel : Supported } msg
removeLabel =
    Orig.removeLabel


{-| See [`M3e.Component.InputChip.value`](M3e.Component.InputChip#value).
-}
value : String -> Attr { c | value : Supported } msg
value =
    Orig.value


{-| See [`M3e.Component.InputChip.defaultValue`](M3e.Component.InputChip#defaultValue).
-}
defaultValue : String -> Attr { c | value : Supported } msg
defaultValue =
    Orig.defaultValue


{-| See [`M3e.Component.InputChip.onRemove`](M3e.Component.InputChip#onRemove).
-}
onRemove : msg -> Attr { c | onRemove : Supported } msg
onRemove =
    Orig.onRemove


{-| See [`M3e.Component.InputChip.onClick`](M3e.Component.InputChip#onClick).
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Orig.onClick


{-| See [`M3e.Component.InputChip.avatar`](M3e.Component.InputChip#avatar).
-}
avatar : Element AvatarSlot admittedBy msg -> Element free freeAdmittedBy msg
avatar =
    Orig.avatar


{-| See [`M3e.Component.InputChip.icon`](M3e.Component.InputChip#icon).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon =
    Orig.icon


{-| See [`M3e.Component.InputChip.removeIcon`](M3e.Component.InputChip#removeIcon).
-}
removeIcon : Element RemoveIconSlot admittedBy msg -> Element free freeAdmittedBy msg
removeIcon =
    Orig.removeIcon


{-| See [`M3e.Component.InputChip.child`](M3e.Component.InputChip#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
