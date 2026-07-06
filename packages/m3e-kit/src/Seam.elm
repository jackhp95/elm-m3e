module Seam exposing (asAttribute, asElement, forget, fromHtml, label, link, slot, stripPhantom, text)

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

The **semantic seams** (`text`/`link`/`label`, ADR 0014 §1) are also crafted here:
the generator emits the typed hole (contract types in `M3e.Seam`, stampers in
`M3e.Seam.Internal`) and this module fills it with the team's concrete producers.
This is where `Kit.text`/`Kit.link` used to live as privileged producers; now they
are ordinary couplers built on the generated stampers, so a team can give its own
`text` (e.g. an i18n web component) a precise, slot-safe type.

See docs/adr/0014-seam-boundary-and-typed-userland.md and ADOPTION\_AND\_SLOTS.md §8.

-}

import Html exposing (Html)
import Html.Attributes
import M3e.Cem.Attr.Internal as Attr exposing (Attr)
import M3e.Content.Internal as Content exposing (Content)
import M3e.Element.Internal as Element exposing (Element)
import M3e.Node.Internal as Node exposing (Node)
import M3e.Seam exposing (Label, Link, Text)
import M3e.Seam.Internal as Stamp


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


{-| Stamp a slot name onto an `Element`, producing slot-tagged `Content` at
whatever `slots` row the call site needs. Built on `M3e.Content.Internal.slot`
(the interior stamper the public `M3e.Content` withholds), so slot-name stamping
is a governed Seam crossing rather than a raw `.Internal` reach. The default
(unnamed) slot uses `""` and adds no `slot=` attribute.

This is the coupler the D6 translator's unknown-slot-name residue emits: an
element bound to a literal slot name the design system doesn't recognise crosses
back through `Seam` (loud, greppable, `NoSeamOutsideAllowedModules`-flagged)
instead of reaching for `M3e.Content.Internal` directly.

-}
slot : String -> Element any msg -> Content slots msg
slot =
    Content.slot


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



-- SEMANTIC SEAMS (ADR 0014 §1) ------------------------------------------------


{-| The `text` seam: slotted text content. A bare text leaf that
[`M3e.Node.addAttr`](M3e-Node) span-wraps automatically when placed in a named
slot (so it can carry `slot=`). Built on the generated `M3e.Seam` stamper, so it
carries the `text` kind and type-checks in any `text` slot.

Swap this body for the team's own text (e.g. an i18n-key web component) without
touching a single call site — that is the point of the seam.

-}
text : String -> Text s msg
text s =
    Stamp.text (Element.fromNode (Node.text s))


{-| The `link` seam: a plain navigation anchor (`<a href>`) wrapping the given
content. The library doesn't opinionate links; a team styles or swaps this here.
Carries the `link` kind via the generated stamper.
-}
link : String -> List (Element s msg) -> Link s msg
link href kids =
    Stamp.link
        (Element.fromNode
            (Node.fromComponent
                (\a c -> Html.a (Html.Attributes.href href :: List.map Attr.toAttribute a) c)
                []
                (List.map Element.toNode kids)
            )
        )


{-| The `label` seam: a native `<label>` wrapping the given content. Carries the
`label` kind via the generated stamper — the coupler a `for=id`-wired field
(ADR 0014 §3, #114) composes with.
-}
label : List (Element s msg) -> Label s msg
label kids =
    Stamp.label
        (Element.fromNode
            (Node.fromComponent
                (\a c -> Html.label (List.map Attr.toAttribute a) c)
                []
                (List.map Element.toNode kids)
            )
        )
