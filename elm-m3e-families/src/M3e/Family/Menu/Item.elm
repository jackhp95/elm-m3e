module M3e.Family.Menu.Item exposing (el, Is, Attrs, Content, IconSlot, TrailingIconSlot, ChildAdmittedBy, disabled, download, href, rel, target, onClick, icon, trailingIcon, child)

{-| `MenuItem`, grouped under the **Menu** family as `Item`.

This module is part of the **family-grouped** organization of elm-m3e: it
re-exports the flat [`M3e.Component.MenuItem`](M3e.Component.MenuItem) surface under a nested
family path, unchanged. Prefer whichever import reads best for your code —
the flat module and this family module are the same element, same types.

@docs el, Is, Attrs, Content, IconSlot, TrailingIconSlot, ChildAdmittedBy, disabled, download, href, rel, target, onClick, icon, trailingIcon, child

-}

import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Kind exposing (Shared, Supported)
import M3e.Component.MenuItem as Orig


{-| See [`M3e.Component.MenuItem.el`](M3e.Component.MenuItem#el).
-}
el :
    List (Attr Attrs msg)
    -> List (Element Content (ChildAdmittedBy childAdm) msg)
    -> Element (Is s) admittedBy msg
el =
    Orig.el


{-| See [`M3e.Component.MenuItem.Is`](M3e.Component.MenuItem#Is).
-}
type alias Is s =
    Orig.Is s


{-| See [`M3e.Component.MenuItem.Attrs`](M3e.Component.MenuItem#Attrs).
-}
type alias Attrs =
    Orig.Attrs


{-| See [`M3e.Component.MenuItem.Content`](M3e.Component.MenuItem#Content).
-}
type alias Content =
    Orig.Content


{-| See [`M3e.Component.MenuItem.IconSlot`](M3e.Component.MenuItem#IconSlot).
-}
type alias IconSlot =
    Orig.IconSlot


{-| See [`M3e.Component.MenuItem.TrailingIconSlot`](M3e.Component.MenuItem#TrailingIconSlot).
-}
type alias TrailingIconSlot =
    Orig.TrailingIconSlot


{-| See [`M3e.Component.MenuItem.ChildAdmittedBy`](M3e.Component.MenuItem#ChildAdmittedBy).
-}
type alias ChildAdmittedBy childAdm =
    Orig.ChildAdmittedBy childAdm


{-| See [`M3e.Component.MenuItem.disabled`](M3e.Component.MenuItem#disabled).
-}
disabled : Bool -> Attr { c | disabled : Supported } msg
disabled =
    Orig.disabled


{-| See [`M3e.Component.MenuItem.download`](M3e.Component.MenuItem#download).
-}
download : String -> Attr { c | download : Supported } msg
download =
    Orig.download


{-| See [`M3e.Component.MenuItem.href`](M3e.Component.MenuItem#href).
-}
href : String -> Attr { c | href : Supported } msg
href =
    Orig.href


{-| See [`M3e.Component.MenuItem.rel`](M3e.Component.MenuItem#rel).
-}
rel : String -> Attr { c | rel : Supported } msg
rel =
    Orig.rel


{-| See [`M3e.Component.MenuItem.target`](M3e.Component.MenuItem#target).
-}
target : String -> Attr { c | target : Supported } msg
target =
    Orig.target


{-| See [`M3e.Component.MenuItem.onClick`](M3e.Component.MenuItem#onClick).
-}
onClick : msg -> Attr { c | onClick : Supported } msg
onClick =
    Orig.onClick


{-| See [`M3e.Component.MenuItem.icon`](M3e.Component.MenuItem#icon).
-}
icon : Element IconSlot admittedBy msg -> Element free freeAdmittedBy msg
icon =
    Orig.icon


{-| See [`M3e.Component.MenuItem.trailingIcon`](M3e.Component.MenuItem#trailingIcon).
-}
trailingIcon : Element TrailingIconSlot admittedBy msg -> Element free freeAdmittedBy msg
trailingIcon =
    Orig.trailingIcon


{-| See [`M3e.Component.MenuItem.child`](M3e.Component.MenuItem#child).
-}
child : Element Content admittedBy msg -> Element free freeAdmittedBy msg
child =
    Orig.child
