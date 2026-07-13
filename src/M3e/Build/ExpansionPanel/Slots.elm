module M3e.Build.ExpansionPanel.Slots exposing (unnamed, actions)

{-| Slot setters for `M3e.Build.ExpansionPanel`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs unnamed, actions

-}

import M3e.Build.ExpansionPanel
import M3e.Build.Internal
import Markup.Node


{-| Place any child in the `unnamed` slot of `ExpansionPanel` (an arbitrary slot — accepts any component's Builder).
-}
unnamed :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.ExpansionPanel.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ExpansionPanel.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Used
            }
            msg
            pk
unnamed child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `actions` slot of `ExpansionPanel` (an arbitrary slot — accepts any component's Builder).
-}
actions :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
    -> M3e.Build.ExpansionPanel.Builder pa ps msg pk
actions child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
