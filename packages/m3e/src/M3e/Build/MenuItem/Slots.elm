module M3e.Build.MenuItem.Slots exposing
    ( stepperReset, stepperPrevious, navRailToggle, menuTrigger, fabMenuTrigger, drawerToggle
    , dialogTrigger, dialogAction, datepickerToggle, richTooltipAction, bottomSheetTrigger, bottomSheetAction, iconIcon
    , trailingIconIcon
    )

{-|
Slot setters for `M3e.Build.MenuItem`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs stepperReset, stepperPrevious, navRailToggle, menuTrigger, fabMenuTrigger, drawerToggle
@docs dialogTrigger, dialogAction, datepickerToggle, richTooltipAction, bottomSheetTrigger, bottomSheetAction
@docs iconIcon, trailingIconIcon
-}


import M3e.Build.BottomSheetAction
import M3e.Build.BottomSheetTrigger
import M3e.Build.DatepickerToggle
import M3e.Build.DialogAction
import M3e.Build.DialogTrigger
import M3e.Build.DrawerToggle
import M3e.Build.FabMenuTrigger
import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Build.MenuItem
import M3e.Build.MenuTrigger
import M3e.Build.NavRailToggle
import M3e.Build.RichTooltipAction
import M3e.Build.StepperPrevious
import M3e.Build.StepperReset
import M3e.Node


default_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItem.Builder pa { ps
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
    -> M3e.Build.MenuItem.Builder pa { ps
        | icon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItem.Builder pa { ps
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
    -> M3e.Build.MenuItem.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItem.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `StepperReset` in the `unnamed` slot of `MenuItem`. -}
stepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
stepperReset =
    default_core


{-| Place a `StepperPrevious` in the `unnamed` slot of `MenuItem`. -}
stepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
stepperPrevious =
    default_core


{-| Place a `NavRailToggle` in the `unnamed` slot of `MenuItem`. -}
navRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
navRailToggle =
    default_core


{-| Place a `MenuTrigger` in the `unnamed` slot of `MenuItem`. -}
menuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
menuTrigger =
    default_core


{-| Place a `FabMenuTrigger` in the `unnamed` slot of `MenuItem`. -}
fabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
fabMenuTrigger =
    default_core


{-| Place a `DrawerToggle` in the `unnamed` slot of `MenuItem`. -}
drawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
drawerToggle =
    default_core


{-| Place a `DialogTrigger` in the `unnamed` slot of `MenuItem`. -}
dialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
dialogTrigger =
    default_core


{-| Place a `DialogAction` in the `unnamed` slot of `MenuItem`. -}
dialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
dialogAction =
    default_core


{-| Place a `DatepickerToggle` in the `unnamed` slot of `MenuItem`. -}
datepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
datepickerToggle =
    default_core


{-| Place a `RichTooltipAction` in the `unnamed` slot of `MenuItem`. -}
richTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
richTooltipAction =
    default_core


{-| Place a `BottomSheetTrigger` in the `unnamed` slot of `MenuItem`. -}
bottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
bottomSheetTrigger =
    default_core


{-| Place a `BottomSheetAction` in the `unnamed` slot of `MenuItem`. -}
bottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItem.Builder pa { ps
        | default : M3e.Build.Internal.Used
    } msg pk
bottomSheetAction =
    default_core


{-| Place a `Icon` in the `icon` slot of `MenuItem`. -}
iconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.MenuItem.Builder pa { ps
        | icon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItem.Builder pa { ps
        | icon : M3e.Build.Internal.Used
    } msg pk
iconIcon =
    icon_core


{-| Place a `Icon` in the `trailing-icon` slot of `MenuItem`. -}
trailingIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.MenuItem.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.MenuItem.Builder pa { ps
        | trailingIcon : M3e.Build.Internal.Used
    } msg pk
trailingIconIcon =
    trailingIcon_core