module M3e.Build.NavMenuItemGroup.Slots exposing ( labelHeading, navMenuItem )

{-|
Slot setters for `M3e.Build.NavMenuItemGroup`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs labelHeading, navMenuItem
-}


import M3e.Build.Heading
import M3e.Build.Internal
import M3e.Build.NavMenuItem
import M3e.Build.NavMenuItemGroup
import M3e.Node


label_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.NavMenuItemGroup.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.NavMenuItemGroup.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
label_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


default_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.NavMenuItemGroup.Builder pa ps msg pk
    -> M3e.Build.NavMenuItemGroup.Builder pa ps msg pk
default_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Heading` in the `label` slot of `NavMenuItemGroup`. -}
labelHeading :
    M3e.Build.Heading.Builder ca cs msg ck
    -> M3e.Build.NavMenuItemGroup.Builder pa { ps
        | label : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.NavMenuItemGroup.Builder pa { ps
        | label : M3e.Build.Internal.Used
    } msg pk
labelHeading =
    label_core


{-| Place a `NavMenuItem` in the `unnamed` slot of `NavMenuItemGroup`. -}
navMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.NavMenuItemGroup.Builder pa ps msg pk
    -> M3e.Build.NavMenuItemGroup.Builder pa ps msg pk
navMenuItem =
    default_core