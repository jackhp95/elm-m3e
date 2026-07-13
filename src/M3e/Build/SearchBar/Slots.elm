module M3e.Build.SearchBar.Slots exposing (leadingIconButton, trailingIconButton)

{-| Slot setters for `M3e.Build.SearchBar`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs leadingIconButton, trailingIconButton

-}

import M3e.Build.IconButton
import M3e.Build.Internal
import M3e.Build.SearchBar
import Markup.Node


leading_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.SearchBar.Builder pa ps msg pk
    -> M3e.Build.SearchBar.Builder pa ps msg pk
leading_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


trailing_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.SearchBar.Builder pa ps msg pk
    -> M3e.Build.SearchBar.Builder pa ps msg pk
trailing_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `IconButton` in the `leading` slot of `SearchBar`.
-}
leadingIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.SearchBar.Builder pa ps msg pk
    -> M3e.Build.SearchBar.Builder pa ps msg pk
leadingIconButton =
    leading_core


{-| Place a `IconButton` in the `trailing` slot of `SearchBar`.
-}
trailingIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.SearchBar.Builder pa ps msg pk
    -> M3e.Build.SearchBar.Builder pa ps msg pk
trailingIconButton =
    trailing_core
