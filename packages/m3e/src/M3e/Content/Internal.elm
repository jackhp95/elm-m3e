module M3e.Content.Internal exposing (Content(..), slot, slotWithAttr, toNode)

{-| The **unfenced** interior of [`M3e.Content`](M3e-Content): the opaque
`Content` type _with its constructor_ plus the raw [`slot`](#slot) stamper, which
can mint slot-tagged content at any `slots` row. Importable only by generated
`M3e.*` code (the per-slot setters call `slot` at a concrete row) and a team's
`Seam` module (enforced by `NoInternalImportOutsideAllowed`). Userland places
content through the generated per-slot setters, never by minting an arbitrary
slot row here. See ADR 0014 §2.

@docs Content, slot, slotWithAttr, toNode

-}

import Html.Attributes
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


{-| Like [`slot`](#slot), but ALSO stamps a single raw `name="value"` attribute
onto the element. This is the generator's **for/id auto-wiring** primitive (ADR
0010 R6): a sibling-slot form-field's control-slot setter stamps `id="<id>"` and
its label-slot setter stamps `for="<id>"`, so the label↔control association is
structural. `slotName == ""` (the default slot) adds no `slot=` attribute, just
the extra attribute; a named slot stamps both.
-}
slotWithAttr : String -> String -> String -> Element supported msg -> Content slots msg
slotWithAttr slotName attrName attrValue el =
    let
        withAttr =
            Element.toNode el
                |> Node.addAttr (Attr.forget (Attr.attribute (Html.Attributes.attribute attrName) attrValue))
    in
    Content
        (if slotName == "" then
            withAttr

         else
            Node.addAttr (Attr.forget (Attr.slot slotName)) withAttr
        )


{-| Unwrap slot-tagged content back to its underlying `Node`, discarding the
phantom slot row. Used by the generated `view` to lower a `Content` list into
the DOM children it renders.
-}
toNode : Content slots msg -> Node msg
toNode (Content n) =
    n
