module M3e.Build.Optgroup.Slots exposing (option)

{-| Slot setters for `M3e.Build.Optgroup`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs option

-}

import M3e.Build.Internal
import M3e.Build.Optgroup
import M3e.Build.Option
import M3e.Node


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.Optgroup.Builder pa ps msg pk
    -> M3e.Build.Optgroup.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Option` in the `unnamed` slot of `Optgroup`.
-}
option :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.Optgroup.Builder pa ps msg pk
    -> M3e.Build.Optgroup.Builder pa ps msg pk
option =
    unnamed_core
