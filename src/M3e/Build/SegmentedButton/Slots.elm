module M3e.Build.SegmentedButton.Slots exposing (buttonSegment)

{-| Slot setters for `M3e.Build.SegmentedButton`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs buttonSegment

-}

import M3e.Build.ButtonSegment
import M3e.Build.Internal
import M3e.Build.SegmentedButton
import Markup.Node


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.SegmentedButton.Builder pa { ps | unnamed : filled } msg pk
    ->
        M3e.Build.SegmentedButton.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Filled
            }
            msg
            pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `ButtonSegment` in the `unnamed` slot of `SegmentedButton`.
-}
buttonSegment :
    M3e.Build.ButtonSegment.Builder ca cs msg ck
    -> M3e.Build.SegmentedButton.Builder pa { ps | unnamed : filled } msg pk
    ->
        M3e.Build.SegmentedButton.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Filled
            }
            msg
            pk
buttonSegment =
    unnamed_core
