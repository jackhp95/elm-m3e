module M3e.Build.ExpandableListItem.Slots exposing (leadingIcon, leadingAvatar, toggleIconIcon, items)

{-| Slot setters for `M3e.Build.ExpandableListItem`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs leadingIcon, leadingAvatar, toggleIconIcon, items

-}

import M3e.Build.Avatar
import M3e.Build.ExpandableListItem
import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Node


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
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


toggleIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.ExpandableListItem.Builder
            pa
            { ps
                | toggleIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ExpandableListItem.Builder
            pa
            { ps
                | toggleIcon : M3e.Build.Internal.Used
            }
            msg
            pk
toggleIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `leading` slot of `ExpandableListItem`.
-}
leadingIcon :
    M3e.Build.Icon.Builder ca cs msg ck
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
leadingIcon =
    leading_core


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


{-| Place a `Icon` in the `toggle-icon` slot of `ExpandableListItem`.
-}
toggleIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.ExpandableListItem.Builder
            pa
            { ps
                | toggleIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ExpandableListItem.Builder
            pa
            { ps
                | toggleIcon : M3e.Build.Internal.Used
            }
            msg
            pk
toggleIconIcon =
    toggleIcon_core


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
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
