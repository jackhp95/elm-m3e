module M3e.Build.BreadcrumbItemButton.Slots exposing ( iconIcon, icon )

{-|
Slot setters for `M3e.Build.BreadcrumbItemButton`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs iconIcon, icon
-}


import M3e.Build.BreadcrumbItemButton
import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Node


icon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.BreadcrumbItemButton.Builder pa { ps
        | icon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.BreadcrumbItemButton.Builder pa { ps
        | icon : M3e.Build.Internal.Used
    } msg pk
icon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


default_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.BreadcrumbItemButton.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.BreadcrumbItemButton.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
default_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `icon` slot of `BreadcrumbItemButton`. -}
iconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.BreadcrumbItemButton.Builder pa { ps
        | icon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.BreadcrumbItemButton.Builder pa { ps
        | icon : M3e.Build.Internal.Used
    } msg pk
iconIcon =
    icon_core


{-| Place a `Icon` in the `unnamed` slot of `BreadcrumbItemButton`. -}
icon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.BreadcrumbItemButton.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.BreadcrumbItemButton.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
icon =
    default_core