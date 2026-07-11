module M3e.Build.ButtonGroup.Slots exposing (iconButton, button)

{-| Slot setters for `M3e.Build.ButtonGroup`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs iconButton, button

-}

import M3e.Build.Button
import M3e.Build.ButtonGroup
import M3e.Build.IconButton
import M3e.Build.Internal
import M3e.Node


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.ButtonGroup.Builder pa ps msg pk
    -> M3e.Build.ButtonGroup.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `IconButton` in the `unnamed` slot of `ButtonGroup`.
-}
iconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.ButtonGroup.Builder pa ps msg pk
    -> M3e.Build.ButtonGroup.Builder pa ps msg pk
iconButton =
    unnamed_core


{-| Place a `Button` in the `unnamed` slot of `ButtonGroup`.
-}
button :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.ButtonGroup.Builder pa ps msg pk
    -> M3e.Build.ButtonGroup.Builder pa ps msg pk
button =
    unnamed_core
