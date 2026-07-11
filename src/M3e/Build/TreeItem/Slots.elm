module M3e.Build.TreeItem.Slots exposing (iconIcon, selectedIconIcon, toggleIconIcon, openToggleIconIcon, treeItem)

{-| Slot setters for `M3e.Build.TreeItem`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs iconIcon, selectedIconIcon, toggleIconIcon, openToggleIconIcon, treeItem

-}

import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Build.TreeItem
import M3e.Node


icon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.TreeItem.Builder
            pa
            { ps
                | icon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.TreeItem.Builder
            pa
            { ps
                | icon : M3e.Build.Internal.Used
            }
            msg
            pk
icon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


selectedIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.TreeItem.Builder
            pa
            { ps
                | selectedIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.TreeItem.Builder
            pa
            { ps
                | selectedIcon : M3e.Build.Internal.Used
            }
            msg
            pk
selectedIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


toggleIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.TreeItem.Builder
            pa
            { ps
                | toggleIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.TreeItem.Builder
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


openToggleIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.TreeItem.Builder
            pa
            { ps
                | openToggleIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.TreeItem.Builder
            pa
            { ps
                | openToggleIcon : M3e.Build.Internal.Used
            }
            msg
            pk
openToggleIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.TreeItem.Builder pa ps msg pk
    -> M3e.Build.TreeItem.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `icon` slot of `TreeItem`.
-}
iconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.TreeItem.Builder
            pa
            { ps
                | icon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.TreeItem.Builder
            pa
            { ps
                | icon : M3e.Build.Internal.Used
            }
            msg
            pk
iconIcon =
    icon_core


{-| Place a `Icon` in the `selected-icon` slot of `TreeItem`.
-}
selectedIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.TreeItem.Builder
            pa
            { ps
                | selectedIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.TreeItem.Builder
            pa
            { ps
                | selectedIcon : M3e.Build.Internal.Used
            }
            msg
            pk
selectedIconIcon =
    selectedIcon_core


{-| Place a `Icon` in the `toggle-icon` slot of `TreeItem`.
-}
toggleIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.TreeItem.Builder
            pa
            { ps
                | toggleIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.TreeItem.Builder
            pa
            { ps
                | toggleIcon : M3e.Build.Internal.Used
            }
            msg
            pk
toggleIconIcon =
    toggleIcon_core


{-| Place a `Icon` in the `open-toggle-icon` slot of `TreeItem`.
-}
openToggleIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.TreeItem.Builder
            pa
            { ps
                | openToggleIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.TreeItem.Builder
            pa
            { ps
                | openToggleIcon : M3e.Build.Internal.Used
            }
            msg
            pk
openToggleIconIcon =
    openToggleIcon_core


{-| Place a `TreeItem` in the `unnamed` slot of `TreeItem`.
-}
treeItem :
    M3e.Build.TreeItem.Builder ca cs msg ck
    -> M3e.Build.TreeItem.Builder pa ps msg pk
    -> M3e.Build.TreeItem.Builder pa ps msg pk
treeItem =
    unnamed_core
