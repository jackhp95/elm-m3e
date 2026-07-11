module M3e.Build.InputChipSet.Slots exposing (inputChip, input)

{-| Slot setters for `M3e.Build.InputChipSet`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs inputChip, input

-}

import M3e.Build.InputChip
import M3e.Build.InputChipSet
import M3e.Build.Internal
import M3e.Node


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.InputChipSet.Builder pa ps msg pk
    -> M3e.Build.InputChipSet.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `InputChip` in the `unnamed` slot of `InputChipSet`.
-}
inputChip :
    M3e.Build.InputChip.Builder ca cs msg ck
    -> M3e.Build.InputChipSet.Builder pa ps msg pk
    -> M3e.Build.InputChipSet.Builder pa ps msg pk
inputChip =
    unnamed_core


{-| Place any child in the `input` slot of `InputChipSet` (an arbitrary slot — accepts any component's Builder).
-}
input :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.InputChipSet.Builder
            pa
            { ps
                | input : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.InputChipSet.Builder
            pa
            { ps
                | input : M3e.Build.Internal.Used
            }
            msg
            pk
input child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
