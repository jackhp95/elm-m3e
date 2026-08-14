module M3e.Family.Breadcrumb.Item exposing (el, Is, Attrs, Content, IconSlot, ChildAdmittedBy, Current, current, disabled, download, href, itemLabel, rel, target, onClick, icon, child)

{-| `BreadcrumbItem`, grouped under the **Breadcrumb** family as `Item`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.BreadcrumbItem`](M3e.Component.BreadcrumbItem) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, IconSlot, ChildAdmittedBy, Current, current, disabled, download, href, itemLabel, rel, target, onClick, icon, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.BreadcrumbItem as Orig


{-| See [`M3e.Component.BreadcrumbItem.el`](M3e.Component.BreadcrumbItem#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.BreadcrumbItem.Is`](M3e.Component.BreadcrumbItem#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.BreadcrumbItem.Attrs`](M3e.Component.BreadcrumbItem#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.BreadcrumbItem.Content`](M3e.Component.BreadcrumbItem#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.BreadcrumbItem.IconSlot`](M3e.Component.BreadcrumbItem#IconSlot).
-}
type alias IconSlot =
    Orig.IconSlot


{-| See [`M3e.Component.BreadcrumbItem.ChildAdmittedBy`](M3e.Component.BreadcrumbItem#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.BreadcrumbItem.Current`](M3e.Component.BreadcrumbItem#Current).
-}
type alias Current =
    Orig.Current


{-| See [`M3e.Component.BreadcrumbItem.current`](M3e.Component.BreadcrumbItem#current).
-}
current : Value Current -> Attr { c | current : Supported } msg
current =
    Orig.current


{-| See [`M3e.Component.BreadcrumbItem.disabled`](M3e.Component.BreadcrumbItem#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.BreadcrumbItem.download`](M3e.Component.BreadcrumbItem#download).
-}
download : String -> Attr { c | download : Supported } msg
download =
    Orig.download


{-| See [`M3e.Component.BreadcrumbItem.href`](M3e.Component.BreadcrumbItem#href).
-}
href : String -> Attr { c | href : Supported } msg
href =
    Orig.href


{-| See [`M3e.Component.BreadcrumbItem.itemLabel`](M3e.Component.BreadcrumbItem#itemLabel).
-}
itemLabel : String -> Attr { c | itemLabel : Supported } msg
itemLabel =
    Orig.itemLabel


{-| See [`M3e.Component.BreadcrumbItem.rel`](M3e.Component.BreadcrumbItem#rel).
-}
rel : String -> Attr { c | rel : Supported } msg
rel =
    Orig.rel


{-| See [`M3e.Component.BreadcrumbItem.target`](M3e.Component.BreadcrumbItem#target).
-}
target : String -> Attr { c | target : Supported } msg
target =
    Orig.target


{-| See [`M3e.Component.BreadcrumbItem.onClick`](M3e.Component.BreadcrumbItem#onClick).
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Orig.onClick


{-| See [`M3e.Component.BreadcrumbItem.icon`](M3e.Component.BreadcrumbItem#icon).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon =
    Orig.icon


{-| See [`M3e.Component.BreadcrumbItem.child`](M3e.Component.BreadcrumbItem#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
