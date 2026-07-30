module Seam exposing
    ( fromHtml, asElement, asAttribute, recast, recastAttr, slot, field, label
    , node, custom, attribute, onClick, style
    , text, link, textLink
    , Size, display, headline, title, body, labelText, code, paragraph
    , colored, overline, tint
    , TextColor, onSurface, onSurfaceVariant, primary, secondary, tertiary, error
    , rowWith, colWith, gridWith
    , div, divWithId, section, span, nav, ul, li
    , button, class
    )

{-| The docs app's **single userland module** — the one place we corral
everything we build on top of the library. It exists as a worked example of the
_seam practice_: the library already gives you typed producers (`TypedHtml.*`,
`M3e.*`) and two fenced escape surfaces (`HtmlIr.Internal`, `TypedHtml.Unsafe`);
a "seam" is just keeping your uses of them in one greppable place. Feature code
imports `Seam` (and `TypedHtml` for plain tags) — never a pile of ad-hoc wrappers.


## Escapes — raw-HTML crossings, built on the fenced surfaces

@docs fromHtml, asElement, asAttribute, recast, recastAttr, slot, field, label
@docs node, custom, attribute, onClick, style


## Design-system vocabulary

@docs text, link, textLink
@docs Size, display, headline, title, body, labelText, code, paragraph
@docs colored, overline, tint
@docs TextColor, onSurface, onSurfaceVariant, primary, secondary, tertiary, error


## Layout helpers

@docs rowWith, colWith, gridWith
@docs div, divWithId, section, span, nav, ul, li
@docs button, class

-}

import Html exposing (Html)
import Html.Attributes
import Html.Events
import HtmlIr.Attribute exposing (Attr)
import HtmlIr.Element exposing (Element)
import HtmlIr.Internal as Ir
import HtmlIr.Kind exposing (Shared, Supported)
import HtmlIr.Node exposing (Node)
import HtmlIr.Value exposing (Value)
import M3e.Kind
import TypedHtml
import TypedHtml.Attributes



-- ESCAPES — the fenced crossings, kept in one greppable place -----------------


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


{-| Stamp a slot name onto an `Element`, re-forging a FREE phantom row so it
composes into any container's child list.
-}
slot : String -> Element any anyAdm msg -> Element other otherAdm msg
slot name el =
    if name == "" then
        Ir.fromNode (HtmlIr.Element.toNode el)

    else
        Ir.fromNode (Ir.addAttribute (Ir.attribute "slot" name) (HtmlIr.Element.toNode el))


{-| Coerce an `Element`'s phantom rows from one shape to another. Loud and greppable.
-}
recast : Element a aAdm msg -> Element b bAdm msg
recast el =
    Ir.fromNode (HtmlIr.Element.toNode el)


{-| Coerce an `Attr`'s capability row from one shape to another.
-}
recastAttr : Attr a msg -> Attr b msg
recastAttr a =
    Ir.fromHtmlAttribute (HtmlIr.Attribute.toHtmlAttribute a)


{-| The `label` seam: a native `<label>` wrapping children, carrying the `sharedLabel` kind.
-}
label : List (Element s admittedBy msg) -> Element { k | sharedLabel : Shared } labelAdm msg
label kids =
    recast (TypedHtml.label [] (List.map recast kids))


{-| The canonical form-field structural-association pattern: a native
`<label for=id>` in `m3e-form-field`'s `label` slot plus a control with `id=id`.
-}
field :
    String
    -> { labelContent : List (Element s admittedBy msg), control : Element { k | html : r } admittedBy msg }
    -> List (Element { k | html : r } admittedBy msg)
field id_ { labelContent, control } =
    [ recast (slot "label" (TypedHtml.label [ TypedHtml.Attributes.for id_ ] (List.map recast labelContent)))
    , control
    ]



-- NATIVE ESCAPES — for what TypedHtml.* cannot express ------------------------


{-| Build a native element from any tag name — for **dynamic tag names** or
**custom elements** not yet in `TypedHtml.*`. For standard tags reach for
`TypedHtml.*` (or [`htmlLabel`](#htmlLabel) / [`htmlInput`](#htmlInput)).
-}
node :
    String
    -> List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
node tagName attrs kids =
    Ir.fromNode
        (Ir.node tagName attrs (List.map HtmlIr.Element.toNode kids))


{-| Build a named custom element (e.g. `"my-widget"`). A greppable alias over [`node`](#node).
-}
custom :
    String
    -> List (Attr c msg)
    -> List (Element s admittedBy msg)
    -> Element { k | html : M3e.Kind.Brand } freeAdm msg
custom =
    node


{-| A raw HTML attribute as a typed `Attr` carrying a fully-open capability row.
-}
attribute : String -> String -> Attr c msg
attribute name value =
    Ir.fromHtmlAttribute (Html.Attributes.attribute name value)


{-| A raw inline CSS declaration as a typed `Attr`.
-}
style : String -> String -> Attr c msg
style key value =
    Ir.fromHtmlAttribute (Html.Attributes.style key value)


{-| A native `click` handler as a typed `Attr`.
-}
onClick : msg -> Attr c msg
onClick msg =
    Ir.fromHtmlAttribute (Html.Events.onClick msg)



-- DESIGN-SYSTEM VOCABULARY ----------------------------------------------------


{-| Slotted text — carries the `sharedText` kind so it type-checks in any `sharedText` slot.
-}
text : String -> Element { s | sharedText : Shared } admittedBy msg
text =
    TypedHtml.text


{-| A plain navigation anchor (the `link` seam) — carries the `sharedLink` kind.
-}
link : String -> List (Element s admittedBy msg) -> Element { k | sharedLink : Shared } linkAdm msg
link href kids =
    recast (TypedHtml.a [ TypedHtml.Attributes.href href ] (List.map recast kids))


{-| An inline text link (`hover:underline`, tinted by the given color roles).
-}
textLink : String -> List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
textLink href colors kids =
    node "a"
        [ asAttribute (Html.Attributes.href href)
        , classAttr [ "hover:underline" ] colors
        ]
        kids


{-| The M3 type-scale size axis: `M3e.Values.small` / `medium` / `large`.
-}
type alias Size =
    Value { small : Supported, medium : Supported, large : Supported }


sizeSuffix : Size -> String
sizeSuffix size =
    case HtmlIr.Value.toString size of
        "large" ->
            "lg"

        "medium" ->
            "md"

        "small" ->
            "sm"

        other ->
            other


typescale : String -> String -> Size -> List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
typescale tagName role size colors kids =
    node tagName
        [ classAttr [ "text-" ++ role ++ "-" ++ sizeSuffix size ] colors ]
        kids


{-| Display type scale (`text-display-{lg|md|sm}`), rendered `<span>`.
-}
display : Size -> List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
display =
    typescale "span" "display"


{-| Headline type scale, rendered `<span>`.
-}
headline : Size -> List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
headline =
    typescale "span" "headline"


{-| Title type scale, rendered `<span>`.
-}
title : Size -> List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
title =
    typescale "span" "title"


{-| Body type scale, rendered `<span>`.
-}
body : Size -> List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
body =
    typescale "span" "body"


{-| Label type scale, rendered `<span>`.
-}
labelText : Size -> List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
labelText =
    typescale "span" "label"


{-| Inline code at the body type scale, rendered `<code>`.
-}
code : Size -> List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
code =
    typescale "code" "body"


{-| A prose paragraph at the body type scale, rendered as a block `<p>`.
-}
paragraph : Size -> List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
paragraph =
    typescale "p" "body"


{-| An M3 "overline" eyebrow: label-large, uppercase, letter-spaced.
-}
overline : List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
overline colors kids =
    node "p"
        [ classAttr [ "text-label-lg uppercase tracking-wide" ] colors ]
        kids


{-| A text color role.
-}
type TextColor
    = TextColor String


textColorClass : TextColor -> String
textColorClass (TextColor cls) =
    cls


classAttr : List String -> List TextColor -> Attr c msg
classAttr extras colors =
    asAttribute
        (Html.Attributes.class
            (String.join " " (extras ++ List.map textColorClass colors))
        )


{-| Tint arbitrary content with the given color roles, wrapped in a `<span>`.
-}
colored : List TextColor -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
colored colors kids =
    node "span" [ classAttr [] colors ] kids


{-| Color roles as a composable attribute.
-}
tint : List TextColor -> Attr c msg
tint colors =
    classAttr [] colors


{-| `text-on-surface`.
-}
onSurface : TextColor
onSurface =
    TextColor "text-on-surface"


{-| `text-on-surface-variant`.
-}
onSurfaceVariant : TextColor
onSurfaceVariant =
    TextColor "text-on-surface-variant"


{-| `text-primary`.
-}
primary : TextColor
primary =
    TextColor "text-primary"


{-| `text-secondary`.
-}
secondary : TextColor
secondary =
    TextColor "text-secondary"


{-| `text-tertiary`.
-}
tertiary : TextColor
tertiary =
    TextColor "text-tertiary"


{-| `text-error`.
-}
error : TextColor
error =
    TextColor "text-error"



-- LAYOUT HELPERS — thin `<div class="…">` wrappers over the escape ------------


{-| A flex row wrapper carrying exact Tailwind classes.
-}
rowWith : String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
rowWith =
    div


{-| A flex column wrapper carrying exact Tailwind classes.
-}
colWith : String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
colWith =
    div


{-| A CSS grid wrapper carrying exact Tailwind classes.
-}
gridWith : String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
gridWith =
    div


{-| A `<div>` carrying the given Tailwind class string verbatim.
-}
div : String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
div cls children =
    node "div" [ asAttribute (Html.Attributes.class cls) ] children


{-| A `<div>` carrying the given Tailwind class string verbatim plus an `id`.
-}
divWithId : String -> String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
divWithId id cls children =
    node "div" [ asAttribute (Html.Attributes.id id), asAttribute (Html.Attributes.class cls) ] children


{-| A `<section>` carrying the given Tailwind class string verbatim.
-}
section : String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
section cls children =
    node "section" [ asAttribute (Html.Attributes.class cls) ] children


{-| A `<span>` carrying the given Tailwind class string verbatim.
-}
span : String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
span cls children =
    node "span" [ asAttribute (Html.Attributes.class cls) ] children


{-| A `<nav>` carrying the given Tailwind class string verbatim.
-}
nav : String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
nav cls children =
    node "nav" [ asAttribute (Html.Attributes.class cls) ] children


{-| A `<ul>` carrying the given Tailwind class string verbatim.
-}
ul : String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
ul cls children =
    node "ul" [ asAttribute (Html.Attributes.class cls) ] children


{-| A `<li>` carrying the given Tailwind class string verbatim.
-}
li : String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
li cls children =
    node "li" [ asAttribute (Html.Attributes.class cls) ] children


{-| A native `<button>` carrying the given Tailwind class string verbatim.
-}
button : msg -> String -> List (Element s admittedBy msg) -> Element { k | html : M3e.Kind.Brand } freeAdm msg
button onClickMsg cls children =
    node "button"
        [ asAttribute (Html.Events.onClick onClickMsg)
        , asAttribute (Html.Attributes.class cls)
        ]
        children


{-| A layout class string as a composable attribute.
-}
class : String -> Attr c msg
class cls =
    asAttribute (Html.Attributes.class cls)
