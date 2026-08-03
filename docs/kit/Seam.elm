module Seam exposing
    ( fromHtml, asElement, asAttribute, recast
    , node, attribute, style
    )

{-| The docs app's **single userland module** — the one place we corral the
genuine escapes we build on top of the library.

Everything with a typed producer now uses it directly: standard HTML is
`TypedHtml.*`, components are `M3e.*`, and events / attributes are
`M3e.Events` / `TypedHtml.Attributes` / `TypedHtml.Aria`. What remains here are
only the crossings the type system genuinely cannot express — raw-`Html` interop
and the custom-element forge (`<model-viewer>`, `<slide-panels>`, `<avt-snackbar>`)
— kept in one greppable place and built on the library's lint-fenced surface
(`HtmlIr.Internal`). See [Your own seam](/guide/seams).


## Raw-HTML / Node crossings

@docs fromHtml, asElement, asAttribute, recast


## The forge — custom tags and attributes `TypedHtml.*` cannot express

@docs node, attribute, style

-}

import Html exposing (Html)
import Html.Attributes
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Node exposing (Node)
import M3e.Kind



-- RAW-HTML CROSSINGS — the fenced escapes, kept in one greppable place --------


{-| Lift a raw `Html` leaf into an `Element`, stamping whatever phantom row the
call site needs. Built on `HtmlIr.Internal` — a lint-fenced escape.
-}
fromHtml : Html msg -> Element accepts admittedBy msg
fromHtml h =
    Ir.fromNode (Ir.fromHtml h)


{-| Stamp a bare `Node` as an `Element` with whatever phantom row the call site needs.
-}
asElement : Node msg -> Element accepts admittedBy msg
asElement =
    Ir.fromNode


{-| Turn a raw `Html.Attribute` into a typed `Attr` carrying a fully-open capability row.
-}
asAttribute : Html.Attribute msg -> Attr capability msg
asAttribute a =
    Ir.fromHtmlAttribute a


{-| Coerce an `Element`'s phantom rows from one shape to another — the break-glass
re-kind, loud and greppable, for the rare case where a slot's declared kinds are
genuinely wrong for what you must place (e.g. two mutually-exclusive icons that must
share one singular slot).
-}
recast : Element a aAdm msg -> Element b bAdm msg
recast element =
    Ir.fromNode (HtmlIr.Element.toNode element)



-- THE FORGE — custom elements / attributes TypedHtml.* cannot express ---------


{-| Build a native element from any tag name — for **custom elements** not in
`TypedHtml.*` (e.g. `<model-viewer>`, `<slide-panels>`, `<avt-snackbar>`).
-}
node :
    String
    -> List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
node tagName attrs kids =
    Ir.fromNode
        (Ir.node tagName attrs (List.map HtmlIr.Element.toNode kids))


{-| A raw HTML attribute as a typed `Attr` carrying a fully-open capability row.
-}
attribute : String -> String -> Attr c msg
attribute name value =
    Ir.fromHtmlAttribute (Html.Attributes.attribute name value)


{-| A raw inline CSS declaration as a typed `Attr`.

Now `Ir.styles`, not `Html.Attributes.style`. The kernel path compiled to
`node.style[key] = value`, which silently ignores CSS custom properties
(`--x` needs `setProperty`) and drops `!important`; it also could not merge, so
a second declaration on the same element clobbered the first. `Ir.styles`
handles all three.

This is no longer a genuine escape — `TypedHtml.Attributes.style` is now
identical. Kept only so existing call sites keep working.

-}
style : String -> String -> Attr c msg
style key value =
    Ir.styles [ ( key, value ) ]
