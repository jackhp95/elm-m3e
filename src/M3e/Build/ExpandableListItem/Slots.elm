module M3e.Build.ExpandableListItem.Slots exposing (leadingAvatar, items)

{-| Slot setters for `M3e.Build.ExpandableListItem`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs leadingAvatar, items

-}

import M3e.Build.Avatar
import M3e.Build.ExpandableListItem
import M3e.Build.Internal
import Markup.Node


leading_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.ExpandableListItem.Builder
            pa
            { ps
                | leading : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ExpandableListItem.Builder
            pa
            { ps
                | leading : M3e.Build.Internal.Used
            }
            msg
            pk
leading_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Avatar` in the `leading` slot of `ExpandableListItem`.
-}
leadingAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    ->
        M3e.Build.ExpandableListItem.Builder
            pa
            { ps
                | leading : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ExpandableListItem.Builder
            pa
            { ps
                | leading : M3e.Build.Internal.Used
            }
            msg
            pk
leadingAvatar =
    leading_core


{-| Place any child in the `items` slot of `ExpandableListItem` (an arbitrary slot — accepts any component's Builder).
-}
items :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.ExpandableListItem.Builder
            pa
            { ps
                | items : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ExpandableListItem.Builder
            pa
            { ps
                | items : M3e.Build.Internal.Used
            }
            msg
            pk
items child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
