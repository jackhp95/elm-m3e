module M3e.Family.FabMenu.Trigger exposing (el, Is, Attrs, ChildAdmittedBy)

{-| `FabMenuTrigger`, grouped under the **FabMenu** family as `Trigger`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.FabMenuTrigger`](M3e.Component.FabMenuTrigger) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import M3e.Component.FabMenuTrigger as Orig


{-| See [`M3e.Component.FabMenuTrigger.el`](M3e.Component.FabMenuTrigger#el).
-}
el :
    { for : String }
    -> List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.FabMenuTrigger.Is`](M3e.Component.FabMenuTrigger#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.FabMenuTrigger.Attrs`](M3e.Component.FabMenuTrigger#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.FabMenuTrigger.ChildAdmittedBy`](M3e.Component.FabMenuTrigger#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm
