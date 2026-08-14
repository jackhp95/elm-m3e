module M3e.Family.Toc exposing (el, Is, Attrs, OverlineSlot, TitleSlot, ChildAdmittedBy, for, maxDepth, overline, title, child)

{-| The **Toc** family root — re-export of `M3e.Component.Toc`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.Toc`](M3e.Component.Toc) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, OverlineSlot, TitleSlot, ChildAdmittedBy, for, maxDepth, overline, title, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.Toc as Orig


{-| See [`M3e.Component.Toc.el`](M3e.Component.Toc#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element childAccepts (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.Toc.Is`](M3e.Component.Toc#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.Toc.Attrs`](M3e.Component.Toc#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.Toc.OverlineSlot`](M3e.Component.Toc#OverlineSlot).
-}
type alias OverlineSlot =
    Orig.OverlineSlot


{-| See [`M3e.Component.Toc.TitleSlot`](M3e.Component.Toc#TitleSlot).
-}
type alias TitleSlot =
    Orig.TitleSlot


{-| See [`M3e.Component.Toc.ChildAdmittedBy`](M3e.Component.Toc#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.Toc.for`](M3e.Component.Toc#for).
-}
for : String -> Attr { c | for : Supported } msg
for =
    Orig.for


{-| See [`M3e.Component.Toc.maxDepth`](M3e.Component.Toc#maxDepth).
-}
maxDepth : Float -> Attr { c | maxDepth : Supported } msg
maxDepth =
    Orig.maxDepth


{-| See [`M3e.Component.Toc.overline`](M3e.Component.Toc#overline).
-}
overline : Element OverlineSlot admittedBy msg -> Element free freeAdmittedBy msg
overline =
    Orig.overline


{-| See [`M3e.Component.Toc.title`](M3e.Component.Toc#title).
-}
title : Element TitleSlot admittedBy msg -> Element free freeAdmittedBy msg
title =
    Orig.title


{-| See [`M3e.Component.Toc.child`](M3e.Component.Toc#child).
-}
child : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
