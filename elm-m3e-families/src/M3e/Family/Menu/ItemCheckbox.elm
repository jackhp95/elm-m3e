module M3e.Family.Menu.ItemCheckbox exposing (el, Is, Attrs, Content, IconSlot, TrailingIconSlot, ChildAdmittedBy, checked, disabled, defaultChecked, onClick, icon, trailingIcon, child)

{-| `MenuItemCheckbox`, grouped under the **Menu** family as `ItemCheckbox`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.MenuItemCheckbox`](M3e.Component.MenuItemCheckbox) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, IconSlot, TrailingIconSlot, ChildAdmittedBy, checked, disabled, defaultChecked, onClick, icon, trailingIcon, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.MenuItemCheckbox as Orig


{-| See [`M3e.Component.MenuItemCheckbox.el`](M3e.Component.MenuItemCheckbox#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.MenuItemCheckbox.Is`](M3e.Component.MenuItemCheckbox#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.MenuItemCheckbox.Attrs`](M3e.Component.MenuItemCheckbox#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.MenuItemCheckbox.Content`](M3e.Component.MenuItemCheckbox#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.MenuItemCheckbox.IconSlot`](M3e.Component.MenuItemCheckbox#IconSlot).
-}
type alias IconSlot =
    Orig.IconSlot


{-| See [`M3e.Component.MenuItemCheckbox.TrailingIconSlot`](M3e.Component.MenuItemCheckbox#TrailingIconSlot).
-}
type alias TrailingIconSlot =
    Orig.TrailingIconSlot


{-| See [`M3e.Component.MenuItemCheckbox.ChildAdmittedBy`](M3e.Component.MenuItemCheckbox#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.MenuItemCheckbox.checked`](M3e.Component.MenuItemCheckbox#checked).
-}
checked : Bool -> Attr { c | checked : Supported } msg
checked =
    Orig.checked


{-| See [`M3e.Component.MenuItemCheckbox.disabled`](M3e.Component.MenuItemCheckbox#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.MenuItemCheckbox.defaultChecked`](M3e.Component.MenuItemCheckbox#defaultChecked).
-}
defaultChecked : Bool -> Attr { c | checked : Supported } msg
defaultChecked =
    Orig.defaultChecked


{-| See [`M3e.Component.MenuItemCheckbox.onClick`](M3e.Component.MenuItemCheckbox#onClick).
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Orig.onClick


{-| See [`M3e.Component.MenuItemCheckbox.icon`](M3e.Component.MenuItemCheckbox#icon).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon =
    Orig.icon


{-| See [`M3e.Component.MenuItemCheckbox.trailingIcon`](M3e.Component.MenuItemCheckbox#trailingIcon).
-}
trailingIcon : Element TrailingIconSlot admittedBy msg -> Element free freeAdmittedBy msg
trailingIcon =
    Orig.trailingIcon


{-| See [`M3e.Component.MenuItemCheckbox.child`](M3e.Component.MenuItemCheckbox#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
