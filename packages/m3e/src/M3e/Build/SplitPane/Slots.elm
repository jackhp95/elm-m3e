module M3e.Build.SplitPane.Slots exposing ( start, end )

{-|
Slot setters for `M3e.Build.SplitPane`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs start, end
-}


import M3e.Build.Internal
import M3e.Build.SplitPane
import M3e.Node


{-| Place any child in the `start` slot of `SplitPane` (an arbitrary slot — accepts any component's Builder). -}
start :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | start : M3e.Build.Internal.Used
    } msg pk
start child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `end` slot of `SplitPane` (an arbitrary slot — accepts any component's Builder). -}
end :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.SplitPane.Builder pa { ps
        | end : M3e.Build.Internal.Used
    } msg pk
end child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )