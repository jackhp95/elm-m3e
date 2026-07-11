module M3e.Build.Paginator.Slots exposing (firstPageIconIcon, previousPageIconIcon, nextPageIconIcon, lastPageIconIcon)

{-| Slot setters for `M3e.Build.Paginator`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs firstPageIconIcon, previousPageIconIcon, nextPageIconIcon, lastPageIconIcon

-}

import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Build.Paginator
import M3e.Node


firstPageIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.Paginator.Builder
            pa
            { ps
                | firstPageIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Paginator.Builder
            pa
            { ps
                | firstPageIcon : M3e.Build.Internal.Used
            }
            msg
            pk
firstPageIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


previousPageIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.Paginator.Builder
            pa
            { ps
                | previousPageIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Paginator.Builder
            pa
            { ps
                | previousPageIcon : M3e.Build.Internal.Used
            }
            msg
            pk
previousPageIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


nextPageIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.Paginator.Builder
            pa
            { ps
                | nextPageIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Paginator.Builder
            pa
            { ps
                | nextPageIcon : M3e.Build.Internal.Used
            }
            msg
            pk
nextPageIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


lastPageIcon_core :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.Paginator.Builder
            pa
            { ps
                | lastPageIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Paginator.Builder
            pa
            { ps
                | lastPageIcon : M3e.Build.Internal.Used
            }
            msg
            pk
lastPageIcon_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `first-page-icon` slot of `Paginator`.
-}
firstPageIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.Paginator.Builder
            pa
            { ps
                | firstPageIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Paginator.Builder
            pa
            { ps
                | firstPageIcon : M3e.Build.Internal.Used
            }
            msg
            pk
firstPageIconIcon =
    firstPageIcon_core


{-| Place a `Icon` in the `previous-page-icon` slot of `Paginator`.
-}
previousPageIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.Paginator.Builder
            pa
            { ps
                | previousPageIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Paginator.Builder
            pa
            { ps
                | previousPageIcon : M3e.Build.Internal.Used
            }
            msg
            pk
previousPageIconIcon =
    previousPageIcon_core


{-| Place a `Icon` in the `next-page-icon` slot of `Paginator`.
-}
nextPageIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.Paginator.Builder
            pa
            { ps
                | nextPageIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Paginator.Builder
            pa
            { ps
                | nextPageIcon : M3e.Build.Internal.Used
            }
            msg
            pk
nextPageIconIcon =
    nextPageIcon_core


{-| Place a `Icon` in the `last-page-icon` slot of `Paginator`.
-}
lastPageIconIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    ->
        M3e.Build.Paginator.Builder
            pa
            { ps
                | lastPageIcon : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Paginator.Builder
            pa
            { ps
                | lastPageIcon : M3e.Build.Internal.Used
            }
            msg
            pk
lastPageIconIcon =
    lastPageIcon_core
