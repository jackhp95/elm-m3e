module M3e.Build.BreadcrumbItem.Slots exposing ( icon, iconIcon )

{-|
Slot setters for `M3e.Build.BreadcrumbItem`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs icon, iconIcon
-}


import M3e.Build.BreadcrumbItem
import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Node


default_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.BreadcrumbItem.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.BreadcrumbItem.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
default_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


icon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.BreadcrumbItem.Builder pa { ps
        | icon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.BreadcrumbItem.Builder pa { ps
        | icon : M3e.Build.Internal.Used
    } msg pk
icon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `unnamed` slot of `BreadcrumbItem`. -}
icon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.BreadcrumbItem.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.BreadcrumbItem.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
icon =
    default_core


{-| Place a `Icon` in the `icon` slot of `BreadcrumbItem`. -}
iconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.BreadcrumbItem.Builder pa { ps
        | icon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.BreadcrumbItem.Builder pa { ps
        | icon : M3e.Build.Internal.Used
    } msg pk
iconIcon =
    icon_core