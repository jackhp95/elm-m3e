module M3e.Family.Chip.Assist exposing (el, Is, Attrs, Content, IconSlot, ChildAdmittedBy, ActionCaps, Type, type_, Variant, variant, disabled, disabledInteractive, download, href, name, rel, target, value, defaultValue, onClick, icon, child)

{-| `AssistChip`, grouped under the **Chip** family as `Assist`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.AssistChip`](M3e.Component.AssistChip) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, IconSlot, ChildAdmittedBy, ActionCaps, Type, type_, Variant, variant, disabled, disabledInteractive, download, href, name, rel, target, value, defaultValue, onClick, icon, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Action as Ac
import M3e.Component.AssistChip as Orig


{-| See [`M3e.Component.AssistChip.el`](M3e.Component.AssistChip#el).
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg
    , action : Ac.Action ActionCaps msg
    }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.AssistChip.Is`](M3e.Component.AssistChip#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.AssistChip.Attrs`](M3e.Component.AssistChip#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.AssistChip.Content`](M3e.Component.AssistChip#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.AssistChip.IconSlot`](M3e.Component.AssistChip#IconSlot).
-}
type alias IconSlot =
    Orig.IconSlot


{-| See [`M3e.Component.AssistChip.ChildAdmittedBy`](M3e.Component.AssistChip#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.AssistChip.ActionCaps`](M3e.Component.AssistChip#ActionCaps).
-}
type alias ActionCaps =
    Orig.ActionCaps


{-| See [`M3e.Component.AssistChip.Type`](M3e.Component.AssistChip#Type).
-}
type alias Type =
    Orig.Type


{-| See [`M3e.Component.AssistChip.type_`](M3e.Component.AssistChip#type_).
-}
type_ : Value Type -> Attr { c | type_ : Supported } msg
type_ =
    Orig.type_


{-| See [`M3e.Component.AssistChip.Variant`](M3e.Component.AssistChip#Variant).
-}
type alias Variant =
    Orig.Variant


{-| See [`M3e.Component.AssistChip.variant`](M3e.Component.AssistChip#variant).
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant =
    Orig.variant


{-| See [`M3e.Component.AssistChip.disabled`](M3e.Component.AssistChip#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.AssistChip.disabledInteractive`](M3e.Component.AssistChip#disabledInteractive).
-}
disabledInteractive : Bool -> Attr { c | disabledInteractive : Supported } msg
disabledInteractive =
    Orig.disabledInteractive


{-| See [`M3e.Component.AssistChip.download`](M3e.Component.AssistChip#download).
-}
download : String -> Attr { c | download : Supported } msg
download =
    Orig.download


{-| See [`M3e.Component.AssistChip.href`](M3e.Component.AssistChip#href).
-}
href : String -> Attr { c | href : Supported } msg
href =
    Orig.href


{-| See [`M3e.Component.AssistChip.name`](M3e.Component.AssistChip#name).
-}
name : String -> Attr { c | name : Supported } msg
name =
    Orig.name


{-| See [`M3e.Component.AssistChip.rel`](M3e.Component.AssistChip#rel).
-}
rel : String -> Attr { c | rel : Supported } msg
rel =
    Orig.rel


{-| See [`M3e.Component.AssistChip.target`](M3e.Component.AssistChip#target).
-}
target : String -> Attr { c | target : Supported } msg
target =
    Orig.target


{-| See [`M3e.Component.AssistChip.value`](M3e.Component.AssistChip#value).
-}
value : String -> Attr { c | value : Supported } msg
value =
    Orig.value


{-| See [`M3e.Component.AssistChip.defaultValue`](M3e.Component.AssistChip#defaultValue).
-}
defaultValue : String -> Attr { c | value : Supported } msg
defaultValue =
    Orig.defaultValue


{-| See [`M3e.Component.AssistChip.onClick`](M3e.Component.AssistChip#onClick).
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Orig.onClick


{-| See [`M3e.Component.AssistChip.icon`](M3e.Component.AssistChip#icon).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon =
    Orig.icon


{-| See [`M3e.Component.AssistChip.child`](M3e.Component.AssistChip#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
