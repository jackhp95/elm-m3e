module M3e.Build.Button.Slots exposing (iconLoadingIndicator)

{-| Slot setters for `M3e.Build.Button`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs iconLoadingIndicator

-}

import M3e.Build.Button
import M3e.Build.Internal
import M3e.Build.LoadingIndicator
import Markup.Node


icon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.Button.Builder
            pa
            { ps
                | icon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Button.Builder
            pa
            { ps
                | icon : M3e.Build.Internal.Used
            }
            msg
            pk
icon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `LoadingIndicator` in the `icon` slot of `Button`.
-}
iconLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    ->
        M3e.Build.Button.Builder
            pa
            { ps
                | icon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Button.Builder
            pa
            { ps
                | icon : M3e.Build.Internal.Used
            }
            msg
            pk
iconLoadingIndicator =
    icon_core
