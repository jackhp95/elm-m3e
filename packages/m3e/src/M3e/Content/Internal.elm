module M3e.Content.Internal exposing (Content(..), slot, toNode)

{-| The **unfenced** interior of [`M3e.Content`](M3e-Content): the opaque
`Content` type _with its constructor_ plus the raw [`slot`](#slot) stamper, which
can mint slot-tagged content at any `slots` row. Importable only by generated
`M3e.*` code (the per-slot setters call `slot` at a concrete row) and a team's
`Seam` module (enforced by `NoInternalImportOutsideAllowed`). Userland places
content through the generated per-slot setters, never by minting an arbitrary
slot row here. See ADR 0014 §2.

@docs Content, slot, toNode

-}

import M3e.Cem.Attr.Internal as Attr
import M3e.Element as Element exposing (Element)
import M3e.Node as Node exposing (Node)


{-| An `Element` assigned to a named slot. The phantom `slots` row records WHICH
slot it was placed in, so the generated `view` type-checks that only content
valid for a component's slots is passed.
-}
type Content slots msg
    = Content (Node msg)


{-| Stamp a slot name onto an element as slot-tagged content. The default (unnamed)
slot uses `""` and adds no `slot=` attribute; a named slot stamps `slot="name"`.
The `slots` row is free here — that is why this lives out of `M3e.Content`'s
public surface; the generated per-slot setters call it at a concrete row.
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


{-| Unwrap slot-tagged content back to its underlying `Node`, discarding the
phantom slot row. Used by the generated `view` to lower a `Content` list into
the DOM children it renders.
-}
toNode : Content slots msg -> Node msg
toNode (Content n) =
    n
