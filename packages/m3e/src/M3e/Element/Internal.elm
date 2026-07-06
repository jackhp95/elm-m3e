module M3e.Element.Internal exposing
    ( Element(..)
    , fromNode, toNode, withSlot, map
    )

{-| The **unfenced** interior of [`M3e.Element`](M3e-Element): the opaque
`Element` type _with its constructor_ plus every operation, including the
phantom-asserting [`fromNode`](#fromNode). Importable only by generated `M3e.*`
code and a team's designated `Seam` module (enforced by the
`NoInternalImportOutsideAllowed` review rule); userland reaches `Element` through
the public re-export in [`M3e.Element`](M3e-Element), which withholds `fromNode`
so raw content cannot be minted into an arbitrary `supported` row outside the
seam. See ADR 0014 §2.

@docs Element
@docs fromNode, toNode, withSlot, map

-}

import M3e.Cem.Attr.Internal as Attr
import M3e.Node as Node exposing (Node)


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


{-| Wrap a raw `Node` as an `Element` accepted in any slot. This is the free
phantom assertion — it invents the `supported` row — so it lives here, out of
`M3e.Element`'s public surface.
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
