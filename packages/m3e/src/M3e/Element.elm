module M3e.Element exposing
    ( Element(..)
    , fromNode, toNode, withSlot, text, map
    )

{-| A phantom-typed wrapper around a lazy [`Node`](M3e-Node): an `Element supported msg`
is a piece of renderable content whose `supported` row records which slot kinds
it is allowed to occupy. Generated component `view` functions produce and consume
`Element`s; the row is what lets the compiler reject content in a slot a component
does not admit.

@docs Element
@docs fromNode, toNode, withSlot, text, map

-}

import M3e.Cem.Attr as Attr
import M3e.Node as Node exposing (Node)
import M3e.Value exposing (Supported)


{-| The wrapper. `El node` carries the underlying lazy `Node`; the `supported`
row is phantom (never inspected at runtime).
-}
type Element supported msg
    = El (Node msg)


{-| Map the message type of an element.

This crosses a msg boundary and so renders **eagerly**: the underlying IR stores
partially-applied, msg-monomorphic bottom-layer functions, so a structural remap
is not possible — `map` collapses the element to `Html` (via `Html.map`) and
wraps it back up as an opaque node. Consequences:

  - Typed rearrangement (re-slotting) of a mapped element's _interior_ no longer
    applies; it is a rendered blob from here on.
  - Placing a mapped element into a named slot still works — `withSlot` adds the
    `slot=` attribute, and the node promotes to a `<span slot="…">` wrapper
    rather than dropping it (see `Node.addAttr`).

Prefer mapping at your own `msg` boundary (e.g. `Html.map` at the call site, or
threading the final `msg` in) over mapping partially-built elements.

-}
map : (a -> b) -> Element supported a -> Element supported b
map f (El n) =
    El (Node.map f n)


{-| Wrap a raw `Node` as an `Element` accepted in any slot.
-}
fromNode : Node msg -> Element any msg
fromNode =
    El


{-| Unwrap to the underlying lazy `Node`.
-}
toNode : Element supported msg -> Node msg
toNode (El n) =
    n


{-| Tag an element with the named DOM `slot` it should occupy.
-}
withSlot : String -> Element supported msg -> Element supported msg
withSlot name (El node) =
    El (Node.addAttr (Attr.forget (Attr.slot name)) node)


{-| The default "element"-kind content constructor (lazy Text node).
-}
text : String -> Element { s | element : Supported } msg
text s =
    El (Node.text s)
