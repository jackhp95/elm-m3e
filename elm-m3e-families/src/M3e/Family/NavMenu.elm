module M3e.Family.NavMenu exposing (el, Is, Attrs, Content, ChildAdmittedBy, child)

{-| The **NavMenu** family root — re-export of `M3e.Component.NavMenu`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.NavMenu`](M3e.Component.NavMenu) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, ChildAdmittedBy, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import M3e.Component.NavMenu as Orig


{-| See [`M3e.Component.NavMenu.el`](M3e.Component.NavMenu#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.NavMenu.Is`](M3e.Component.NavMenu#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.NavMenu.Attrs`](M3e.Component.NavMenu#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.NavMenu.Content`](M3e.Component.NavMenu#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.NavMenu.ChildAdmittedBy`](M3e.Component.NavMenu#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.NavMenu.child`](M3e.Component.NavMenu#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
