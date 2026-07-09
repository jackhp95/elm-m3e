module M3e.Build.MenuItemRadio.Slots exposing ( iconIcon, trailingIconIcon )

{-|
Slot setters for `M3e.Build.MenuItemRadio`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs iconIcon, trailingIconIcon
-}


import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Build.MenuItemRadio
import M3e.Node


icon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.MenuItemRadio.Builder pa { ps
        | icon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItemRadio.Builder pa { ps
        | icon : M3e.Build.Internal.Used
    } msg pk
icon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


trailingIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.MenuItemRadio.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItemRadio.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `icon` slot of `MenuItemRadio`. -}
iconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.MenuItemRadio.Builder pa { ps
        | icon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItemRadio.Builder pa { ps
        | icon : M3e.Build.Internal.Used
    } msg pk
iconIcon =
    icon_core


{-| Place a `Icon` in the `trailing-icon` slot of `MenuItemRadio`. -}
trailingIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.MenuItemRadio.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItemRadio.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconIcon =
    trailingIcon_core