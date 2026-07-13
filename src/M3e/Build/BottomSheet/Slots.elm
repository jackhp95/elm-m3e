module M3e.Build.BottomSheet.Slots exposing (header, unnamed)

{-| Slot setters for `M3e.Build.BottomSheet`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs header, unnamed

-}

import M3e.Build.BottomSheet
import M3e.Build.Internal
import Markup.Node


{-| Place any child in the `header` slot of `BottomSheet` (an arbitrary slot — accepts any component's Builder).
-}
header :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.BottomSheet.Builder
            pa
            { ps
                | header : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.BottomSheet.Builder
            pa
            { ps
                | header : M3e.Build.Internal.Used
            }
            msg
            pk
header child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `unnamed` slot of `BottomSheet` (an arbitrary slot — accepts any component's Builder).
-}
unnamed :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.BottomSheet.Builder pa ps msg pk
    -> M3e.Build.BottomSheet.Builder pa ps msg pk
unnamed child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
