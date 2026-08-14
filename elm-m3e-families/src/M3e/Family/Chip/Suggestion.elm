module M3e.Family.Chip.Suggestion exposing (el, Is, Attrs, Content, IconSlot, ChildAdmittedBy, ActionCaps, Type, type_, Variant, variant, disabled, disabledInteractive, download, href, name, rel, target, value, defaultValue, onClick, icon, child)

{-| `SuggestionChip`, grouped under the **Chip** family as `Suggestion`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.SuggestionChip`](M3e.Component.SuggestionChip) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, IconSlot, ChildAdmittedBy, ActionCaps, Type, type_, Variant, variant, disabled, disabledInteractive, download, href, name, rel, target, value, defaultValue, onClick, icon, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Action as Ac
import M3e.Component.SuggestionChip as Orig


{-| See [`M3e.Component.SuggestionChip.el`](M3e.Component.SuggestionChip#el).
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


{-| See [`M3e.Component.SuggestionChip.Is`](M3e.Component.SuggestionChip#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.SuggestionChip.Attrs`](M3e.Component.SuggestionChip#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.SuggestionChip.Content`](M3e.Component.SuggestionChip#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.SuggestionChip.IconSlot`](M3e.Component.SuggestionChip#IconSlot).
-}
type alias IconSlot =
    Orig.IconSlot


{-| See [`M3e.Component.SuggestionChip.ChildAdmittedBy`](M3e.Component.SuggestionChip#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.SuggestionChip.ActionCaps`](M3e.Component.SuggestionChip#ActionCaps).
-}
type alias ActionCaps =
    Orig.ActionCaps


{-| See [`M3e.Component.SuggestionChip.Type`](M3e.Component.SuggestionChip#Type).
-}
type alias Type =
    Orig.Type


{-| See [`M3e.Component.SuggestionChip.type_`](M3e.Component.SuggestionChip#type_).
-}
type_ : Value Type -> Attr { c | type_ : Supported } msg
type_ =
    Orig.type_


{-| See [`M3e.Component.SuggestionChip.Variant`](M3e.Component.SuggestionChip#Variant).
-}
type alias Variant =
    Orig.Variant


{-| See [`M3e.Component.SuggestionChip.variant`](M3e.Component.SuggestionChip#variant).
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant =
    Orig.variant


{-| See [`M3e.Component.SuggestionChip.disabled`](M3e.Component.SuggestionChip#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.SuggestionChip.disabledInteractive`](M3e.Component.SuggestionChip#disabledInteractive).
-}
disabledInteractive : Bool -> Attr { c | disabledInteractive : Supported } msg
disabledInteractive =
    Orig.disabledInteractive


{-| See [`M3e.Component.SuggestionChip.download`](M3e.Component.SuggestionChip#download).
-}
download : String -> Attr { c | download : Supported } msg
download =
    Orig.download


{-| See [`M3e.Component.SuggestionChip.href`](M3e.Component.SuggestionChip#href).
-}
href : String -> Attr { c | href : Supported } msg
href =
    Orig.href


{-| See [`M3e.Component.SuggestionChip.name`](M3e.Component.SuggestionChip#name).
-}
name : String -> Attr { c | name : Supported } msg
name =
    Orig.name


{-| See [`M3e.Component.SuggestionChip.rel`](M3e.Component.SuggestionChip#rel).
-}
rel : String -> Attr { c | rel : Supported } msg
rel =
    Orig.rel


{-| See [`M3e.Component.SuggestionChip.target`](M3e.Component.SuggestionChip#target).
-}
target : String -> Attr { c | target : Supported } msg
target =
    Orig.target


{-| See [`M3e.Component.SuggestionChip.value`](M3e.Component.SuggestionChip#value).
-}
value : String -> Attr { c | value : Supported } msg
value =
    Orig.value


{-| See [`M3e.Component.SuggestionChip.defaultValue`](M3e.Component.SuggestionChip#defaultValue).
-}
defaultValue : String -> Attr { c | value : Supported } msg
defaultValue =
    Orig.defaultValue


{-| See [`M3e.Component.SuggestionChip.onClick`](M3e.Component.SuggestionChip#onClick).
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Orig.onClick


{-| See [`M3e.Component.SuggestionChip.icon`](M3e.Component.SuggestionChip#icon).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon =
    Orig.icon


{-| See [`M3e.Component.SuggestionChip.child`](M3e.Component.SuggestionChip#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
