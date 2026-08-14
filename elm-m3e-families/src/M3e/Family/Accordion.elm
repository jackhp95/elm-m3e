module M3e.Family.Accordion exposing (el, Is, Attrs, Content, ChildAdmittedBy, multi, child)

{-| The **Accordion** family root — re-export of `M3e.Component.Accordion`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.Accordion`](M3e.Component.Accordion) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, ChildAdmittedBy, multi, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.Accordion as Orig


{-| See [`M3e.Component.Accordion.el`](M3e.Component.Accordion#el).
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.Accordion.Is`](M3e.Component.Accordion#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.Accordion.Attrs`](M3e.Component.Accordion#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.Accordion.Content`](M3e.Component.Accordion#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.Accordion.ChildAdmittedBy`](M3e.Component.Accordion#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.Accordion.multi`](M3e.Component.Accordion#multi).
-}
multi : Bool -> Attr { c | multi : Supported } msg
multi =
    Orig.multi


{-| See [`M3e.Component.Accordion.child`](M3e.Component.Accordion#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
