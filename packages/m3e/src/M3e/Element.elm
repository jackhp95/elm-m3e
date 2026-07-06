module M3e.Element exposing
    ( Element
    , toNode, withSlot, map
    )

{-| A phantom-typed wrapper around a lazy [`Node`](M3e-Node): an `Element supported msg`
is a piece of renderable content whose `supported` row records which slot kinds
it is allowed to occupy. Generated component `view` functions produce and consume
`Element`s; the row is what lets the compiler reject content in a slot a component
does not admit.

The type is **opaque** and the raw-to-phantom constructor (`fromNode`) is _not_
re-exported here — it lives in [`M3e.Element.Internal`](M3e-Element-Internal),
reachable only by generated `M3e.*` code and a team's `Seam` module (ADR 0014 §2).
The safe out-bound extraction [`toNode`](#toNode), slot tagging, and `map` remain
public. There is no library-defined `text` constructor: text/link/label are
config-declared userland **seams** (ADR 0014 §1), crafted in the team's `Seam`
module on the generated `M3e.Seam` contracts.

@docs Element
@docs toNode, withSlot, map

-}

import M3e.Element.Internal as I
import M3e.Node exposing (Node)


{-| The opaque phantom-typed wrapper, re-exported from
[`M3e.Element.Internal`](M3e-Element-Internal). The `supported` row records which
slot kinds this content may occupy; it is never inspected at runtime.
-}
type alias Element supported msg =
    I.Element supported msg


{-| Map the message type of an element. See
[`M3e.Element.Internal.map`](M3e-Element-Internal#map) for the eager-render caveat.
-}
map : (a -> b) -> Element supported a -> Element supported b
map =
    I.map


{-| Unwrap to the underlying lazy `Node`.
-}
toNode : Element supported msg -> Node msg
toNode =
    I.toNode


{-| Tag an element with the named DOM `slot` it should occupy.
-}
withSlot : String -> Element supported msg -> Element supported msg
withSlot =
    I.withSlot
