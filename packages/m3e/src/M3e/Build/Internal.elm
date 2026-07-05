module M3e.Build.Internal exposing
    ( Builder(..), Available, Used, NotFilled, Filled, wrap_
    , node_
    )

{-|
Marker types + shared opaque Builder wrapping a lazy Node.

Available/Used gate optional-singular attribute and slot capabilities;
NotFilled/Filled gate required-multi slot capabilities. Applying the same
singular setter twice is a compile-time TYPE MISMATCH. The NotFilled → Filled
ratchet guards required-multi slots: `build` refuses to type-check when a
required-multi slot has not been filled.

The Builder wraps a lazy `M3e.Node.Node` — the same IR every other shape emits.
`wrap_` and `node_` are generator-internal helpers used by emitted setters to
modify the underlying Node; user code should not call them directly.

@docs Builder, Available, Used, NotFilled, Filled, wrap_
@docs node_
-}


import M3e.Node


{-| Shared opaque Builder wrapping a lazy `M3e.Node.Node`. Per-component Build modules expose type aliases that pin `kindRow`; `wrap_` and `node_` are the generator-internal bridge between Builders and Nodes. -}
type Builder kindRow attrCaps slotCaps msg
    = Builder (M3e.Node.Node msg)


{-| Optional-singular capability that has not yet been used. -}
type Available
    = Available


{-| Optional-singular capability that has been used and cannot be applied again. -}
type Used
    = Used


{-| Required-multi slot that has not yet been filled. `build` requires `Filled`. -}
type NotFilled
    = NotFilled


{-| Required-multi slot that has been filled at least once. -}
type Filled
    = Filled


{-| Wrap a Node into a Builder. Generator-internal. -}
wrap_ : M3e.Node.Node msg -> Builder k a s msg
wrap_ n_ =
    Builder n_


{-| Unwrap a Builder to its underlying Node. Generator-internal. -}
node_ : Builder k a s msg -> M3e.Node.Node msg
node_ (Builder n_) =
    n_