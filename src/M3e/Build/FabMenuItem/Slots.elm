module M3e.Build.FabMenuItem.Slots exposing (iconIcon, unnamed)

{-| Slot setters for `M3e.Build.FabMenuItem`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs iconIcon, unnamed

-}

import M3e.Build.FabMenuItem
import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Node


icon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.FabMenuItem.Builder
            pa
            { ps
                | icon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.FabMenuItem.Builder
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


{-| Place a `Icon` in the `icon` slot of `FabMenuItem`.
-}
iconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.FabMenuItem.Builder
            pa
            { ps
                | icon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.FabMenuItem.Builder
            pa
            { ps
                | icon : M3e.Build.Internal.Used
            }
            msg
            pk
iconIcon =
    icon_core


{-| Place any child in the `unnamed` slot of `FabMenuItem` (an arbitrary slot — accepts any component's Builder).
-}
unnamed :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.FabMenuItem.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.FabMenuItem.Builder
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
