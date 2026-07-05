module M3e.Build.NavMenuItem.Slots exposing ( iconIcon, badgeBadge, selectedIconIcon, toggleIconIcon )

{-|
Slot setters for `M3e.Build.NavMenuItem`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs iconIcon, badgeBadge, selectedIconIcon, toggleIconIcon
-}


import M3e.Build.Badge
import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Build.NavMenuItem
import M3e.Node


icon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.NavMenuItem.Builder pa { ps
        | icon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.NavMenuItem.Builder pa { ps
        | icon : M3e.Build.Internal.Used
    } msg pk
icon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


badge_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.NavMenuItem.Builder pa { ps
        | badge : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.NavMenuItem.Builder pa { ps
        | badge : M3e.Build.Internal.Used
    } msg pk
badge_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


selectedIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.NavMenuItem.Builder pa { ps
        | selectedIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.NavMenuItem.Builder pa { ps
        | selectedIcon : M3e.Build.Internal.Used
    } msg pk
selectedIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


toggleIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.NavMenuItem.Builder pa { ps
        | toggleIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.NavMenuItem.Builder pa { ps
        | toggleIcon : M3e.Build.Internal.Used
    } msg pk
toggleIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `icon` slot of `NavMenuItem`. -}
iconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.NavMenuItem.Builder pa { ps
        | icon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.NavMenuItem.Builder pa { ps
        | icon : M3e.Build.Internal.Used
    } msg pk
iconIcon =
    icon_core


{-| Place a `Badge` in the `badge` slot of `NavMenuItem`. -}
badgeBadge :
    M3e.Build.Badge.Builder ca cs msg ck
    -> M3e.Build.NavMenuItem.Builder pa { ps
        | badge : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.NavMenuItem.Builder pa { ps
        | badge : M3e.Build.Internal.Used
    } msg pk
badgeBadge =
    badge_core


{-| Place a `Icon` in the `selected-icon` slot of `NavMenuItem`. -}
selectedIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.NavMenuItem.Builder pa { ps
        | selectedIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.NavMenuItem.Builder pa { ps
        | selectedIcon : M3e.Build.Internal.Used
    } msg pk
selectedIconIcon =
    selectedIcon_core


{-| Place a `Icon` in the `toggle-icon` slot of `NavMenuItem`. -}
toggleIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.NavMenuItem.Builder pa { ps
        | toggleIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.NavMenuItem.Builder pa { ps
        | toggleIcon : M3e.Build.Internal.Used
    } msg pk
toggleIconIcon =
    toggleIcon_core