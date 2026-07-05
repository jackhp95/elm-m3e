module M3e.Build.ListOption.Slots exposing
    ( leadingIcon, leadingAvatar, trailingSwitch, trailingRadio, trailingIcon, trailingCheckbox
    , trailingAvatar
    )

{-|
Slot setters for `M3e.Build.ListOption`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs leadingIcon, leadingAvatar, trailingSwitch, trailingRadio, trailingIcon, trailingCheckbox
@docs trailingAvatar
-}


import M3e.Build.Avatar
import M3e.Build.Checkbox
import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Build.ListOption
import M3e.Build.Radio
import M3e.Build.Switch
import M3e.Node


leading_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.ListOption.Builder pa { ps
        | leading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ListOption.Builder pa { ps
        | leading : M3e.Build.Internal.Used
    } msg pk
leading_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


trailing_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.ListOption.Builder pa { ps
        | trailing : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ListOption.Builder pa { ps
        | trailing : M3e.Build.Internal.Used
    } msg pk
trailing_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `leading` slot of `ListOption`. -}
leadingIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.ListOption.Builder pa { ps
        | leading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ListOption.Builder pa { ps
        | leading : M3e.Build.Internal.Used
    } msg pk
leadingIcon =
    leading_core


{-| Place a `Avatar` in the `leading` slot of `ListOption`. -}
leadingAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.ListOption.Builder pa { ps
        | leading : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ListOption.Builder pa { ps
        | leading : M3e.Build.Internal.Used
    } msg pk
leadingAvatar =
    leading_core


{-| Place a `Switch` in the `trailing` slot of `ListOption`. -}
trailingSwitch :
    M3e.Build.Switch.Builder ca cs msg ck
    -> M3e.Build.ListOption.Builder pa { ps
        | trailing : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ListOption.Builder pa { ps
        | trailing : M3e.Build.Internal.Used
    } msg pk
trailingSwitch =
    trailing_core


{-| Place a `Radio` in the `trailing` slot of `ListOption`. -}
trailingRadio :
    M3e.Build.Radio.Builder ca cs msg ck
    -> M3e.Build.ListOption.Builder pa { ps
        | trailing : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ListOption.Builder pa { ps
        | trailing : M3e.Build.Internal.Used
    } msg pk
trailingRadio =
    trailing_core


{-| Place a `Icon` in the `trailing` slot of `ListOption`. -}
trailingIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.ListOption.Builder pa { ps
        | trailing : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ListOption.Builder pa { ps
        | trailing : M3e.Build.Internal.Used
    } msg pk
trailingIcon =
    trailing_core


{-| Place a `Checkbox` in the `trailing` slot of `ListOption`. -}
trailingCheckbox :
    M3e.Build.Checkbox.Builder ca cs msg ck
    -> M3e.Build.ListOption.Builder pa { ps
        | trailing : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ListOption.Builder pa { ps
        | trailing : M3e.Build.Internal.Used
    } msg pk
trailingCheckbox =
    trailing_core


{-| Place a `Avatar` in the `trailing` slot of `ListOption`. -}
trailingAvatar :
    M3e.Build.Avatar.Builder ca cs msg ck
    -> M3e.Build.ListOption.Builder pa { ps
        | trailing : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.ListOption.Builder pa { ps
        | trailing : M3e.Build.Internal.Used
    } msg pk
trailingAvatar =
    trailing_core