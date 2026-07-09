module M3e.Build.IconButton.Slots exposing ( selectedIcon )

{-|
Slot setters for `M3e.Build.IconButton`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs selectedIcon
-}


import M3e.Build.Icon
import M3e.Build.IconButton
import M3e.Build.Internal
import M3e.Node


selected_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.IconButton.Builder pa { ps
        | selected : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.IconButton.Builder pa { ps
        | selected : M3e.Build.Internal.Used
    } msg pk
selected_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `selected` slot of `IconButton`. -}
selectedIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.IconButton.Builder pa { ps
        | selected : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.IconButton.Builder pa { ps
        | selected : M3e.Build.Internal.Used
    } msg pk
selectedIcon =
    selected_core