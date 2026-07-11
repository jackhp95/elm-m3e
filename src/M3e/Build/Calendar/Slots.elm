module M3e.Build.Calendar.Slots exposing (header)

{-| Slot setters for `M3e.Build.Calendar`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs header

-}

import M3e.Build.Calendar
import M3e.Build.Internal
import M3e.Node


{-| Place any child in the `header` slot of `Calendar` (an arbitrary slot — accepts any component's Builder).
-}
header :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.Calendar.Builder
            pa
            { ps
                | header : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Calendar.Builder
            pa
            { ps
                | header : M3e.Build.Internal.Used
            }
            msg
            pk
header child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
