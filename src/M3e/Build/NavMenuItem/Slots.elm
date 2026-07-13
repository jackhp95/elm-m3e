module M3e.Build.NavMenuItem.Slots exposing (badgeBadge, navMenuItem)

{-| Slot setters for `M3e.Build.NavMenuItem`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs badgeBadge, navMenuItem

-}

import M3e.Build.Badge
import M3e.Build.Internal
import M3e.Build.NavMenuItem
import Markup.Node


badge_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.NavMenuItem.Builder
            pa
            { ps
                | badge : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.NavMenuItem.Builder
            pa
            { ps
                | badge : M3e.Build.Internal.Used
            }
            msg
            pk
badge_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.NavMenuItem.Builder pa ps msg pk
    -> M3e.Build.NavMenuItem.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Badge` in the `badge` slot of `NavMenuItem`.
-}
badgeBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    ->
        M3e.Build.NavMenuItem.Builder
            pa
            { ps
                | badge : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.NavMenuItem.Builder
            pa
            { ps
                | badge : M3e.Build.Internal.Used
            }
            msg
            pk
badgeBadge =
    badge_core


{-| Place a `NavMenuItem` in the `unnamed` slot of `NavMenuItem`.
-}
navMenuItem :
    M3e.Build.NavMenuItem.Builder ca cs msg ck
    -> M3e.Build.NavMenuItem.Builder pa ps msg pk
    -> M3e.Build.NavMenuItem.Builder pa ps msg pk
navMenuItem =
    unnamed_core
