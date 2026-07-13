module M3e.Build.DialogAction.Slots exposing (unnamed)

{-| Slot setters for `M3e.Build.DialogAction`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs unnamed

-}

import M3e.Build.DialogAction
import M3e.Build.Internal
import Markup.Node


{-| Place any child in the `unnamed` slot of `DialogAction` (an arbitrary slot — accepts any component's Builder).
-}
unnamed :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.DialogAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.DialogAction.Builder
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
