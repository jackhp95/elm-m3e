module M3e.Build.Tree.Slots exposing (treeItem)

{-| Slot setters for `M3e.Build.Tree`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs treeItem

-}

import M3e.Build.Internal
import M3e.Build.Tree
import M3e.Build.TreeItem
import Markup.Node


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.Tree.Builder pa ps msg pk
    -> M3e.Build.Tree.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `TreeItem` in the `unnamed` slot of `Tree`.
-}
treeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.Tree.Builder pa ps msg pk
    -> M3e.Build.Tree.Builder pa ps msg pk
treeItem =
    unnamed_core
