module M3e.Family.SegmentedButton.Group exposing (el, Is, Attrs, Content, ChildAdmittedBy, Size, size, Variant, variant, multi, child)

{-| `ButtonGroup`, grouped under the **SegmentedButton** family as `Group`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.ButtonGroup`](M3e.Component.ButtonGroup) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, ChildAdmittedBy, Size, size, Variant, variant, multi, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.ButtonGroup as Orig


{-| See [`M3e.Component.ButtonGroup.el`](M3e.Component.ButtonGroup#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.ButtonGroup.Is`](M3e.Component.ButtonGroup#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.ButtonGroup.Attrs`](M3e.Component.ButtonGroup#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.ButtonGroup.Content`](M3e.Component.ButtonGroup#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.ButtonGroup.ChildAdmittedBy`](M3e.Component.ButtonGroup#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.ButtonGroup.Size`](M3e.Component.ButtonGroup#Size).
-}
type alias Size =
    Orig.Size


{-| See [`M3e.Component.ButtonGroup.size`](M3e.Component.ButtonGroup#size).
-}
size : Value Size -> Attr { c | size : Supported } msg
size =
    Orig.size


{-| See [`M3e.Component.ButtonGroup.Variant`](M3e.Component.ButtonGroup#Variant).
-}
type alias Variant =
    Orig.Variant


{-| See [`M3e.Component.ButtonGroup.variant`](M3e.Component.ButtonGroup#variant).
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant =
    Orig.variant


{-| See [`M3e.Component.ButtonGroup.multi`](M3e.Component.ButtonGroup#multi).
-}
multi : Bool -> Attr { c | multi : Supported } msg
multi =
    Orig.multi


{-| See [`M3e.Component.ButtonGroup.child`](M3e.Component.ButtonGroup#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
