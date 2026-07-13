module M3e.Build.SelectionList.Slots exposing (listOption, expandableListItem, divider)

{-| Slot setters for `M3e.Build.SelectionList`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs listOption, expandableListItem, divider

-}

import M3e.Build.Divider
import M3e.Build.ExpandableListItem
import M3e.Build.Internal
import M3e.Build.ListOption
import M3e.Build.SelectionList
import Markup.Node


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.SelectionList.Builder pa ps msg pk
    -> M3e.Build.SelectionList.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `ListOption` in the `unnamed` slot of `SelectionList`.
-}
listOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.SelectionList.Builder pa ps msg pk
    -> M3e.Build.SelectionList.Builder pa ps msg pk
listOption =
    unnamed_core


{-| Place a `ExpandableListItem` in the `unnamed` slot of `SelectionList`.
-}
expandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.SelectionList.Builder pa ps msg pk
    -> M3e.Build.SelectionList.Builder pa ps msg pk
expandableListItem =
    unnamed_core


{-| Place a `Divider` in the `unnamed` slot of `SelectionList`.
-}
divider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.SelectionList.Builder pa ps msg pk
    -> M3e.Build.SelectionList.Builder pa ps msg pk
divider =
    unnamed_core
