module Seam exposing (asAttribute, asElement, fromHtml, label, link, recast, recastAttr, slot, text)

{-| The **single** sanctioned userland boundary (see `docs/DESIGN.md` §4; issue #81).

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
  - `recast` / `recastAttr` — re-type an already-typed value from one phantom
    row to another (the loud, greppable "the design system is wrong here"
    break-glass). Both are behavior-preserving: `recastAttr` is a pure row cast on the
    `Attr`, while `recast` rebuilds the `Element` wrapper (`toNode >> fromNode`)
    to re-open its row — no change to the rendered output either way.

The **semantic seams** (`text`/`link`/`label`, `docs/DESIGN.md` §4) are also crafted here:
the generator emits the typed hole (contract types in `M3e.Seam`, stampers in
`M3e.Seam.Internal`) and this module fills it with the team's concrete producers.
This is where `Kit.text`/`Kit.link` used to live as privileged producers; now they
are ordinary couplers built on the generated stampers, so a team can give its own
`text` (e.g. an i18n web component) a precise, slot-safe type.

See docs/DESIGN.md §4.

-}

import Html exposing (Html)
import Html.Attributes
import M3e.Element.Internal as Element exposing (Element)
import M3e.Html.Attr.Internal as Attr exposing (Attr)
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


{-| Stamp a slot name onto an `Element`, re-forging a FREE phantom row on the
result so it composes into any container's child list. Built on
`M3e.Element.Internal.withSlot` (the named-slot placement primitive the
public `M3e.Element` withholds), so slot-name stamping is a governed Seam
crossing rather than a raw `.Internal` reach. The default (unnamed) slot uses
`""` and adds no `slot=` attribute.

This is the coupler the surface translator's unknown-slot-name residue emits: an
element bound to a literal slot name the design system doesn't recognise crosses
back through `Seam` (loud, greppable, `NoSeamOutsideAllowedModules`-flagged)
instead of reaching for `M3e.Element.Internal` directly.

-}
slot : String -> Element any msg -> Element other msg
slot name el =
    if name == "" then
        Element.fromNode (Element.toNode el)

    else
        Element.fromNode (Element.toNode (Element.withSlot name el))


{-| Coerce an `Element`'s phantom row from one shape to another (formerly
`EscapeHatch.asElement`, a.k.a. `recast`). Loud and greppable: it asserts a
kind a slot forbids, so the design-system team audits every use.
-}
recast : Element a msg -> Element b msg
recast =
    Element.toNode >> Element.fromNode


{-| Coerce an `Attr`'s capability row from one shape to another (formerly
`EscapeHatch.asAttribute`). The attribute counterpart of `recast`.
-}
recastAttr : Attr a msg -> Attr b msg
recastAttr =
    Attr.forget



-- SEMANTIC SEAMS (docs/DESIGN.md §4) ------------------------------------------


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
(`docs/DESIGN.md` §4, #114) composes with.
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
