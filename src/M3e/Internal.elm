module M3e.Internal exposing (Option(..), Renderable(..), Supported(..), applyOptions, fromNode, option, toNode)

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
`M3e.Renderable` convenience helpers) should call this.
-}
fromNode : Node msg -> Renderable any msg
fromNode =
    Renderable


{-| Unwrap to the underlying Node for composition / rendering.
-}
toNode : Renderable supported msg -> Node msg
toNode (Renderable n) =
    n


{-| An option is a config endomorphism — a function that updates one field of
the component's private `Config` record. Smart constructors return these via
`option`; callers accumulate them in a `List (Option config msg)`.

`config` is the module-private `Config` (or equivalent) type, so the `Option`
remains opaque to outside callers despite the type alias in each component.

The `msg` parameter is phantom — it lets each component write
`type alias Option msg = Internal.Option Config msg` even when `Config` itself
has no `msg` type variable, keeping the public `Option msg` signature stable.

-}
type Option config msg
    = Option (config -> config)


{-| Wrap a `config -> config` function into an `Option`. Called by every
smart constructor in a component module.
-}
option : (config -> config) -> Option config msg
option =
    Option


{-| Fold a list of options over an initial config, applying each in order.
-}
applyOptions : List (Option c msg) -> c -> c
applyOptions opts c0 =
    List.foldl (\(Option f) acc -> f acc) c0 opts
