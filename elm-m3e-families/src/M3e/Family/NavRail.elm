module M3e.Family.NavRail exposing (el, Is, Attrs, Content, ChildAdmittedBy, Mode, mode, onBeforeinput, onInput, onChange, child)

{-| The **NavRail** family root — re-export of `M3e.Component.NavRail`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.NavRail`](M3e.Component.NavRail) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, ChildAdmittedBy, Mode, mode, onBeforeinput, onInput, onChange, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.NavRail as Orig


{-| See [`M3e.Component.NavRail.el`](M3e.Component.NavRail#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.NavRail.Is`](M3e.Component.NavRail#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.NavRail.Attrs`](M3e.Component.NavRail#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.NavRail.Content`](M3e.Component.NavRail#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.NavRail.ChildAdmittedBy`](M3e.Component.NavRail#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.NavRail.Mode`](M3e.Component.NavRail#Mode).
-}
type alias Mode =
    Orig.Mode


{-| See [`M3e.Component.NavRail.mode`](M3e.Component.NavRail#mode).
-}
mode : Value Mode -> Attr { c | mode : Supported } msg
mode =
    Orig.mode


{-| See [`M3e.Component.NavRail.onBeforeinput`](M3e.Component.NavRail#onBeforeinput).
-}
onBeforeinput : msg -> Attr { c | onBeforeinput : Supported } msg
onBeforeinput =
    Orig.onBeforeinput


{-| See [`M3e.Component.NavRail.onInput`](M3e.Component.NavRail#onInput).
-}
onInput : msg -> Attr { c | onInput : Supported } msg
onInput =
    Orig.onInput


{-| See [`M3e.Component.NavRail.onChange`](M3e.Component.NavRail#onChange).
-}
onChange : msg -> Attr { c | onChange : Supported } msg
onChange =
    Orig.onChange


{-| See [`M3e.Component.NavRail.child`](M3e.Component.NavRail#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
