module M3e.Build.NavMenu.Slots exposing ( navMenuItemGroup, navMenuItem, divider )

{-|
Slot setters for `M3e.Build.NavMenu`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs navMenuItemGroup, navMenuItem, divider
-}


import M3e.Build.Divider
import M3e.Build.Internal
import M3e.Build.NavMenu
import M3e.Build.NavMenuItem
import M3e.Build.NavMenuItemGroup
import M3e.Node


default_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.NavMenu.Builder pa ps msg pk
    -> M3e.Build.NavMenu.Builder pa ps msg pk
default_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `NavMenuItemGroup` in the `unnamed` slot of `NavMenu`. -}
navMenuItemGroup :
    M3e.Build.NavMenuItemGroup.Builder ca cs msg ck
    -> M3e.Build.NavMenu.Builder pa ps msg pk
    -> M3e.Build.NavMenu.Builder pa ps msg pk
navMenuItemGroup =
    default_core


{-| Place a `NavMenuItem` in the `unnamed` slot of `NavMenu`. -}
navMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.NavMenu.Builder pa ps msg pk
    -> M3e.Build.NavMenu.Builder pa ps msg pk
navMenuItem =
    default_core


{-| Place a `Divider` in the `unnamed` slot of `NavMenu`. -}
divider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.NavMenu.Builder pa ps msg pk
    -> M3e.Build.NavMenu.Builder pa ps msg pk
divider =
    default_core