module M3e.Build.SearchView.Slots exposing (openLeadingIconButton, openTrailingIconButton, closedLeadingIconButton, closedTrailingIconButton, unnamed)

{-| Slot setters for `M3e.Build.SearchView`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs openLeadingIconButton, openTrailingIconButton, closedLeadingIconButton, closedTrailingIconButton, unnamed

-}

import M3e.Build.IconButton
import M3e.Build.Internal
import M3e.Build.SearchView
import Markup.Node


openLeading_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
openLeading_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


openTrailing_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
openTrailing_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


closedLeading_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
closedLeading_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


closedTrailing_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
closedTrailing_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `IconButton` in the `open-leading` slot of `SearchView`.
-}
openLeadingIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
openLeadingIconButton =
    openLeading_core


{-| Place a `IconButton` in the `open-trailing` slot of `SearchView`.
-}
openTrailingIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
openTrailingIconButton =
    openTrailing_core


{-| Place a `IconButton` in the `closed-leading` slot of `SearchView`.
-}
closedLeadingIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
closedLeadingIconButton =
    closedLeading_core


{-| Place a `IconButton` in the `closed-trailing` slot of `SearchView`.
-}
closedTrailingIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
closedTrailingIconButton =
    closedTrailing_core


{-| Place any child in the `unnamed` slot of `SearchView` (an arbitrary slot — accepts any component's Builder).
-}
unnamed :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
unnamed child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
