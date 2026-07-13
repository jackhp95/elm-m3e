module M3e.Build.Tabs.Slots exposing (tab, panelTabPanel)

{-| Slot setters for `M3e.Build.Tabs`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs tab, panelTabPanel

-}

import M3e.Build.Internal
import M3e.Build.Tab
import M3e.Build.TabPanel
import M3e.Build.Tabs
import Markup.Node


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.Tabs.Builder pa ps msg pk
    -> M3e.Build.Tabs.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


panel_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.Tabs.Builder pa ps msg pk
    -> M3e.Build.Tabs.Builder pa ps msg pk
panel_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


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
