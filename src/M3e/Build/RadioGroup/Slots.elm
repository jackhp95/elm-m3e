module M3e.Build.RadioGroup.Slots exposing (unnamed)

{-| Slot setters for `M3e.Build.RadioGroup`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs unnamed

-}

import M3e.Build.Internal
import M3e.Build.RadioGroup
import M3e.Node


{-| Place any child in the `unnamed` slot of `RadioGroup` (an arbitrary slot — accepts any component's Builder).
-}
unnamed :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.RadioGroup.Builder pa { ps | unnamed : filled } msg pk
    ->
        M3e.Build.RadioGroup.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Filled
            }
            msg
            pk
unnamed child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
