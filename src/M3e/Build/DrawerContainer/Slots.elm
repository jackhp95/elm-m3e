module M3e.Build.DrawerContainer.Slots exposing (unnamed, start, end)

{-| Slot setters for `M3e.Build.DrawerContainer`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs unnamed, start, end

-}

import M3e.Build.DrawerContainer
import M3e.Build.Internal
import Markup.Node


{-| Place any child in the `unnamed` slot of `DrawerContainer` (an arbitrary slot — accepts any component's Builder).
-}
unnamed :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.DrawerContainer.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.DrawerContainer.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Used
            }
            msg
            pk
unnamed child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `start` slot of `DrawerContainer` (an arbitrary slot — accepts any component's Builder).
-}
start :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.DrawerContainer.Builder
            pa
            { ps
                | start : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.DrawerContainer.Builder
            pa
            { ps
                | start : M3e.Build.Internal.Used
            }
            msg
            pk
start child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `end` slot of `DrawerContainer` (an arbitrary slot — accepts any component's Builder).
-}
end :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.DrawerContainer.Builder
            pa
            { ps
                | end : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.DrawerContainer.Builder
            pa
            { ps
                | end : M3e.Build.Internal.Used
            }
            msg
            pk
end child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
