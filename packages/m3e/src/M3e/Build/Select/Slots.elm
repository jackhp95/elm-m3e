module M3e.Build.Select.Slots exposing ( arrowIcon, option, value )

{-|
Slot setters for `M3e.Build.Select`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs arrowIcon, option, value
-}


import M3e.Build.Icon
import M3e.Build.Internal
import M3e.Build.Option
import M3e.Build.Select
import M3e.Node


arrow_core :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Select.Builder pa { ps
        | arrow : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | arrow : M3e.Build.Internal.Used
    } msg pk
arrow_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


unnamed_core :
    M3e.Build.Internal.Builder anyK anyA anyS msg
    -> M3e.Build.Select.Builder pa { ps | unnamed : filled } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | unnamed : M3e.Build.Internal.Filled
    } msg pk
unnamed_core child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place a `Icon` in the `arrow` slot of `Select`. -}
arrowIcon :
    M3e.Build.Icon.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps
        | arrow : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | arrow : M3e.Build.Internal.Used
    } msg pk
arrowIcon =
    arrow_core


{-| Place a `Option` in the `unnamed` slot of `Select`. -}
option :
    M3e.Build.Option.Builder ca cs msg ck
    -> M3e.Build.Select.Builder pa { ps | unnamed : filled } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | unnamed : M3e.Build.Internal.Filled
    } msg pk
option =
    unnamed_core


{-| Place any child in the `value` slot of `Select` (an arbitrary slot — accepts any component's Builder). -}
value :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Select.Builder pa { ps
        | value : M3e.Build.Internal.Used
    } msg pk
value child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )