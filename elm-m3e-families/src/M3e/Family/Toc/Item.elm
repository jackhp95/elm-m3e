module M3e.Family.Toc.Item exposing (el, Is, Attrs, Content, ChildAdmittedBy, disabled, selected, defaultSelected, onClick, child)

{-| `TocItem`, grouped under the **Toc** family as `Item`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.TocItem`](M3e.Component.TocItem) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, ChildAdmittedBy, disabled, selected, defaultSelected, onClick, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.TocItem as Orig


{-| See [`M3e.Component.TocItem.el`](M3e.Component.TocItem#el).
-}
el :
    { content : Element Content (ChildAdmittedBy childAdm) msg }
    -> List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.TocItem.Is`](M3e.Component.TocItem#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.TocItem.Attrs`](M3e.Component.TocItem#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.TocItem.Content`](M3e.Component.TocItem#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.TocItem.ChildAdmittedBy`](M3e.Component.TocItem#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.TocItem.disabled`](M3e.Component.TocItem#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.TocItem.selected`](M3e.Component.TocItem#selected).
-}
selected : Bool -> Attr { c | selected : Supported } msg
selected =
    Orig.selected


{-| See [`M3e.Component.TocItem.defaultSelected`](M3e.Component.TocItem#defaultSelected).
-}
defaultSelected : Bool -> Attr { c | selected : Supported } msg
defaultSelected =
    Orig.defaultSelected


{-| See [`M3e.Component.TocItem.onClick`](M3e.Component.TocItem#onClick).
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Orig.onClick


{-| See [`M3e.Component.TocItem.child`](M3e.Component.TocItem#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
