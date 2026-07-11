module M3e.Build.StepPanel.Slots exposing (unnamed, actions)

{-| Slot setters for `M3e.Build.StepPanel`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs unnamed, actions

-}

import M3e.Build.Internal
import M3e.Build.StepPanel
import M3e.Node


{-| Place any child in the `unnamed` slot of `StepPanel` (an arbitrary slot — accepts any component's Builder).
-}
unnamed :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.StepPanel.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.StepPanel.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Used
            }
            msg
            pk
unnamed child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `actions` slot of `StepPanel` (an arbitrary slot — accepts any component's Builder).
-}
actions :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.StepPanel.Builder
            pa
            { ps
                | actions : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.StepPanel.Builder
            pa
            { ps
                | actions : M3e.Build.Internal.Used
            }
            msg
            pk
actions child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
