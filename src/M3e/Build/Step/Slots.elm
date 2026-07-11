module M3e.Build.Step.Slots exposing (iconIcon, doneIconIcon, editIconIcon, errorIconIcon)

{-| Slot setters for `M3e.Build.Step`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs iconIcon, doneIconIcon, editIconIcon, errorIconIcon

-}

import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Build.Step
import M3e.Node


icon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.Step.Builder
            pa
            { ps
                | icon : M3e.Build.Internal.Available
            }
            msg
            pk
    -> M3e.Build.Step.Builder pa { ps | icon : M3e.Build.Internal.Used } msg pk
icon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


doneIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.Step.Builder
            pa
            { ps
                | doneIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Step.Builder
            pa
            { ps
                | doneIcon : M3e.Build.Internal.Used
            }
            msg
            pk
doneIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


editIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.Step.Builder
            pa
            { ps
                | editIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Step.Builder
            pa
            { ps
                | editIcon : M3e.Build.Internal.Used
            }
            msg
            pk
editIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


errorIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.Step.Builder
            pa
            { ps
                | errorIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Step.Builder
            pa
            { ps
                | errorIcon : M3e.Build.Internal.Used
            }
            msg
            pk
errorIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `icon` slot of `Step`.
-}
iconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.Step.Builder
            pa
            { ps
                | icon : M3e.Build.Internal.Available
            }
            msg
            pk
    -> M3e.Build.Step.Builder pa { ps | icon : M3e.Build.Internal.Used } msg pk
iconIcon =
    icon_core


{-| Place a `Icon` in the `done-icon` slot of `Step`.
-}
doneIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.Step.Builder
            pa
            { ps
                | doneIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Step.Builder
            pa
            { ps
                | doneIcon : M3e.Build.Internal.Used
            }
            msg
            pk
doneIconIcon =
    doneIcon_core


{-| Place a `Icon` in the `edit-icon` slot of `Step`.
-}
editIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.Step.Builder
            pa
            { ps
                | editIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Step.Builder
            pa
            { ps
                | editIcon : M3e.Build.Internal.Used
            }
            msg
            pk
editIconIcon =
    editIcon_core


{-| Place a `Icon` in the `error-icon` slot of `Step`.
-}
errorIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.Step.Builder
            pa
            { ps
                | errorIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Step.Builder
            pa
            { ps
                | errorIcon : M3e.Build.Internal.Used
            }
            msg
            pk
errorIconIcon =
    errorIcon_core
