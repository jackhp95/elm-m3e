module M3e.Build.ExpansionPanel.Slots exposing (toggleIconIcon, unnamed, actions)

{-| Slot setters for `M3e.Build.ExpansionPanel`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs toggleIconIcon, unnamed, actions

-}

import M3e.Build.ExpansionPanel
import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Node


toggleIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.ExpansionPanel.Builder
            pa
            { ps
                | toggleIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ExpansionPanel.Builder
            pa
            { ps
                | toggleIcon : M3e.Build.Internal.Used
            }
            msg
            pk
toggleIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `toggle-icon` slot of `ExpansionPanel`.
-}
toggleIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.ExpansionPanel.Builder
            pa
            { ps
                | toggleIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ExpansionPanel.Builder
            pa
            { ps
                | toggleIcon : M3e.Build.Internal.Used
            }
            msg
            pk
toggleIconIcon =
    toggleIcon_core


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
        (M3e.Node.addChild
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
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
