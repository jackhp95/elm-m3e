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


{-| Map the message type of an element (crosses a msg boundary; renders eagerly).
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
