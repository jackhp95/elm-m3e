module M3e.Internal exposing (Renderable(..), Supported(..), fromNode, toNode)

{-| Internal primitives — not part of the public surface.

In a package, this module would be unexposed, so consumers cannot forge phantom
tags. In this application we rely on convention; the structure is correct for
when it becomes a package.

-}

import M3e.Node as Node exposing (Node)


type Renderable supported msg
    = Renderable (Node msg)


type Supported
    = Supported


{-| Wrap a Node, pinning its phantom kind. Only components (and the
`M3e.Renderable` convenience helpers) should call this. -}
fromNode : Node msg -> Renderable any msg
fromNode =
    Renderable


{-| Unwrap to the underlying Node for composition / rendering. -}
toNode : Renderable supported msg -> Node msg
toNode (Renderable n) =
    n
