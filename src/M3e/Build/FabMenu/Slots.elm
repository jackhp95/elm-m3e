module M3e.Build.FabMenu.Slots exposing ( menuItem, fabMenuItem )

{-|
Slot setters for `M3e.Build.FabMenu`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs menuItem, fabMenuItem
-}


import M3e.Build.FabMenu
import M3e.Build.FabMenuItem
import M3e.Build.Internal
import M3e.Build.MenuItem
import M3e.Node


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.FabMenu.Builder pa ps msg pk
    -> M3e.Build.FabMenu.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `MenuItem` in the `unnamed` slot of `FabMenu`. -}
menuItem :
    M3e.Build.MenuItem.Builder ca cs msg ck
    -> M3e.Build.FabMenu.Builder pa ps msg pk
    -> M3e.Build.FabMenu.Builder pa ps msg pk
menuItem =
    unnamed_core


{-| Place a `FabMenuItem` in the `unnamed` slot of `FabMenu`. -}
fabMenuItem :
    M3e.Build.FabMenuItem.Builder ca cs msg ck
    -> M3e.Build.FabMenu.Builder pa ps msg pk
    -> M3e.Build.FabMenu.Builder pa ps msg pk
fabMenuItem =
    unnamed_core