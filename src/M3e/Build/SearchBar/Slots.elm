module M3e.Build.SearchBar.Slots exposing
    ( clearIconIcon, leadingIcon, leadingIconButton, trailingIcon, trailingIconButton
    )

{-|
Slot setters for `M3e.Build.SearchBar`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs clearIconIcon, leadingIcon, leadingIconButton, trailingIcon, trailingIconButton
-}


import M3e.Build.Icon
import M3e.Build.IconButton
import M3e.Build.Internal
import M3e.Build.SearchBar
import M3e.Node


clearIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.SearchBar.Builder pa { ps
        | clearIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SearchBar.Builder pa { ps
        | clearIcon : M3e.Build.Internal.Used
    } msg pk
clearIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


leading_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.SearchBar.Builder pa ps msg pk
    -> M3e.Build.SearchBar.Builder pa ps msg pk
leading_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


trailing_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.SearchBar.Builder pa ps msg pk
    -> M3e.Build.SearchBar.Builder pa ps msg pk
trailing_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `clear-icon` slot of `SearchBar`. -}
clearIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.SearchBar.Builder pa { ps
        | clearIcon : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SearchBar.Builder pa { ps
        | clearIcon : M3e.Build.Internal.Used
    } msg pk
clearIconIcon =
    clearIcon_core


{-| Place a `Icon` in the `leading` slot of `SearchBar`. -}
leadingIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.SearchBar.Builder pa ps msg pk
    -> M3e.Build.SearchBar.Builder pa ps msg pk
leadingIcon =
    leading_core


{-| Place a `IconButton` in the `leading` slot of `SearchBar`. -}
leadingIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.SearchBar.Builder pa ps msg pk
    -> M3e.Build.SearchBar.Builder pa ps msg pk
leadingIconButton =
    leading_core


{-| Place a `Icon` in the `trailing` slot of `SearchBar`. -}
trailingIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.SearchBar.Builder pa ps msg pk
    -> M3e.Build.SearchBar.Builder pa ps msg pk
trailingIcon =
    trailing_core


{-| Place a `IconButton` in the `trailing` slot of `SearchBar`. -}
trailingIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.SearchBar.Builder pa ps msg pk
    -> M3e.Build.SearchBar.Builder pa ps msg pk
trailingIconButton =
    trailing_core