module M3e.Family.List exposing (el, Is, Attrs, Content, ChildAdmittedBy, Variant, variant, child)

{-| The **List** family root — re-export of `M3e.Component.List`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.List`](M3e.Component.List) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, ChildAdmittedBy, Variant, variant, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.List as Orig


{-| See [`M3e.Component.List.el`](M3e.Component.List#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.List.Is`](M3e.Component.List#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.List.Attrs`](M3e.Component.List#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.List.Content`](M3e.Component.List#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.List.ChildAdmittedBy`](M3e.Component.List#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.List.Variant`](M3e.Component.List#Variant).
-}
type alias Variant =
    Orig.Variant


{-| See [`M3e.Component.List.variant`](M3e.Component.List#variant).
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant =
    Orig.variant


{-| See [`M3e.Component.List.child`](M3e.Component.List#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
