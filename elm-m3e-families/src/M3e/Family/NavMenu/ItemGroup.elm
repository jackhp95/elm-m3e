module M3e.Family.NavMenu.ItemGroup exposing (el, Is, Attrs, Content, LabelSlot, ChildAdmittedBy, label, child)

{-| `NavMenuItemGroup`, grouped under the **NavMenu** family as `ItemGroup`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.NavMenuItemGroup`](M3e.Component.NavMenuItemGroup) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, LabelSlot, ChildAdmittedBy, label, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import M3e.Component.NavMenuItemGroup as Orig


{-| See [`M3e.Component.NavMenuItemGroup.el`](M3e.Component.NavMenuItemGroup#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.NavMenuItemGroup.Is`](M3e.Component.NavMenuItemGroup#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.NavMenuItemGroup.Attrs`](M3e.Component.NavMenuItemGroup#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.NavMenuItemGroup.Content`](M3e.Component.NavMenuItemGroup#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.NavMenuItemGroup.LabelSlot`](M3e.Component.NavMenuItemGroup#LabelSlot).
-}
type alias LabelSlot =
    Orig.LabelSlot


{-| See [`M3e.Component.NavMenuItemGroup.ChildAdmittedBy`](M3e.Component.NavMenuItemGroup#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.NavMenuItemGroup.label`](M3e.Component.NavMenuItemGroup#label).
-}
label : Element LabelSlot admittedBy msg -> Element free freeAdmittedBy msg
label =
    Orig.label


{-| See [`M3e.Component.NavMenuItemGroup.child`](M3e.Component.NavMenuItemGroup#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
