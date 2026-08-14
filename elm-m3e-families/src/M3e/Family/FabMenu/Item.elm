module M3e.Family.FabMenu.Item exposing (el, Is, Attrs, IconSlot, ChildAdmittedBy, disabled, download, href, rel, target, onClick, icon, child)

{-| `FabMenuItem`, grouped under the **FabMenu** family as `Item`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.FabMenuItem`](M3e.Component.FabMenuItem) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, IconSlot, ChildAdmittedBy, disabled, download, href, rel, target, onClick, icon, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.FabMenuItem as Orig


{-| See [`M3e.Component.FabMenuItem.el`](M3e.Component.FabMenuItem#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.FabMenuItem.Is`](M3e.Component.FabMenuItem#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.FabMenuItem.Attrs`](M3e.Component.FabMenuItem#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.FabMenuItem.IconSlot`](M3e.Component.FabMenuItem#IconSlot).
-}
type alias IconSlot =
    Orig.IconSlot


{-| See [`M3e.Component.FabMenuItem.ChildAdmittedBy`](M3e.Component.FabMenuItem#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.FabMenuItem.disabled`](M3e.Component.FabMenuItem#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.FabMenuItem.download`](M3e.Component.FabMenuItem#download).
-}
download : String -> Attr { c | download : Supported } msg
download =
    Orig.download


{-| See [`M3e.Component.FabMenuItem.href`](M3e.Component.FabMenuItem#href).
-}
href : String -> Attr { c | href : Supported } msg
href =
    Orig.href


{-| See [`M3e.Component.FabMenuItem.rel`](M3e.Component.FabMenuItem#rel).
-}
rel : String -> Attr { c | rel : Supported } msg
rel =
    Orig.rel


{-| See [`M3e.Component.FabMenuItem.target`](M3e.Component.FabMenuItem#target).
-}
target : String -> Attr { c | target : Supported } msg
target =
    Orig.target


{-| See [`M3e.Component.FabMenuItem.onClick`](M3e.Component.FabMenuItem#onClick).
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Orig.onClick


{-| See [`M3e.Component.FabMenuItem.icon`](M3e.Component.FabMenuItem#icon).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon =
    Orig.icon


{-| See [`M3e.Component.FabMenuItem.child`](M3e.Component.FabMenuItem#child).
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
