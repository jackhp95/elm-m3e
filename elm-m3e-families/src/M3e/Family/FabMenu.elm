module M3e.Family.FabMenu exposing (el, Is, Attrs, Content, ChildAdmittedBy, Variant, variant, onBeforetoggle, onToggle, child)

{-| The **FabMenu** family root — re-export of `M3e.Component.FabMenu`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.FabMenu`](M3e.Component.FabMenu) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, ChildAdmittedBy, Variant, variant, onBeforetoggle, onToggle, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.FabMenu as Orig


{-| See [`M3e.Component.FabMenu.el`](M3e.Component.FabMenu#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.FabMenu.Is`](M3e.Component.FabMenu#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.FabMenu.Attrs`](M3e.Component.FabMenu#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.FabMenu.Content`](M3e.Component.FabMenu#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.FabMenu.ChildAdmittedBy`](M3e.Component.FabMenu#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.FabMenu.Variant`](M3e.Component.FabMenu#Variant).
-}
type alias Variant =
    Orig.Variant


{-| See [`M3e.Component.FabMenu.variant`](M3e.Component.FabMenu#variant).
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant =
    Orig.variant


{-| See [`M3e.Component.FabMenu.onBeforetoggle`](M3e.Component.FabMenu#onBeforetoggle).
-}
onBeforetoggle : msg -> Attr { c | onBeforetoggle : Supported } msg
onBeforetoggle =
    Orig.onBeforetoggle


{-| See [`M3e.Component.FabMenu.onToggle`](M3e.Component.FabMenu#onToggle).
-}
onToggle : msg -> Attr { c | onToggle : Supported } msg
onToggle =
    Orig.onToggle


{-| See [`M3e.Component.FabMenu.child`](M3e.Component.FabMenu#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
