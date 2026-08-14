module M3e.Family.Menu.Trigger exposing (el, Is, Attrs, ChildAdmittedBy, child)

{-| `MenuTrigger`, grouped under the **Menu** family as `Trigger`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.MenuTrigger`](M3e.Component.MenuTrigger) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, ChildAdmittedBy, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import M3e.Component.MenuTrigger as Orig


{-| See [`M3e.Component.MenuTrigger.el`](M3e.Component.MenuTrigger#el).
-}
el :
    { for : String }
    -> List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.MenuTrigger.Is`](M3e.Component.MenuTrigger#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.MenuTrigger.Attrs`](M3e.Component.MenuTrigger#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.MenuTrigger.ChildAdmittedBy`](M3e.Component.MenuTrigger#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.MenuTrigger.child`](M3e.Component.MenuTrigger#child).
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
