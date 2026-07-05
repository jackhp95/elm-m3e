module M3e.Content exposing (Content, toNode)

{-| Slot-tagged content for the top-layer double-list `view [attrs] [content]`.
A `Content slots msg` is an `Element` that has been assigned to a named slot; the
phantom `slots` row records WHICH slot, so the `view` can enforce that only valid
slot content type-checks.

The `slots` row is set by the generated per-slot setters' type annotations, which
each wrap the internal `slot "name"` at a concrete row — that is where the
slot-safety invariant lives. To keep that the _only_ way to mint slot-tagged
content, both the `Content` constructor and the raw `slot` stamper are withheld
here and live in [`M3e.Content.Internal`](M3e-Content-Internal) (ADR 0014 §2): a
consumer cannot hand-build a `Content` with a fabricated row and smuggle it into
a `view`. Build content through the generated setters.

@docs Content, toNode

-}

import M3e.Content.Internal as I
import M3e.Node exposing (Node)


{-| An `Element` assigned to a named slot, opaque and re-exported from
[`M3e.Content.Internal`](M3e-Content-Internal). The phantom `slots` row records
WHICH slot it was placed in. Mint one through the generated per-slot setters.
-}
type alias Content slots msg =
    I.Content slots msg


{-| Unwrap slot-tagged content back to its underlying `Node`, discarding the
phantom slot row. Used by the generated `view` to lower a `Content` list into
the DOM children it renders.
-}
toNode : Content slots msg -> Node msg
toNode =
    I.toNode
