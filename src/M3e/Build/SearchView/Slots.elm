module M3e.Build.SearchView.Slots exposing
    ( searchIconIcon, closeIconIcon, clearIconIcon, openLeadingIcon, openLeadingIconButton, openTrailingIcon
    , openTrailingIconButton, closedLeadingIcon, closedLeadingIconButton, closedTrailingIcon, closedTrailingIconButton, unnamed
    )

{-| Slot setters for `M3e.Build.SearchView`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs searchIconIcon, closeIconIcon, clearIconIcon, openLeadingIcon, openLeadingIconButton, openTrailingIcon
@docs openTrailingIconButton, closedLeadingIcon, closedLeadingIconButton, closedTrailingIcon, closedTrailingIconButton, unnamed

-}

import M3e.Build.Icon
import M3e.Build.IconButton
import M3e.Build.Internal
import M3e.Build.SearchView
import M3e.Node


searchIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.SearchView.Builder
            pa
            { ps
                | searchIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.SearchView.Builder
            pa
            { ps
                | searchIcon : M3e.Build.Internal.Used
            }
            msg
            pk
searchIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


closeIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.SearchView.Builder
            pa
            { ps
                | closeIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.SearchView.Builder
            pa
            { ps
                | closeIcon : M3e.Build.Internal.Used
            }
            msg
            pk
closeIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


clearIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.SearchView.Builder
            pa
            { ps
                | clearIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.SearchView.Builder
            pa
            { ps
                | clearIcon : M3e.Build.Internal.Used
            }
            msg
            pk
clearIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


openLeading_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
openLeading_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


openTrailing_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
openTrailing_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


closedLeading_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
closedLeading_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


closedTrailing_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
closedTrailing_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `search-icon` slot of `SearchView`.
-}
searchIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.SearchView.Builder
            pa
            { ps
                | searchIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.SearchView.Builder
            pa
            { ps
                | searchIcon : M3e.Build.Internal.Used
            }
            msg
            pk
searchIconIcon =
    searchIcon_core


{-| Place a `Icon` in the `close-icon` slot of `SearchView`.
-}
closeIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.SearchView.Builder
            pa
            { ps
                | closeIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.SearchView.Builder
            pa
            { ps
                | closeIcon : M3e.Build.Internal.Used
            }
            msg
            pk
closeIconIcon =
    closeIcon_core


{-| Place a `Icon` in the `clear-icon` slot of `SearchView`.
-}
clearIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.SearchView.Builder
            pa
            { ps
                | clearIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.SearchView.Builder
            pa
            { ps
                | clearIcon : M3e.Build.Internal.Used
            }
            msg
            pk
clearIconIcon =
    clearIcon_core


{-| Place a `Icon` in the `open-leading` slot of `SearchView`.
-}
openLeadingIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
openLeadingIcon =
    openLeading_core


{-| Place a `IconButton` in the `open-leading` slot of `SearchView`.
-}
openLeadingIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
openLeadingIconButton =
    openLeading_core


{-| Place a `Icon` in the `open-trailing` slot of `SearchView`.
-}
openTrailingIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
openTrailingIcon =
    openTrailing_core


{-| Place a `IconButton` in the `open-trailing` slot of `SearchView`.
-}
openTrailingIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
openTrailingIconButton =
    openTrailing_core


{-| Place a `Icon` in the `closed-leading` slot of `SearchView`.
-}
closedLeadingIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
closedLeadingIcon =
    closedLeading_core


{-| Place a `IconButton` in the `closed-leading` slot of `SearchView`.
-}
closedLeadingIconButton :
    M3e.Build.IconButton.Builder ca cs msg ck
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
closedLeadingIconButton =
    closedLeading_core


{-| Place a `Icon` in the `closed-trailing` slot of `SearchView`.
-}
closedTrailingIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.SearchView.Builder pa ps msg pk
    -> M3e.Build.SearchView.Builder pa ps msg pk
closedTrailingIcon =
    closedTrailing_core


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
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
