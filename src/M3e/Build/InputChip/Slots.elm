module M3e.Build.InputChip.Slots exposing (avatarAvatar, iconIcon, removeIconIcon)

{-| Slot setters for `M3e.Build.InputChip`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs avatarAvatar, iconIcon, removeIconIcon

-}

import M3e.Build.Avatar
import M3e.Build.Icon
import M3e.Build.InputChip
import M3e.Build.Internal
import M3e.Node


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
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


icon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.InputChip.Builder
            pa
            { ps
                | icon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.InputChip.Builder
            pa
            { ps
                | icon : M3e.Build.Internal.Used
            }
            msg
            pk
icon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


removeIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.InputChip.Builder
            pa
            { ps
                | removeIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.InputChip.Builder
            pa
            { ps
                | removeIcon : M3e.Build.Internal.Used
            }
            msg
            pk
removeIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
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


{-| Place a `Icon` in the `icon` slot of `InputChip`.
-}
iconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.InputChip.Builder
            pa
            { ps
                | icon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.InputChip.Builder
            pa
            { ps
                | icon : M3e.Build.Internal.Used
            }
            msg
            pk
iconIcon =
    icon_core


{-| Place a `Icon` in the `remove-icon` slot of `InputChip`.
-}
removeIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.InputChip.Builder
            pa
            { ps
                | removeIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.InputChip.Builder
            pa
            { ps
                | removeIcon : M3e.Build.Internal.Used
            }
            msg
            pk
removeIconIcon =
    removeIcon_core
