module M3e.Family.Chip.Filter exposing (el, Is, Attrs, Content, IconSlot, TrailingIconSlot, ChildAdmittedBy, Variant, variant, disabled, disabledInteractive, selected, value, defaultSelected, defaultValue, onBeforeinput, onInput, onChange, onClick, icon, trailingIcon, child)

{-| `FilterChip`, grouped under the **Chip** family as `Filter`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.FilterChip`](M3e.Component.FilterChip) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, IconSlot, TrailingIconSlot, ChildAdmittedBy, Variant, variant, disabled, disabledInteractive, selected, value, defaultSelected, defaultValue, onBeforeinput, onInput, onChange, onClick, icon, trailingIcon, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.FilterChip as Orig


{-| See [`M3e.Component.FilterChip.el`](M3e.Component.FilterChip#el).
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.FilterChip.Is`](M3e.Component.FilterChip#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.FilterChip.Attrs`](M3e.Component.FilterChip#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.FilterChip.Content`](M3e.Component.FilterChip#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.FilterChip.IconSlot`](M3e.Component.FilterChip#IconSlot).
-}
type alias IconSlot =
    Orig.IconSlot


{-| See [`M3e.Component.FilterChip.TrailingIconSlot`](M3e.Component.FilterChip#TrailingIconSlot).
-}
type alias TrailingIconSlot =
    Orig.TrailingIconSlot


{-| See [`M3e.Component.FilterChip.ChildAdmittedBy`](M3e.Component.FilterChip#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.FilterChip.Variant`](M3e.Component.FilterChip#Variant).
-}
type alias Variant =
    Orig.Variant


{-| See [`M3e.Component.FilterChip.variant`](M3e.Component.FilterChip#variant).
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant =
    Orig.variant


{-| See [`M3e.Component.FilterChip.disabled`](M3e.Component.FilterChip#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.FilterChip.disabledInteractive`](M3e.Component.FilterChip#disabledInteractive).
-}
disabledInteractive : Bool -> Attr { c | disabledInteractive : Supported } msg
disabledInteractive =
    Orig.disabledInteractive


{-| See [`M3e.Component.FilterChip.selected`](M3e.Component.FilterChip#selected).
-}
selected : Bool -> Attr { c | selected : Supported } msg
selected =
    Orig.selected


{-| See [`M3e.Component.FilterChip.value`](M3e.Component.FilterChip#value).
-}
value : String -> Attr { c | value : Supported } msg
value =
    Orig.value


{-| See [`M3e.Component.FilterChip.defaultSelected`](M3e.Component.FilterChip#defaultSelected).
-}
defaultSelected : Bool -> Attr { c | selected : Supported } msg
defaultSelected =
    Orig.defaultSelected


{-| See [`M3e.Component.FilterChip.defaultValue`](M3e.Component.FilterChip#defaultValue).
-}
defaultValue : String -> Attr { c | value : Supported } msg
defaultValue =
    Orig.defaultValue


{-| See [`M3e.Component.FilterChip.onBeforeinput`](M3e.Component.FilterChip#onBeforeinput).
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput =
    Orig.onBeforeinput


{-| See [`M3e.Component.FilterChip.onInput`](M3e.Component.FilterChip#onInput).
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    Orig.onInput


{-| See [`M3e.Component.FilterChip.onChange`](M3e.Component.FilterChip#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.FilterChip.onClick`](M3e.Component.FilterChip#onClick).
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Orig.onClick


{-| See [`M3e.Component.FilterChip.icon`](M3e.Component.FilterChip#icon).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon =
    Orig.icon


{-| See [`M3e.Component.FilterChip.trailingIcon`](M3e.Component.FilterChip#trailingIcon).
-}
trailingIcon : Element TrailingIconSlot admittedBy msg -> Element free freeAdmittedBy msg
trailingIcon =
    Orig.trailingIcon


{-| See [`M3e.Component.FilterChip.child`](M3e.Component.FilterChip#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
