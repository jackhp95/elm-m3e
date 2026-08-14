module M3e.Family.Menu.ItemGroup exposing (el, Is, Attrs, Content, ChildAdmittedBy, child)

{-| `MenuItemGroup`, grouped under the **Menu** family as `ItemGroup`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.MenuItemGroup`](M3e.Component.MenuItemGroup) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, ChildAdmittedBy, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import M3e.Component.MenuItemGroup as Orig


{-| See [`M3e.Component.MenuItemGroup.el`](M3e.Component.MenuItemGroup#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.MenuItemGroup.Is`](M3e.Component.MenuItemGroup#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.MenuItemGroup.Attrs`](M3e.Component.MenuItemGroup#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.MenuItemGroup.Content`](M3e.Component.MenuItemGroup#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.MenuItemGroup.ChildAdmittedBy`](M3e.Component.MenuItemGroup#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.MenuItemGroup.child`](M3e.Component.MenuItemGroup#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
