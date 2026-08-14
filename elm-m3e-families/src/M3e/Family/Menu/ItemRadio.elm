module M3e.Family.Menu.ItemRadio exposing (el, Is, Attrs, Content, IconSlot, TrailingIconSlot, ChildAdmittedBy, checked, disabled, defaultChecked, onClick, icon, trailingIcon, child)

{-| `MenuItemRadio`, grouped under the **Menu** family as `ItemRadio`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.MenuItemRadio`](M3e.Component.MenuItemRadio) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, IconSlot, TrailingIconSlot, ChildAdmittedBy, checked, disabled, defaultChecked, onClick, icon, trailingIcon, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.MenuItemRadio as Orig


{-| See [`M3e.Component.MenuItemRadio.el`](M3e.Component.MenuItemRadio#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.MenuItemRadio.Is`](M3e.Component.MenuItemRadio#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.MenuItemRadio.Attrs`](M3e.Component.MenuItemRadio#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.MenuItemRadio.Content`](M3e.Component.MenuItemRadio#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.MenuItemRadio.IconSlot`](M3e.Component.MenuItemRadio#IconSlot).
-}
type alias IconSlot =
    Orig.IconSlot


{-| See [`M3e.Component.MenuItemRadio.TrailingIconSlot`](M3e.Component.MenuItemRadio#TrailingIconSlot).
-}
type alias TrailingIconSlot =
    Orig.TrailingIconSlot


{-| See [`M3e.Component.MenuItemRadio.ChildAdmittedBy`](M3e.Component.MenuItemRadio#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.MenuItemRadio.checked`](M3e.Component.MenuItemRadio#checked).
-}
checked : Bool -> Attr { c | checked : Supported } msg
checked =
    Orig.checked


{-| See [`M3e.Component.MenuItemRadio.disabled`](M3e.Component.MenuItemRadio#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.MenuItemRadio.defaultChecked`](M3e.Component.MenuItemRadio#defaultChecked).
-}
defaultChecked : Bool -> Attr { c | checked : Supported } msg
defaultChecked =
    Orig.defaultChecked


{-| See [`M3e.Component.MenuItemRadio.onClick`](M3e.Component.MenuItemRadio#onClick).
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Orig.onClick


{-| See [`M3e.Component.MenuItemRadio.icon`](M3e.Component.MenuItemRadio#icon).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon =
    Orig.icon


{-| See [`M3e.Component.MenuItemRadio.trailingIcon`](M3e.Component.MenuItemRadio#trailingIcon).
-}
trailingIcon : Element TrailingIconSlot admittedBy msg -> Element free freeAdmittedBy msg
trailingIcon =
    Orig.trailingIcon


{-| See [`M3e.Component.MenuItemRadio.child`](M3e.Component.MenuItemRadio#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
