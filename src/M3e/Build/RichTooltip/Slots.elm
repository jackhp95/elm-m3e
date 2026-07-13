module M3e.Build.RichTooltip.Slots exposing (actions)

{-| Slot setters for `M3e.Build.RichTooltip`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs actions

-}

import M3e.Build.Internal
import M3e.Build.RichTooltip
import Markup.Node


{-| Place any child in the `actions` slot of `RichTooltip` (an arbitrary slot — accepts any component's Builder).
-}
actions :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.RichTooltip.Builder
            pa
            { ps
                | actions : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.RichTooltip.Builder
            pa
            { ps
                | actions : M3e.Build.Internal.Used
            }
            msg
            pk
actions child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
