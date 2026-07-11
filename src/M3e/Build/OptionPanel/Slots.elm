module M3e.Build.OptionPanel.Slots exposing (divider, optgroup, option, loadingLoadingIndicator, noData)

{-| Slot setters for `M3e.Build.OptionPanel`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs divider, optgroup, option, loadingLoadingIndicator, noData

-}

import M3e.Build.Divider
import M3e.Build.Internal
import M3e.Build.LoadingIndicator
import M3e.Build.Optgroup
import M3e.Build.Option
import M3e.Build.OptionPanel
import M3e.Node


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.OptionPanel.Builder pa ps msg pk
    -> M3e.Build.OptionPanel.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


loading_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.OptionPanel.Builder pa ps msg pk
    -> M3e.Build.OptionPanel.Builder pa ps msg pk
loading_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Divider` in the `unnamed` slot of `OptionPanel`.
-}
divider :
    M3e.Build.Divider.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa ps msg pk
    -> M3e.Build.OptionPanel.Builder pa ps msg pk
divider =
    unnamed_core


{-| Place a `Optgroup` in the `unnamed` slot of `OptionPanel`.
-}
optgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa ps msg pk
    -> M3e.Build.OptionPanel.Builder pa ps msg pk
optgroup =
    unnamed_core


{-| Place a `Option` in the `unnamed` slot of `OptionPanel`.
-}
option :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa ps msg pk
    -> M3e.Build.OptionPanel.Builder pa ps msg pk
option =
    unnamed_core


{-| Place a `LoadingIndicator` in the `loading` slot of `OptionPanel`.
-}
loadingLoadingIndicator :
    M3e.Build.LoadingIndicator.Builder ca cs msg ck
    -> M3e.Build.OptionPanel.Builder pa ps msg pk
    -> M3e.Build.OptionPanel.Builder pa ps msg pk
loadingLoadingIndicator =
    loading_core


{-| Place any child in the `no-data` slot of `OptionPanel` (an arbitrary slot — accepts any component's Builder).
-}
noData :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.OptionPanel.Builder
            pa
            { ps
                | noData : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.OptionPanel.Builder
            pa
            { ps
                | noData : M3e.Build.Internal.Used
            }
            msg
            pk
noData child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
