module M3e.Build.Card.Slots exposing
    ( unnamed, header, content, actions, footer
    )

{-|
Slot setters for `M3e.Build.Card`. Each alias accepts a specific child component's Builder and inserts it into the parent's slot.

@docs unnamed, header, content, actions, footer
-}


import M3e.Build.Card
import M3e.Build.Internal
import M3e.Node


{-| Place any child in the `unnamed` slot of `Card` (an arbitrary slot — accepts any component's Builder). -}
unnamed :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Card.Builder pa { ps
        | unnamed : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | unnamed : M3e.Build.Internal.Used
    } msg pk
unnamed child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `header` slot of `Card` (an arbitrary slot — accepts any component's Builder). -}
header :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | header : M3e.Build.Internal.Used
    } msg pk
header child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `content` slot of `Card` (an arbitrary slot — accepts any component's Builder). -}
content :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | content : M3e.Build.Internal.Used
    } msg pk
content child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `actions` slot of `Card` (an arbitrary slot — accepts any component's Builder). -}
actions :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | actions : M3e.Build.Internal.Used
    } msg pk
actions child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )


{-| Place any child in the `footer` slot of `Card` (an arbitrary slot — accepts any component's Builder). -}
footer :
    M3e.Build.Internal.Builder ck ca cs msg
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Available
    } msg pk
    -> M3e.Build.Card.Builder pa { ps
        | footer : M3e.Build.Internal.Used
    } msg pk
footer child_ parent_ =
    M3e.Build.Internal.wrap_
        (M3e.Node.addChild
             (M3e.Build.Internal.node_ child_)
             (M3e.Build.Internal.node_ parent_)
        )