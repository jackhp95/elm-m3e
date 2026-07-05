module M3e.Build.List.Slots exposing
    ( listOption, expandableListItem, listAction, listItem, divider
    )

{-|
Slot setters for `M3e.Build.List`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs listOption, expandableListItem, listAction, listItem, divider
-}


import M3e.Build.Divider
import M3e.Build.ExpandableListItem
import M3e.Build.Internal
import M3e.Build.List
import M3e.Build.ListAction
import M3e.Build.ListItem
import M3e.Build.ListOption
import M3e.Node


default_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.List.Builder pa ps msg pk
    -> M3e.Build.List.Builder pa ps msg pk
default_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `ListOption` in the `unnamed` slot of `List`. -}
listOption :
    M3e.Build.ListOption.Builder ca cs msg ck
    -> M3e.Build.List.Builder pa ps msg pk
    -> M3e.Build.List.Builder pa ps msg pk
listOption =
    default_core


{-| Place a `ExpandableListItem` in the `unnamed` slot of `List`. -}
expandableListItem :
    M3e.Build.ExpandableListItem.Builder ca cs msg ck
    -> M3e.Build.List.Builder pa ps msg pk
    -> M3e.Build.List.Builder pa ps msg pk
expandableListItem =
    default_core


{-| Place a `ListAction` in the `unnamed` slot of `List`. -}
listAction :
    M3e.Build.ListAction.Builder ca cs msg ck
    -> M3e.Build.List.Builder pa ps msg pk
    -> M3e.Build.List.Builder pa ps msg pk
listAction =
    default_core


{-| Place a `ListItem` in the `unnamed` slot of `List`. -}
listItem :
    M3e.Build.ListItem.Builder ca cs msg ck
    -> M3e.Build.List.Builder pa ps msg pk
    -> M3e.Build.List.Builder pa ps msg pk
listItem =
    default_core


{-| Place a `Divider` in the `unnamed` slot of `List`. -}
divider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.List.Builder pa ps msg pk
    -> M3e.Build.List.Builder pa ps msg pk
divider =
    default_core