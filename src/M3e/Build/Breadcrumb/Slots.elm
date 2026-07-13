module M3e.Build.Breadcrumb.Slots exposing (breadcrumbItem, separator)

{-| Slot setters for `M3e.Build.Breadcrumb`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs breadcrumbItem, separator

-}

import M3e.Build.Breadcrumb
import M3e.Build.BreadcrumbItem
import M3e.Build.Internal
import Markup.Node


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.Breadcrumb.Builder pa { ps | unnamed : filled } msg pk
    ->
        M3e.Build.Breadcrumb.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Filled
            }
            msg
            pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `BreadcrumbItem` in the `unnamed` slot of `Breadcrumb`.
-}
breadcrumbItem :
    M3e.Build.BreadcrumbItem.Builder ca cs msg ck
    -> M3e.Build.Breadcrumb.Builder pa { ps | unnamed : filled } msg pk
    ->
        M3e.Build.Breadcrumb.Builder
            pa
            { ps
                | unnamed : M3e.Build.Internal.Filled
            }
            msg
            pk
breadcrumbItem =
    unnamed_core


{-| Place any child in the `separator` slot of `Breadcrumb` (an arbitrary slot — accepts any component's Builder).
-}
separator :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.Breadcrumb.Builder
            pa
            { ps
                | separator : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Breadcrumb.Builder
            pa
            { ps
                | separator : M3e.Build.Internal.Used
            }
            msg
            pk
separator child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
