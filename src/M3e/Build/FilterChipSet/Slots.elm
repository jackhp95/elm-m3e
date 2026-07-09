module M3e.Build.FilterChipSet.Slots exposing ( filterChip )

{-|
Slot setters for `M3e.Build.FilterChipSet`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs filterChip
-}


import M3e.Build.FilterChip
import M3e.Build.FilterChipSet
import M3e.Build.Internal
import M3e.Node


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.FilterChipSet.Builder pa ps msg pk
    -> M3e.Build.FilterChipSet.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `FilterChip` in the `unnamed` slot of `FilterChipSet`. -}
filterChip :
    M3e.Build.FilterChip.Builder ca cs msg ck
    -> M3e.Build.FilterChipSet.Builder pa ps msg pk
    -> M3e.Build.FilterChipSet.Builder pa ps msg pk
filterChip =
    unnamed_core