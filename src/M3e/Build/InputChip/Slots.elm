module M3e.Build.InputChip.Slots exposing (avatarAvatar)

{-| Slot setters for `M3e.Build.InputChip`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs avatarAvatar

-}

import M3e.Build.Avatar
import M3e.Build.InputChip
import M3e.Build.Internal
import Markup.Node


avatar_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.InputChip.Builder
            pa
            { ps
                | avatar : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.InputChip.Builder
            pa
            { ps
                | avatar : M3e.Build.Internal.Used
            }
            msg
            pk
avatar_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Avatar` in the `avatar` slot of `InputChip`.
-}
avatarAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    ->
        M3e.Build.InputChip.Builder
            pa
            { ps
                | avatar : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.InputChip.Builder
            pa
            { ps
                | avatar : M3e.Build.Internal.Used
            }
            msg
            pk
avatarAvatar =
    avatar_core
