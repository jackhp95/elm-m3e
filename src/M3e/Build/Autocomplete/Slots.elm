module M3e.Build.Autocomplete.Slots exposing (optgroup, option, loading, noData)

{-| Slot setters for `M3e.Build.Autocomplete`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs optgroup, option, loading, noData

-}

import M3e.Build.Autocomplete
import M3e.Build.Internal
import M3e.Build.Optgroup
import M3e.Build.Option
import Markup.Node


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.Autocomplete.Builder pa ps msg pk
    -> M3e.Build.Autocomplete.Builder pa ps msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Optgroup` in the `unnamed` slot of `Autocomplete`.
-}
optgroup :
    M3e.Build.Optgroup.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa ps msg pk
    -> M3e.Build.Autocomplete.Builder pa ps msg pk
optgroup =
    unnamed_core


{-| Place a `Option` in the `unnamed` slot of `Autocomplete`.
-}
option :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.Autocomplete.Builder pa ps msg pk
    -> M3e.Build.Autocomplete.Builder pa ps msg pk
option =
    unnamed_core


{-| Place any child in the `loading` slot of `Autocomplete` (an arbitrary slot — accepts any component's Builder).
-}
loading :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.Autocomplete.Builder
            pa
            { ps
                | loading : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Autocomplete.Builder
            pa
            { ps
                | loading : M3e.Build.Internal.Used
            }
            msg
            pk
loading child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `no-data` slot of `Autocomplete` (an arbitrary slot — accepts any component's Builder).
-}
noData :
    M3e.Build.Internal.Builder ck ca cs msg
    ->
        M3e.Build.Autocomplete.Builder
            pa
            { ps
                | noData : M3e.Build.Internal.Available
            }
            msg
            pk
    ->
        M3e.Build.Autocomplete.Builder
            pa
            { ps
                | noData : M3e.Build.Internal.Used
            }
            msg
            pk
noData child_ parent_ =
    M3e.Build.Internal.wrap_
        (Markup.Node.addChild
            (M3e.Build.Internal.node_ child_)
            (M3e.Build.Internal.node_ parent_)
        )
