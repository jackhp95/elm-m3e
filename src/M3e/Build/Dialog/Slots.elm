module M3e.Build.Dialog.Slots exposing (closeIconIcon, actions, unnamed)

{-| Slot setters for `M3e.Build.Dialog`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs closeIconIcon, actions, unnamed

-}

import M3e.Build.Dialog
import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Node


closeIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.Dialog.Builder
            pa
            { ps
                | closeIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Dialog.Builder
            pa
            { ps
                | closeIcon : M3e.Build.Internal.Used
            }
            msg
            pk
closeIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `close-icon` slot of `Dialog`.
-}
closeIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.Dialog.Builder
            pa
            { ps
                | closeIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Dialog.Builder
            pa
            { ps
                | closeIcon : M3e.Build.Internal.Used
            }
            msg
            pk
closeIconIcon =
    closeIcon_core


{-| Place any child in the `actions` slot of `Dialog` (an arbitrary slot — accepts any component's Builder).
-}
actions :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.Dialog.Builder
            pa
            { ps
                | actions : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Dialog.Builder
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


{-| Place any child in the `unnamed` slot of `Dialog` (an arbitrary slot — accepts any component's Builder).
-}
unnamed :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.Dialog.Builder pa ps msg pk
    -> M3e.Build.Dialog.Builder pa ps msg pk
unnamed child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
