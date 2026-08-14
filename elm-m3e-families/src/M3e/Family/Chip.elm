module M3e.Family.Chip exposing (el, Is, Attrs, Content, IconSlot, TrailingIconSlot, ChildAdmittedBy, Variant, variant, value, defaultValue, icon, trailingIcon, child)

{-| The **Chip** family root — re-export of `M3e.Component.Chip`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.Chip`](M3e.Component.Chip) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, IconSlot, TrailingIconSlot, ChildAdmittedBy, Variant, variant, value, defaultValue, icon, trailingIcon, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.Chip as Orig


{-| See [`M3e.Component.Chip.el`](M3e.Component.Chip#el).
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.Chip.Is`](M3e.Component.Chip#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.Chip.Attrs`](M3e.Component.Chip#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.Chip.Content`](M3e.Component.Chip#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.Chip.IconSlot`](M3e.Component.Chip#IconSlot).
-}
type alias IconSlot =
    Orig.IconSlot


{-| See [`M3e.Component.Chip.TrailingIconSlot`](M3e.Component.Chip#TrailingIconSlot).
-}
type alias TrailingIconSlot =
    Orig.TrailingIconSlot


{-| See [`M3e.Component.Chip.ChildAdmittedBy`](M3e.Component.Chip#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.Chip.Variant`](M3e.Component.Chip#Variant).
-}
type alias Variant =
    Orig.Variant


{-| See [`M3e.Component.Chip.variant`](M3e.Component.Chip#variant).
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant =
    Orig.variant


{-| See [`M3e.Component.Chip.value`](M3e.Component.Chip#value).
-}
value : String -> Attr { c | value : Supported } msg
value =
    Orig.value


{-| See [`M3e.Component.Chip.defaultValue`](M3e.Component.Chip#defaultValue).
-}
defaultValue : String -> Attr { c | value : Supported } msg
defaultValue =
    Orig.defaultValue


{-| See [`M3e.Component.Chip.icon`](M3e.Component.Chip#icon).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon =
    Orig.icon


{-| See [`M3e.Component.Chip.trailingIcon`](M3e.Component.Chip#trailingIcon).
-}
trailingIcon : Element TrailingIconSlot admittedBy msg -> Element free freeAdmittedBy msg
trailingIcon =
    Orig.trailingIcon


{-| See [`M3e.Component.Chip.child`](M3e.Component.Chip#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
