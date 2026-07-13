module M3e.Build.ListAction.Slots exposing
    ( stepperReset, stepperPrevious, navRailToggle, menuTrigger, fabMenuTrigger, drawerToggle
    , dialogTrigger, dialogAction, datepickerToggle, richTooltipAction, bottomSheetTrigger, bottomSheetAction
    , leadingAvatar, trailingSwitch, trailingRadio, trailingCheckbox, trailingAvatar
    )

{-| Slot setters for `M3e.Build.ListAction`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs stepperReset, stepperPrevious, navRailToggle, menuTrigger, fabMenuTrigger, drawerToggle
@docs dialogTrigger, dialogAction, datepickerToggle, richTooltipAction, bottomSheetTrigger, bottomSheetAction
@docs leadingAvatar, trailingSwitch, trailingRadio, trailingCheckbox, trailingAvatar

-}

import M3e.Build.Avatar
import M3e.Build.BottomSheetAction
import M3e.Build.BottomSheetTrigger
import M3e.Build.Checkbox
import M3e.Build.DatepickerToggle
import M3e.Build.DialogAction
import M3e.Build.DialogTrigger
import M3e.Build.DrawerToggle
import M3e.Build.FabMenuTrigger
import M3e.Build.Internal
import M3e.Build.ListAction
import M3e.Build.MenuTrigger
import M3e.Build.NavRailToggle
import M3e.Build.Radio
import M3e.Build.RichTooltipAction
import M3e.Build.StepperPrevious
import M3e.Build.StepperReset
import M3e.Build.Switch
import Markup.Node


unnamed_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Used
            }
            msg
            pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


leading_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | leading : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | leading : M3e.Build.Internal.Used
            }
            msg
            pk
leading_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


trailing_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | trailing : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | trailing : M3e.Build.Internal.Used
            }
            msg
            pk
trailing_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `StepperReset` in the `unnamed` slot of `ListAction`.
-}
stepperReset :
    M3e.Build.StepperReset.Builder ca cs msg ck
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Used
            }
            msg
            pk
stepperReset =
    unnamed_core


{-| Place a `StepperPrevious` in the `unnamed` slot of `ListAction`.
-}
stepperPrevious :
    M3e.Build.StepperPrevious.Builder ca cs msg ck
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Used
            }
            msg
            pk
stepperPrevious =
    unnamed_core


{-| Place a `NavRailToggle` in the `unnamed` slot of `ListAction`.
-}
navRailToggle :
    M3e.Build.NavRailToggle.Builder ca cs msg ck
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Used
            }
            msg
            pk
navRailToggle =
    unnamed_core


{-| Place a `MenuTrigger` in the `unnamed` slot of `ListAction`.
-}
menuTrigger :
    M3e.Build.MenuTrigger.Builder ca cs msg ck
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Used
            }
            msg
            pk
menuTrigger =
    unnamed_core


{-| Place a `FabMenuTrigger` in the `unnamed` slot of `ListAction`.
-}
fabMenuTrigger :
    M3e.Build.FabMenuTrigger.Builder ca cs msg ck
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Used
            }
            msg
            pk
fabMenuTrigger =
    unnamed_core


{-| Place a `DrawerToggle` in the `unnamed` slot of `ListAction`.
-}
drawerToggle :
    M3e.Build.DrawerToggle.Builder ca cs msg ck
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Used
            }
            msg
            pk
drawerToggle =
    unnamed_core


{-| Place a `DialogTrigger` in the `unnamed` slot of `ListAction`.
-}
dialogTrigger :
    M3e.Build.DialogTrigger.Builder ca cs msg ck
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Used
            }
            msg
            pk
dialogTrigger =
    unnamed_core


{-| Place a `DialogAction` in the `unnamed` slot of `ListAction`.
-}
dialogAction :
    M3e.Build.DialogAction.Builder ca cs msg ck
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Used
            }
            msg
            pk
dialogAction =
    unnamed_core


{-| Place a `DatepickerToggle` in the `unnamed` slot of `ListAction`.
-}
datepickerToggle :
    M3e.Build.DatepickerToggle.Builder ca cs msg ck
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Used
            }
            msg
            pk
datepickerToggle =
    unnamed_core


{-| Place a `RichTooltipAction` in the `unnamed` slot of `ListAction`.
-}
richTooltipAction :
    M3e.Build.RichTooltipAction.Builder ca cs msg ck
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Used
            }
            msg
            pk
richTooltipAction =
    unnamed_core


{-| Place a `BottomSheetTrigger` in the `unnamed` slot of `ListAction`.
-}
bottomSheetTrigger :
    M3e.Build.BottomSheetTrigger.Builder ca cs msg ck
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Used
            }
            msg
            pk
bottomSheetTrigger =
    unnamed_core


{-| Place a `BottomSheetAction` in the `unnamed` slot of `ListAction`.
-}
bottomSheetAction :
    M3e.Build.BottomSheetAction.Builder ca cs msg ck
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Used
            }
            msg
            pk
bottomSheetAction =
    unnamed_core


{-| Place a `Avatar` in the `leading` slot of `ListAction`.
-}
leadingAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | leading : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | leading : M3e.Build.Internal.Used
            }
            msg
            pk
leadingAvatar =
    leading_core


{-| Place a `Switch` in the `trailing` slot of `ListAction`.
-}
trailingSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | trailing : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | trailing : M3e.Build.Internal.Used
            }
            msg
            pk
trailingSwitch =
    trailing_core


{-| Place a `Radio` in the `trailing` slot of `ListAction`.
-}
trailingRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | trailing : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | trailing : M3e.Build.Internal.Used
            }
            msg
            pk
trailingRadio =
    trailing_core


{-| Place a `Checkbox` in the `trailing` slot of `ListAction`.
-}
trailingCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | trailing : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | trailing : M3e.Build.Internal.Used
            }
            msg
            pk
trailingCheckbox =
    trailing_core


{-| Place a `Avatar` in the `trailing` slot of `ListAction`.
-}
trailingAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | trailing : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.ListAction.Builder
            pa
            { ps
                | trailing : M3e.Build.Internal.Used
            }
            msg
            pk
trailingAvatar =
    trailing_core
