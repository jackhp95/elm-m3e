module M3e.Family.Tree exposing (el, Is, Attrs, Content, ChildAdmittedBy, cascade, multi, onChange, child)

{-| The **Tree** family root — re-export of `M3e.Component.Tree`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.Tree`](M3e.Component.Tree) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, ChildAdmittedBy, cascade, multi, onChange, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.Tree as Orig


{-| See [`M3e.Component.Tree.el`](M3e.Component.Tree#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.Tree.Is`](M3e.Component.Tree#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.Tree.Attrs`](M3e.Component.Tree#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.Tree.Content`](M3e.Component.Tree#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.Tree.ChildAdmittedBy`](M3e.Component.Tree#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.Tree.cascade`](M3e.Component.Tree#cascade).
-}
cascade : Bool -> Attr { c | cascade : Supported } msg
cascade =
    Orig.cascade


{-| See [`M3e.Component.Tree.multi`](M3e.Component.Tree#multi).
-}
multi : Bool -> Attr { c | multi : Supported } msg
multi =
    Orig.multi


{-| See [`M3e.Component.Tree.onChange`](M3e.Component.Tree#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.Tree.child`](M3e.Component.Tree#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
