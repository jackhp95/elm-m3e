module M3e.Build.Tabs.Slots exposing (nextIconIcon, prevIconIcon, tab, panelTabPanel)

{-| Slot setters for `M3e.Build.Tabs`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs nextIconIcon, prevIconIcon, tab, panelTabPanel

-}

import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Build.Tab
import M3e.Build.TabPanel
import M3e.Build.Tabs
import M3e.Node


nextIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.Tabs.Builder
            pa
            { ps
                | nextIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Tabs.Builder
            pa
            { ps
                | nextIcon : M3e.Build.Internal.Used
            }
            msg
            pk
nextIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


prevIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.Tabs.Builder
            pa
            { ps
                | prevIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Tabs.Builder
            pa
            { ps
                | prevIcon : M3e.Build.Internal.Used
            }
            msg
            pk
prevIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.Tabs.Builder pa ps msg pk
    -> M3e.Build.Tabs.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


panel_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.Tabs.Builder pa ps msg pk
    -> M3e.Build.Tabs.Builder pa ps msg pk
panel_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `next-icon` slot of `Tabs`.
-}
nextIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.Tabs.Builder
            pa
            { ps
                | nextIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Tabs.Builder
            pa
            { ps
                | nextIcon : M3e.Build.Internal.Used
            }
            msg
            pk
nextIconIcon =
    nextIcon_core


{-| Place a `Icon` in the `prev-icon` slot of `Tabs`.
-}
prevIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.Tabs.Builder
            pa
            { ps
                | prevIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Tabs.Builder
            pa
            { ps
                | prevIcon : M3e.Build.Internal.Used
            }
            msg
            pk
prevIconIcon =
    prevIcon_core


{-| Place a `Tab` in the `unnamed` slot of `Tabs`.
-}
tab :
    M3e.Build.Tab.Builder ca cs msg ck
    -> M3e.Build.Tabs.Builder pa ps msg pk
    -> M3e.Build.Tabs.Builder pa ps msg pk
tab =
    unnamed_core


{-| Place a `TabPanel` in the `panel` slot of `Tabs`.
-}
panelTabPanel :
    M3e.Build.TabPanel.Builder ca cs msg ck
    -> M3e.Build.Tabs.Builder pa ps msg pk
    -> M3e.Build.Tabs.Builder pa ps msg pk
panelTabPanel =
    panel_core
