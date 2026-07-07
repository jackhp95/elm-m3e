module M3e.Build.StepperPrevious.Slots exposing ( unnamed )

{-|
Slot setters for `M3e.Build.StepperPrevious`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs unnamed
-}


import M3e.Build.Internal
import M3e.Build.StepperPrevious
import M3e.Node


{-| Place any child in the `unnamed` slot of `StepperPrevious` (an arbitrary slot — accepts any component's Builder). -}
unnamed :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.StepperPrevious.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.StepperPrevious.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
unnamed child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )