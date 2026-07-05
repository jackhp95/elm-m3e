module M3e.Build.ButtonSegment.Slots exposing ( iconIcon )

{-|
Slot setters for `M3e.Build.ButtonSegment`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs iconIcon
-}


import M3e.Build.ButtonSegment
import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Node


icon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.ButtonSegment.Builder pa { ps
        | icon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ButtonSegment.Builder pa { ps
        | icon : M3e.Build.Internal.Used
    } msg pk
icon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `icon` slot of `ButtonSegment`. -}
iconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.ButtonSegment.Builder pa { ps
        | icon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ButtonSegment.Builder pa { ps
        | icon : M3e.Build.Internal.Used
    } msg pk
iconIcon =
    icon_core