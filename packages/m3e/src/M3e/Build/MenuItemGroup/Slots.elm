module M3e.Build.MenuItemGroup.Slots exposing ( menuItemRadio, menuItemCheckbox, menuItem )

{-|
Slot setters for `M3e.Build.MenuItemGroup`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs menuItemRadio, menuItemCheckbox, menuItem
-}


import M3e.Build.Internal
import M3e.Build.MenuItem
import M3e.Build.MenuItemCheckbox
import M3e.Build.MenuItemGroup
import M3e.Build.MenuItemRadio
import M3e.Node


default_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.MenuItemGroup.Builder pa ps msg pk
    -> M3e.Build.MenuItemGroup.Builder pa ps msg pk
default_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `MenuItemRadio` in the `unnamed` slot of `MenuItemGroup`. -}
menuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.MenuItemGroup.Builder pa ps msg pk
    -> M3e.Build.MenuItemGroup.Builder pa ps msg pk
menuItemRadio =
    default_core


{-| Place a `MenuItemCheckbox` in the `unnamed` slot of `MenuItemGroup`. -}
menuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.MenuItemGroup.Builder pa ps msg pk
    -> M3e.Build.MenuItemGroup.Builder pa ps msg pk
menuItemCheckbox =
    default_core


{-| Place a `MenuItem` in the `unnamed` slot of `MenuItemGroup`. -}
menuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.MenuItemGroup.Builder pa ps msg pk
    -> M3e.Build.MenuItemGroup.Builder pa ps msg pk
menuItem =
    default_core