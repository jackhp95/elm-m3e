module M3e.Build.Button.Slots exposing
    ( iconLoadingIndicator, iconIcon, selectedIcon, selectedIconIcon, trailingIconIcon
    )

{-|
Slot setters for `M3e.Build.Button`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs iconLoadingIndicator, iconIcon, selectedIcon, selectedIconIcon, trailingIconIcon
-}


import M3e.Build.Button
import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Build.LoadingIndicator
import M3e.Node


icon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Button.Builder pa { ps
        | icon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Button.Builder pa { ps
        | icon : M3e.Build.Internal.Used
    } msg pk
icon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


selected_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Button.Builder pa { ps
        | selected : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Button.Builder pa { ps
        | selected : M3e.Build.Internal.Used
    } msg pk
selected_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


selectedIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Button.Builder pa { ps
        | selectedIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Button.Builder pa { ps
        | selectedIcon : M3e.Build.Internal.Used
    } msg pk
selectedIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


trailingIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Button.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Button.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `LoadingIndicator` in the `icon` slot of `Button`. -}
iconLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.Button.Builder pa { ps
        | icon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Button.Builder pa { ps
        | icon : M3e.Build.Internal.Used
    } msg pk
iconLoadingIndicator =
    icon_core


{-| Place a `Icon` in the `icon` slot of `Button`. -}
iconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Button.Builder pa { ps
        | icon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Button.Builder pa { ps
        | icon : M3e.Build.Internal.Used
    } msg pk
iconIcon =
    icon_core


{-| Place a `Icon` in the `selected` slot of `Button`. -}
selectedIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Button.Builder pa { ps
        | selected : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Button.Builder pa { ps
        | selected : M3e.Build.Internal.Used
    } msg pk
selectedIcon =
    selected_core


{-| Place a `Icon` in the `selected-icon` slot of `Button`. -}
selectedIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Button.Builder pa { ps
        | selectedIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Button.Builder pa { ps
        | selectedIcon : M3e.Build.Internal.Used
    } msg pk
selectedIconIcon =
    selectedIcon_core


{-| Place a `Icon` in the `trailing-icon` slot of `Button`. -}
trailingIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Button.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Button.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconIcon =
    trailingIcon_core