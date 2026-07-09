module M3e.Build.SlideGroup.Slots exposing ( nextIconIcon, prevIconIcon, unnamed )

{-|
Slot setters for `M3e.Build.SlideGroup`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs nextIconIcon, prevIconIcon, unnamed
-}


import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Build.SlideGroup
import M3e.Node


nextIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.SlideGroup.Builder pa { ps
        | nextIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SlideGroup.Builder pa { ps
        | nextIcon : M3e.Build.Internal.Used
    } msg pk
nextIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


prevIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.SlideGroup.Builder pa { ps
        | prevIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SlideGroup.Builder pa { ps
        | prevIcon : M3e.Build.Internal.Used
    } msg pk
prevIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `next-icon` slot of `SlideGroup`. -}
nextIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.SlideGroup.Builder pa { ps
        | nextIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SlideGroup.Builder pa { ps
        | nextIcon : M3e.Build.Internal.Used
    } msg pk
nextIconIcon =
    nextIcon_core


{-| Place a `Icon` in the `prev-icon` slot of `SlideGroup`. -}
prevIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.SlideGroup.Builder pa { ps
        | prevIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SlideGroup.Builder pa { ps
        | prevIcon : M3e.Build.Internal.Used
    } msg pk
prevIconIcon =
    prevIcon_core


{-| Place any child in the `unnamed` slot of `SlideGroup` (an arbitrary slot — accepts any component's Builder). -}
unnamed :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.SlideGroup.Builder pa ps msg pk
    -> M3e.Build.SlideGroup.Builder pa ps msg pk
unnamed child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )