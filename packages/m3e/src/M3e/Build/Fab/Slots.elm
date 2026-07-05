module M3e.Build.Fab.Slots exposing ( closeIconIcon )

{-|
Slot setters for `M3e.Build.Fab`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs closeIconIcon
-}


import M3e.Build.Fab
import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Node


closeIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Fab.Builder pa { ps
        | closeIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Fab.Builder pa { ps
        | closeIcon : M3e.Build.Internal.Used
    } msg pk
closeIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `close-icon` slot of `Fab`. -}
closeIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Fab.Builder pa { ps
        | closeIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Fab.Builder pa { ps
        | closeIcon : M3e.Build.Internal.Used
    } msg pk
closeIconIcon =
    closeIcon_core