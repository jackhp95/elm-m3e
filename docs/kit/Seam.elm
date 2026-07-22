module Seam exposing (asAttribute, asElement, field, fromHtml, label, link, recast, recastAttr, slot, text)

{-| The **single** sanctioned userland boundary — migrated to the phantom substrate.

`Seam` crosses between raw Elm `Html` and the opaque, phantom-typed IR. It is built
directly on `HtmlIr.Internal` — the interior surface that exposes the raw-to-phantom
constructors the public modules deliberately withhold.

This module supersedes the former markup-core `Seam`: all `Markup.*` references now
route through `HtmlIr.*` and `TypedHtml.*`.

-}

import Html exposing (Html)
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared)
import HtmlIr.Node exposing (Node)
import TypedHtml
import TypedHtml.Attributes
import TypedHtml.Form


{-| Lift a raw `Html` leaf into an `Element`, stamping whatever phantom row the
call site needs.
-}
fromHtml : Html msg -> Element accepts admittedBy msg
fromHtml h =
    Ir.fromNode (Ir.fromHtml h)


{-| Stamp a bare `Node` as an `Element` with whatever phantom row the call site
needs.
-}
asElement : Node msg -> Element accepts admittedBy msg
asElement =
    Ir.fromNode


{-| Turn a raw `Html.Attribute` into a typed `Attr` carrying a fully-open
capability row.
-}
asAttribute : Html.Attribute msg -> Attr capability msg
asAttribute a =
    Ir.fromHtmlAttribute a


{-| Stamp a slot name onto an `Element`, re-forging a FREE phantom row on the
result so it composes into any container's child list.
-}
slot : String -> Element any anyAdm msg -> Element other otherAdm msg
slot name el =
    if name == "" then
        Ir.fromNode (HtmlIr.Element.toNode el)

    else
        Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" name) (HtmlIr.Element.toNode el))


{-| Coerce an `Element`'s phantom rows from one shape to another.
Loud and greppable.
-}
recast : Element a aAdm msg -> Element b bAdm msg
recast el =
    Ir.fromNode (HtmlIr.Element.toNode el)


{-| Coerce an `Attr`'s capability row from one shape to another.
-}
recastAttr : Attr a msg -> Attr b msg
recastAttr a =
    Ir.fromHtmlAttribute (HtmlIr.Attribute.toHtmlAttribute a)



-- SEMANTIC SEAMS ---------------------------------------------------------------


{-| The `text` seam: a bare text leaf carrying the `sharedText` kind.

Delegates to `TypedHtml.text` — the canonical typed text producer.

-}
text : String -> Element { s | sharedText : Shared } admittedBy msg
text =
    TypedHtml.text


{-| The `link` seam: a plain navigation anchor (`<a href>`) wrapping children.
Carries the `sharedLink` kind.

Built on `TypedHtml.a` + `TypedHtml.Attributes.href` — the typed anchor producer
with closed `Attrs` (only anchor-natural attributes accepted).

-}
link : String -> List (Element s admittedBy msg) -> Element { k | sharedLink : Shared } linkAdm msg
link href kids =
    recast (TypedHtml.a [ TypedHtml.Attributes.href href ] (List.map recast kids))


{-| The `label` seam: a native `<label>` wrapping children. Carries the `sharedLabel` kind.

Built on `TypedHtml.label` — the typed label producer with closed `LabelAttrs`
(7 attributes: `class`, `for`, `id`, `role`, `slot`, `style`, and `form`).

-}
label : List (Element s admittedBy msg) -> Element { k | sharedLabel : Shared } labelAdm msg
label kids =
    recast (TypedHtml.label [] (List.map recast kids))



-- STRUCTURAL HELPERS ----------------------------------------------------------


{-| The canonical form-field structural-association pattern.

Renders a native `<label for=id>` and a control `<input id=id>` (or any control
element that accepts an `id` attribute) as **siblings in `m3e-form-field`'s
default slot**. The browser's `for`/`id` match wires them into one accessible
control; `m3e-form-field` styles the pair. No id-wiring injection — pure HTML.

    M3e.formField []
        (Seam.field "email"
            { labelContent = [ Seam.text "Email address" ]
            , control =
                TypedHtml.input
                    [ TypedHtml.Attributes.id "email"
                    , TypedHtml.Attributes.for "email" -- type_ not shown here
                    ]
                    []
                    |> Seam.recast
            }
        )

Pass `Seam.recast` around the control when its phantom row doesn't unify with
the label's `html` row — that coercion is intentional and greppable.

This helper supersedes the per-app `fieldLabel`/`fieldControl` helpers that
feedback-fab, compass-social, and animal-spirits each hand-rolled.

-}
field :
    String
    -> { labelContent : List (Element s admittedBy msg), control : Element { k | html : r } admittedBy msg }
    -> List (Element { k | html : r } admittedBy msg)
field id_ { labelContent, control } =
    [ recast (TypedHtml.label [ TypedHtml.Attributes.for id_ ] (List.map recast labelContent))
    , control
    ]
