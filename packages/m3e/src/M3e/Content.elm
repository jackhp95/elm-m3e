module M3e.Content exposing (Content, slot, toNode)

{-| Slot-tagged content for the top-layer double-list `view [attrs] [content]`.
A `Content slots msg` is an `Element` that has been assigned to a named slot; the
phantom `slots` row records WHICH slot, so the `view` can enforce that only valid
slot content type-checks.

The `slots` row is set by the generated per-slot setters' type annotations, which
each wrap `slot "name"` at a concrete row — that is where the slot-safety
invariant lives. To keep that the _only_ way to mint slot-tagged content, the
`Content` constructor is opaque: a consumer cannot hand-build a `Content` with a
fabricated row and smuggle it into a `view`. Build content through the generated
setters, not by calling `slot` with an arbitrary name.

-}

import M3e.Cem.Attr as Attr
import M3e.Element as Element exposing (Element)
import M3e.Node as Node exposing (Node)


type Content slots msg
    = Content (Node msg)


{-| Stamp a slot name onto an element as slot-tagged content. The default (unnamed)
slot uses `""` and adds no `slot=` attribute; a named slot stamps `slot="name"`.
-}
slot : String -> Element supported msg -> Content slots msg
slot name el =
    let
        node =
            Element.toNode el
    in
    Content
        (if name == "" then
            node

         else
            Node.addAttr (Attr.forget (Attr.slot name)) node
        )


toNode : Content slots msg -> Node msg
toNode (Content n) =
    n
