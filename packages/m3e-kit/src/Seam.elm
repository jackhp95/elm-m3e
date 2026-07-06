module Seam exposing (asAttribute, asElement, forget, fromHtml, stripPhantom)

{-| The **single** sanctioned userland boundary (ADR 0014 §2, issue #81).

`Seam` is the one place userland crosses between raw Elm `Html` and the opaque,
phantom-typed M3e IR. It is built directly on the `*.Internal` modules — the
interior surface that exposes the raw-to-phantom constructors and the free
phantom-asserting operations the public modules deliberately withhold. Because
every crossing here throws away a guarantee, `Seam` is meant to live only in a
few blessed adapter modules (`Native`, `Layout`, `Kit`, and each app's designated
adapter); `NoSeamOutsideAllowedModules` keeps it there, and
`NoInternalImportOutsideAllowed` keeps the `*.Internal` imports it needs inside
the fence.

This module supersedes the former `EscapeHatch`: the two near-duplicate escape
modules are collapsed into this one boundary. The crossings split by what they do:

  - `fromHtml` / `asElement` / `asAttribute` — lift raw `Html` (or a bare `Node`)
    into the typed IR, stamping any phantom row the call site needs.
  - `stripPhantom` / `forget` — coerce an already-typed value from one phantom
    row to another (the loud, greppable "the design system is wrong here"
    break-glass — a row assertion, not a data transformation).

See docs/adr/0014-seam-boundary-and-typed-userland.md and ADOPTION\_AND\_SLOTS.md §8.

-}

import Html exposing (Html)
import M3e.Cem.Attr.Internal as Attr exposing (Attr)
import M3e.Element.Internal as Element exposing (Element)
import M3e.Node.Internal as Node exposing (Node)


{-| Lift a raw `Html` leaf into an `Element`, stamping whatever phantom row the
call site needs. The embedded DOM (including any `<m3e-*>` custom elements)
renders as-is.
-}
fromHtml : Html msg -> Element supported msg
fromHtml =
    Node.raw >> Element.fromNode


{-| Stamp a bare `Node` as an `Element` with whatever phantom row the call site
needs — the crossing the `Kit`/`Native` producers are built on.
-}
asElement : Node msg -> Element supported msg
asElement =
    Element.fromNode


{-| Turn a raw `Html.Attribute` into a typed `Attr` carrying a fully-open
capability row, so it type-checks in any component's attribute list.
-}
asAttribute : Html.Attribute msg -> Attr capability msg
asAttribute a =
    Attr.attribute (\_ -> a) ()


{-| Coerce an `Element`'s phantom row from one shape to another (formerly
`EscapeHatch.asElement`, a.k.a. `stripPhantom`). Loud and greppable: it asserts a
kind a slot forbids, so the design-system team audits every use.
-}
stripPhantom : Element a msg -> Element b msg
stripPhantom =
    Element.toNode >> Element.fromNode


{-| Coerce an `Attr`'s capability row from one shape to another (formerly
`EscapeHatch.asAttribute`). The attribute counterpart of `stripPhantom`.
-}
forget : Attr a msg -> Attr b msg
forget =
    Attr.forget
