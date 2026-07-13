module M3e.Build.FloatingPanel.Slots exposing (unnamed)

{-| Slot setters for `M3e.Build.FloatingPanel`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs unnamed

-}

import M3e.Build.FloatingPanel
import M3e.Build.Internal
import Markup.Node


{-| Place any child in the `unnamed` slot of `FloatingPanel` (an arbitrary slot — accepts any component's Builder).
-}
unnamed :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
    -> M3e.Build.FloatingPanel.Builder pa ps msg pk
unnamed child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
