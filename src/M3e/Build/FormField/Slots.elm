module M3e.Build.FormField.Slots exposing
    ( prefix, prefixText, label, suffix, suffixText, hint
    , error, unnamed
    )

{-| Slot setters for `M3e.Build.FormField`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs prefix, prefixText, label, suffix, suffixText, hint
@docs error, unnamed

-}

import M3e.Build.FormField
import M3e.Build.Internal
import Markup.Node


{-| Place any child in the `prefix` slot of `FormField` (an arbitrary slot — accepts any component's Builder).
-}
prefix :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.FormField.Builder
            pa
            { ps
                | prefix : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.FormField.Builder
            pa
            { ps
                | prefix : M3e.Build.Internal.Used
            }
            msg
            pk
prefix child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `prefix-text` slot of `FormField` (an arbitrary slot — accepts any component's Builder).
-}
prefixText :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.FormField.Builder
            pa
            { ps
                | prefixText : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.FormField.Builder
            pa
            { ps
                | prefixText : M3e.Build.Internal.Used
            }
            msg
            pk
prefixText child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `label` slot of `FormField` (an arbitrary slot — accepts any component's Builder).
-}
label :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.FormField.Builder
            pa
            { ps
                | label : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.FormField.Builder
            pa
            { ps
                | label : M3e.Build.Internal.Used
            }
            msg
            pk
label child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `suffix` slot of `FormField` (an arbitrary slot — accepts any component's Builder).
-}
suffix :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.FormField.Builder
            pa
            { ps
                | suffix : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.FormField.Builder
            pa
            { ps
                | suffix : M3e.Build.Internal.Used
            }
            msg
            pk
suffix child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `suffix-text` slot of `FormField` (an arbitrary slot — accepts any component's Builder).
-}
suffixText :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.FormField.Builder
            pa
            { ps
                | suffixText : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.FormField.Builder
            pa
            { ps
                | suffixText : M3e.Build.Internal.Used
            }
            msg
            pk
suffixText child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `hint` slot of `FormField` (an arbitrary slot — accepts any component's Builder).
-}
hint :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.FormField.Builder
            pa
            { ps
                | hint : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.FormField.Builder
            pa
            { ps
                | hint : M3e.Build.Internal.Used
            }
            msg
            pk
hint child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `error` slot of `FormField` (an arbitrary slot — accepts any component's Builder).
-}
error :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.FormField.Builder
            pa
            { ps
                | error : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.FormField.Builder
            pa
            { ps
                | error : M3e.Build.Internal.Used
            }
            msg
            pk
error child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `unnamed` slot of `FormField` (an arbitrary slot — accepts any component's Builder).
-}
unnamed :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.FormField.Builder pa ps msg pk
    -> M3e.Build.FormField.Builder pa ps msg pk
unnamed child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
