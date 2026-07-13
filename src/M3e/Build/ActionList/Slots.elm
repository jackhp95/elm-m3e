module M3e.Build.ActionList.Slots exposing (expandableListItem, listAction, divider)

{-| Slot setters for `M3e.Build.ActionList`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs expandableListItem, listAction, divider

-}

import M3e.Build.ActionList
import M3e.Build.Divider
import M3e.Build.ExpandableListItem
import M3e.Build.Internal
import M3e.Build.ListAction
import Markup.Node


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.ActionList.Builder pa ps msg pk
    -> M3e.Build.ActionList.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `ExpandableListItem` in the `unnamed` slot of `ActionList`.
-}
expandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.ActionList.Builder pa ps msg pk
    -> M3e.Build.ActionList.Builder pa ps msg pk
expandableListItem =
    unnamed_core


{-| Place a `ListAction` in the `unnamed` slot of `ActionList`.
-}
listAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.ActionList.Builder pa ps msg pk
    -> M3e.Build.ActionList.Builder pa ps msg pk
listAction =
    unnamed_core


{-| Place a `Divider` in the `unnamed` slot of `ActionList`.
-}
divider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.ActionList.Builder pa ps msg pk
    -> M3e.Build.ActionList.Builder pa ps msg pk
divider =
    unnamed_core
