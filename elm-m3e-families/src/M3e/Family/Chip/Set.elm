module M3e.Family.Chip.Set exposing (el, Is, Attrs, Content, ChildAdmittedBy, vertical, child)

{-| `ChipSet`, grouped under the **Chip** family as `Set`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.ChipSet`](M3e.Component.ChipSet) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, ChildAdmittedBy, vertical, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.ChipSet as Orig


{-| See [`M3e.Component.ChipSet.el`](M3e.Component.ChipSet#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.ChipSet.Is`](M3e.Component.ChipSet#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.ChipSet.Attrs`](M3e.Component.ChipSet#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.ChipSet.Content`](M3e.Component.ChipSet#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.ChipSet.ChildAdmittedBy`](M3e.Component.ChipSet#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.ChipSet.vertical`](M3e.Component.ChipSet#vertical).
-}
vertical : Bool -> Attr { c | vertical : Supported } msg
vertical =
    Orig.vertical


{-| See [`M3e.Component.ChipSet.child`](M3e.Component.ChipSet#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
