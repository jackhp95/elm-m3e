module M3e.Build.ExpansionHeader.Slots exposing ( toggleIconIcon )

{-|
Slot setters for `M3e.Build.ExpansionHeader`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs toggleIconIcon
-}


import M3e.Build.ExpansionHeader
import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Node


toggleIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.ExpansionHeader.Builder pa { ps
        | toggleIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionHeader.Builder pa { ps
        | toggleIcon : M3e.Build.Internal.Used
    } msg pk
toggleIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `toggle-icon` slot of `ExpansionHeader`. -}
toggleIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.ExpansionHeader.Builder pa { ps
        | toggleIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ExpansionHeader.Builder pa { ps
        | toggleIcon : M3e.Build.Internal.Used
    } msg pk
toggleIconIcon =
    toggleIcon_core