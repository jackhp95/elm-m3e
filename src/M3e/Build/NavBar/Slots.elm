module M3e.Build.NavBar.Slots exposing (navItem)

{-| Slot setters for `M3e.Build.NavBar`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs navItem

-}

import M3e.Build.Internal
import M3e.Build.NavBar
import M3e.Build.NavItem
import M3e.Node


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.NavBar.Builder pa ps msg pk
    -> M3e.Build.NavBar.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `NavItem` in the `unnamed` slot of `NavBar`.
-}
navItem :
    M3e.Build.NavItem.Builder ca cs msg ck
    -> M3e.Build.NavBar.Builder pa ps msg pk
    -> M3e.Build.NavBar.Builder pa ps msg pk
navItem =
    unnamed_core
