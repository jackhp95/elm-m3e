module M3e.Build.AppBar.Slots exposing
    ( leadingIcon, leadingIconButton, leadingButton, trailingSearchBar, trailingIconButton, trailingButton
    , leadingIconSlot, trailingIcon
    )

{-| Slot setters for `M3e.Build.AppBar`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs leadingIcon, leadingIconButton, leadingButton, trailingSearchBar, trailingIconButton, trailingButton
@docs leadingIconSlot, trailingIcon

-}

import M3e.Build.AppBar
import M3e.Build.Button
import M3e.Build.Icon
import M3e.Build.IconButton
import M3e.Build.Internal
import M3e.Build.SearchBar
import M3e.Node


leading_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.AppBar.Builder
            pa
            { ps
                | leading : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.AppBar.Builder
            pa
            { ps
                | leading : M3e.Build.Internal.Used
            }
            msg
            pk
leading_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


trailing_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.AppBar.Builder pa ps msg pk
    -> M3e.Build.AppBar.Builder pa ps msg pk
trailing_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `leading` slot of `AppBar`.
-}
leadingIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.AppBar.Builder
            pa
            { ps
                | leading : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.AppBar.Builder
            pa
            { ps
                | leading : M3e.Build.Internal.Used
            }
            msg
            pk
leadingIcon =
    leading_core


{-| Place a `IconButton` in the `leading` slot of `AppBar`.
-}
leadingIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    ->
        M3e.Build.AppBar.Builder
            pa
            { ps
                | leading : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.AppBar.Builder
            pa
            { ps
                | leading : M3e.Build.Internal.Used
            }
            msg
            pk
leadingIconButton =
    leading_core


{-| Place a `Button` in the `leading` slot of `AppBar`.
-}
leadingButton :
    M3e.Build.Button.Builder ca cs msg ck
    ->
        M3e.Build.AppBar.Builder
            pa
            { ps
                | leading : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.AppBar.Builder
            pa
            { ps
                | leading : M3e.Build.Internal.Used
            }
            msg
            pk
leadingButton =
    leading_core


{-| Place a `SearchBar` in the `trailing` slot of `AppBar`.
-}
trailingSearchBar :
    M3e.Build.SearchBar.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa ps msg pk
    -> M3e.Build.AppBar.Builder pa ps msg pk
trailingSearchBar =
    trailing_core


{-| Place a `IconButton` in the `trailing` slot of `AppBar`.
-}
trailingIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa ps msg pk
    -> M3e.Build.AppBar.Builder pa ps msg pk
trailingIconButton =
    trailing_core


{-| Place a `Button` in the `trailing` slot of `AppBar`.
-}
trailingButton :
    M3e.Build.Button.Builder ca cs msg ck
    -> M3e.Build.AppBar.Builder pa ps msg pk
    -> M3e.Build.AppBar.Builder pa ps msg pk
trailingButton =
    trailing_core


{-| Place any child in the `leading-icon` slot of `AppBar` (an arbitrary slot — accepts any component's Builder).
-}
leadingIconSlot :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.AppBar.Builder
            pa
            { ps
                | leadingIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.AppBar.Builder
            pa
            { ps
                | leadingIcon : M3e.Build.Internal.Used
            }
            msg
            pk
leadingIconSlot child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `trailing-icon` slot of `AppBar` (an arbitrary slot — accepts any component's Builder).
-}
trailingIcon :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.AppBar.Builder
            pa
            { ps
                | trailingIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.AppBar.Builder
            pa
            { ps
                | trailingIcon : M3e.Build.Internal.Used
            }
            msg
            pk
trailingIcon child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
