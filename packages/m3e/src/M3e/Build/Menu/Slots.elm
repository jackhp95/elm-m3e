module M3e.Build.Menu.Slots exposing
    ( menuItemRadio, menuItemGroup, menuItemCheckbox, menuItem, divider
    )

{-|
Slot setters for `M3e.Build.Menu`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs menuItemRadio, menuItemGroup, menuItemCheckbox, menuItem, divider
-}


import M3e.Build.Divider
import M3e.Build.Internal
import M3e.Build.Menu
import M3e.Build.MenuItem
import M3e.Build.MenuItemCheckbox
import M3e.Build.MenuItemGroup
import M3e.Build.MenuItemRadio
import M3e.Node


default_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.Menu.Builder pa ps msg pk
    -> M3e.Build.Menu.Builder pa ps msg pk
default_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `MenuItemRadio` in the `unnamed` slot of `Menu`. -}
menuItemRadio :
    M3e.Build.MenuItemRadio.Builder ca cs msg ck
    -> M3e.Build.Menu.Builder pa ps msg pk
    -> M3e.Build.Menu.Builder pa ps msg pk
menuItemRadio =
    default_core


{-| Place a `MenuItemGroup` in the `unnamed` slot of `Menu`. -}
menuItemGroup :
    M3e.Build.MenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.Menu.Builder pa ps msg pk
    -> M3e.Build.Menu.Builder pa ps msg pk
menuItemGroup =
    default_core


{-| Place a `MenuItemCheckbox` in the `unnamed` slot of `Menu`. -}
menuItemCheckbox :
    M3e.Build.MenuItemCheckbox.Builder ca cs msg ck
    -> M3e.Build.Menu.Builder pa ps msg pk
    -> M3e.Build.Menu.Builder pa ps msg pk
menuItemCheckbox =
    default_core


{-| Place a `MenuItem` in the `unnamed` slot of `Menu`. -}
menuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.Menu.Builder pa ps msg pk
    -> M3e.Build.Menu.Builder pa ps msg pk
menuItem =
    default_core


{-| Place a `Divider` in the `unnamed` slot of `Menu`. -}
divider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.Menu.Builder pa ps msg pk
    -> M3e.Build.Menu.Builder pa ps msg pk
divider =
    default_core