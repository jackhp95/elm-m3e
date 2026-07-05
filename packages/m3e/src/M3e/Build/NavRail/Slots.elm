module M3e.Build.NavRail.Slots exposing ( navItem, fab, iconButton )

{-|
Slot setters for `M3e.Build.NavRail`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs navItem, fab, iconButton
-}


import M3e.Build.Fab
import M3e.Build.IconButton
import M3e.Build.Internal
import M3e.Build.NavItem
import M3e.Build.NavRail
import M3e.Node


default_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.NavRail.Builder pa ps msg pk
    -> M3e.Build.NavRail.Builder pa ps msg pk
default_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `NavItem` in the `unnamed` slot of `NavRail`. -}
navItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.NavRail.Builder pa ps msg pk
    -> M3e.Build.NavRail.Builder pa ps msg pk
navItem =
    default_core


{-| Place a `Fab` in the `unnamed` slot of `NavRail`. -}
fab :
    M3e.Build.Fab.Builder ca cs msg ck
    -> M3e.Build.NavRail.Builder pa ps msg pk
    -> M3e.Build.NavRail.Builder pa ps msg pk
fab =
    default_core


{-| Place a `IconButton` in the `unnamed` slot of `NavRail`. -}
iconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.NavRail.Builder pa ps msg pk
    -> M3e.Build.NavRail.Builder pa ps msg pk
iconButton =
    default_core