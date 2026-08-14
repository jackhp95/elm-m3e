module M3e.Family.Breadcrumb exposing (el, Is, Attrs, Content, ChildAdmittedBy, wrap, separator, child)

{-| The **Breadcrumb** family root — re-export of `M3e.Component.Breadcrumb`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.Breadcrumb`](M3e.Component.Breadcrumb) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, ChildAdmittedBy, wrap, separator, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.Breadcrumb as Orig


{-| See [`M3e.Component.Breadcrumb.el`](M3e.Component.Breadcrumb#el).
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.Breadcrumb.Is`](M3e.Component.Breadcrumb#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.Breadcrumb.Attrs`](M3e.Component.Breadcrumb#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.Breadcrumb.Content`](M3e.Component.Breadcrumb#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.Breadcrumb.ChildAdmittedBy`](M3e.Component.Breadcrumb#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.Breadcrumb.wrap`](M3e.Component.Breadcrumb#wrap).
-}
wrap : Bool -> Attr { c | wrap : Supported } msg
wrap =
    Orig.wrap


{-| See [`M3e.Component.Breadcrumb.separator`](M3e.Component.Breadcrumb#separator).
-}
separator : Element childAccepts admittedBy msg -> Element free freeAdmittedBy msg
separator =
    Orig.separator


{-| See [`M3e.Component.Breadcrumb.child`](M3e.Component.Breadcrumb#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
