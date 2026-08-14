module M3e.Family.Menu exposing (el, Is, Attrs, Content, ChildAdmittedBy, PositionX, positionX, PositionY, positionY, Variant, variant, submenu, onBeforetoggle, onToggle, child)

{-| The **Menu** family root — re-export of `M3e.Component.Menu`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.Menu`](M3e.Component.Menu) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, ChildAdmittedBy, PositionX, positionX, PositionY, positionY, Variant, variant, submenu, onBeforetoggle, onToggle, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Value exposing (Value)
import M3e.Component.Menu as Orig


{-| See [`M3e.Component.Menu.el`](M3e.Component.Menu#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.Menu.Is`](M3e.Component.Menu#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.Menu.Attrs`](M3e.Component.Menu#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.Menu.Content`](M3e.Component.Menu#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.Menu.ChildAdmittedBy`](M3e.Component.Menu#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.Menu.PositionX`](M3e.Component.Menu#PositionX).
-}
type alias PositionX =
    Orig.PositionX


{-| See [`M3e.Component.Menu.positionX`](M3e.Component.Menu#positionX).
-}
positionX : Value PositionX -> Attr { c | positionX : Supported } msg
positionX =
    Orig.positionX


{-| See [`M3e.Component.Menu.PositionY`](M3e.Component.Menu#PositionY).
-}
type alias PositionY =
    Orig.PositionY


{-| See [`M3e.Component.Menu.positionY`](M3e.Component.Menu#positionY).
-}
positionY : Value PositionY -> Attr { c | positionY : Supported } msg
positionY =
    Orig.positionY


{-| See [`M3e.Component.Menu.Variant`](M3e.Component.Menu#Variant).
-}
type alias Variant =
    Orig.Variant


{-| See [`M3e.Component.Menu.variant`](M3e.Component.Menu#variant).
-}
variant : Value Variant -> Attr { c | variant : Supported } msg
variant =
    Orig.variant


{-| See [`M3e.Component.Menu.submenu`](M3e.Component.Menu#submenu).
-}
submenu : Bool -> Attr { c | submenu : Supported } msg
submenu =
    Orig.submenu


{-| See [`M3e.Component.Menu.onBeforetoggle`](M3e.Component.Menu#onBeforetoggle).
-}
onBeforetoggle : msg -> Attr { c | onBeforetoggle : Supported } msg
onBeforetoggle =
    Orig.onBeforetoggle


{-| See [`M3e.Component.Menu.onToggle`](M3e.Component.Menu#onToggle).
-}
onToggle : (String -> msg) -> Attr { c | onToggle : Supported } msg
onToggle =
    Orig.onToggle


{-| See [`M3e.Component.Menu.child`](M3e.Component.Menu#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
