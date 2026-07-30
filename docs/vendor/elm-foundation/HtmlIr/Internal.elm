module HtmlIr.Internal exposing
    ( Element, Node, Attr, Value
    , fromNode, element
    , attribute, property, on, fromHtmlAttribute
    , token
    , fromHtml
    , node, keyedNode, text, addAttribute, toHtml
    , lazy, lazy2, lazy3, lazy4, lazy5, lazy6, lazy7, lazy8
    , toNode, mapElement, mapNode, mapAttribute, toHtmlAttribute, toString
    )

{-| The **curated forge** of the intermediate representation — the single most
dangerous surface in the system. Read this module top to bottom before touching
anything; it is deliberately small so a human can audit it once.


# Trust model — read this first

Every type in this package is opaque and every _public_ module
([`HtmlIr.Element`](HtmlIr-Element), [`HtmlIr.Node`](HtmlIr-Node),
[`HtmlIr.Attribute`](HtmlIr-Attribute), [`HtmlIr.Value`](HtmlIr-Value)) exposes
only operations that **preserve or discard** phantom rows. This module is the
one place rows are **minted**: [`fromNode`](#fromNode) invents an `Element`'s
two rows, [`attribute`](#attribute)/[`property`](#property)/[`on`](#on)/
[`fromHtmlAttribute`](#fromHtmlAttribute) invent an `Attr`'s capability row, and
[`token`](#token) invents a `Value`'s tag row. Whoever imports this module can
assert any phantom claim about any content — including smuggling raw `Html`
(via [`fromHtml`](#fromHtml) then [`fromNode`](#fromNode)) into a slot that was
typed to accept only text.

Elm's `exposed-modules` gate is binary: this module must be exposed so that
_generated_ brand packages (which live in other packages) can build on the IR,
and once exposed, **any** consumer can import it. There is no
"generated-code-only" visibility in Elm and no compiler-sound alternative
(proven — see elm-cem#39 and the `/tmp/irpkg` attack cases). The trusted /
untrusted line is therefore held by exactly one thing:

> **The `NoInternalImportOutsideAllowed` rule in `jackhp95/elm-review-cem` is
> load-bearing.** A project that does not install it gets element↔attribute,
> enum, and nesting safety only for code that stays off this module; a project
> that installs it gets the full guarantee. Documentation must never claim
> "compiler-guaranteed" without this caveat.

Curation rules for this module (frozen at 1.0):

  - Functions and opaque types only — **no data constructors** are ever
    exposed, so the forge surface is exactly the functions listed here, not the
    representation.
  - **No userland-shaped conveniences.** Opinionated operations (slot
    placement, kind branding, coercion, event delegation) are compositions of
    these levers, built _above_ the IR by brand packages — see the composition
    table in the README. Generality-as-obscurity is the safety feature.


# Types

@docs Element, Node, Attr, Value


# Element forge

@docs fromNode, element


# Attribute forge

@docs attribute, property, on, fromHtmlAttribute


# Value forge

@docs token


# Raw-Html escape

@docs fromHtml


# Safe operations (definition site)

These are re-exported by the public modules; they live here only because the
opaque representations do. None of them mint a row.

@docs node, keyedNode, text, addAttribute, toHtml
@docs lazy, lazy2, lazy3, lazy4, lazy5, lazy6, lazy7, lazy8
@docs toNode, mapElement, mapNode, mapAttribute, toHtmlAttribute, toString

-}

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Decode
import Json.Encode
import VirtualDom



-- TYPES


{-| A phantom-typed wrapper around a [`Node`](#Node), carrying **two** phantom
rows plus `msg`:

  - `accepts` — the kind row: which slot kinds this element produces /
    which child kinds a container's slot demands (parent → child).
  - `admittedBy` — the context row: which parent contexts this element
    declares itself valid inside (child → parent).

Composition unifies both edges: child-kind ⊆ parent-accepted-kinds AND
parent-context ∈ child-admittedBy. Producers keep `accepts` open and
`admittedBy` closed; containers demand a closed `accepts` on children and
inject an open demand for their own context into each child's `admittedBy`.
An **open** `admittedBy` on a producer means "valid anywhere" — enforcement
requires the closed row (proven: an open row unifies with any demand).

Neither row is ever inspected at runtime.

-}
type Element accepts admittedBy msg
    = Element (Node msg)


{-| The untyped intermediate tree every `Element` wraps: a tag node (name,
attributes, children), a text leaf, or a raw-`Html` escape. Construction stays
structural — not pre-rendered `VirtualDom` — so the typed layers above can
rearrange, re-attribute, and message-map content before anything is rendered.
-}
type Node msg
    = Tag String (List (VirtualDom.Attribute msg)) (List (Node msg))
    | KeyedTag String (List (VirtualDom.Attribute msg)) (List ( String, Node msg ))
    | Text String
    | Raw (Html msg)


{-| A phantom-typed attribute: an `Html.Attribute` carrying a `capability` row
recording which element capabilities admit it (`{ c | href : Supported }`,
`{ c | onClick : Supported }`, …). Producers keep the row open; an element
constructor closes it. The row is never inspected at runtime.
-}
type Attr capability msg
    = Attr (VirtualDom.Attribute msg)


{-| A phantom-tagged string token — the enum-value currency. A `Value tags`
carries an open row of the enum tags it represents (`{ v | filled : Supported }`);
a typed setter closes the row to the values its attribute admits.
-}
type Value tags
    = Value String



-- ELEMENT FORGE


{-| Wrap a `Node` as an `Element`, **inventing both phantom rows** — the caller
asserts any `accepts` kinds and any `admittedBy` contexts it likes. This is the
free assertion the whole fence exists for: combined with [`fromHtml`](#fromHtml)
it lets arbitrary `Html` claim to be anything (e.g. a `<script>` claiming to be
a text atom).

Legitimate callers: generated brand constructors (which pair it with an honest
closed row derived from config), and the brand-level escapes built on it
(`coerce`, slot placement).

-}
fromNode : Node msg -> Element accepts admittedBy msg
fromNode =
    Element


{-| Forge an `Element` straight from a tag name — [`node`](#node) fused with
[`fromNode`](#fromNode), so a custom element is a slot-ready `Element` in one call
instead of two. Like `fromNode` it **invents both phantom rows**, so the result
drops into any slot. Children are `Node`s (row-erased, hence freely mixable) — lift
an `Element` child with [`toNode`](#toNode).

For genuine web components / custom tags that have no generated brand constructor.

-}
element : String -> List (Attr capability msg) -> List (Node msg) -> Element accepts admittedBy msg
element tag attrs children =
    fromNode (node tag attrs children)



-- ATTRIBUTE FORGE


{-| Mint an `Attr` from a plain `name="value"` pair, **inventing its capability
row**. Generated setters pair this with an honest row (`href` claims
`{ c | href : Supported }`); a dishonest caller can claim anything.
-}
attribute : String -> String -> Attr capability msg
attribute name value =
    Attr (Html.Attributes.attribute name value)


{-| Mint an `Attr` that sets a JavaScript **property** (not a content
attribute), inventing its capability row. This is the custom-elements workhorse:
rich values cross into a web component as properties.
-}
property : String -> Json.Encode.Value -> Attr capability msg
property name value =
    Attr (Html.Attributes.property name value)


{-| Mint an event-listener `Attr`, inventing its capability row. Generated
event setters pair this with an honest row (`onClick` claims
`{ c | onClick : Supported }`, closed by interactive elements only). For
handlers needing `stopPropagation`/`preventDefault`, wrap the corresponding
`Html.Events` constructor with [`fromHtmlAttribute`](#fromHtmlAttribute).
-}
on : String -> Json.Decode.Decoder msg -> Attr capability msg
on event decoder =
    Attr (Html.Events.on event decoder)


{-| Wrap **any** `Html.Attribute` as an `Attr`, inventing its capability row —
the fully general attribute entry point. Covers everything the three
conveniences above don't: custom event handlers, `style`, namespaced
attributes. Note this is also the capability-**forget** primitive:
`fromHtmlAttribute (toHtmlAttribute a)` re-rows any attribute, which is exactly
how a brand implements its loud `delegate` escape.
-}
fromHtmlAttribute : Html.Attribute msg -> Attr capability msg
fromHtmlAttribute =
    Attr



-- VALUE FORGE


{-| Mint a `Value` from its string, **inventing its tag row**. Generated token
definitions pair this with an honest row (`filled = token "filled"` at
`{ v | filled : Supported }`); a dishonest caller can make `"garbage"` claim
any enum.
-}
token : String -> Value tags
token =
    Value



-- RAW-HTML ESCAPE


{-| Wrap raw `Html` as a `Node` — the point where untyped content enters the
IR. Inert on its own (a `Node` fits no typed slot), dangerous next to
[`fromNode`](#fromNode). Exists so the native brand can offer ONE loud,
greppable legacy-interop escape for incremental migration; nothing generated
should emit it on a normal path.
-}
fromHtml : Html msg -> Node msg
fromHtml =
    Raw



-- SAFE OPERATIONS (definition site)


{-| Build a tag node. Safe: the result is an untyped `Node`; only
[`fromNode`](#fromNode) can promote it to a typed `Element`. The attributes'
capability rows are erased here — they were checked when the caller's closed
attribute list unified.
-}
node : String -> List (Attr capability msg) -> List (Node msg) -> Node msg
node tag attrs children =
    Tag tag (List.map (\(Attr a) -> a) attrs) children


{-| Build a tag node whose children carry diff keys (`VirtualDom.keyedNode`) —
for lists that reorder/insert/remove, where unkeyed diffing breaks animation
and state retention. Safe for the same reason as [`node`](#node).
-}
keyedNode : String -> List (Attr capability msg) -> List ( String, Node msg ) -> Node msg
keyedNode tag attrs children =
    KeyedTag tag (List.map (\(Attr a) -> a) attrs) children


{-| A text leaf.
-}
text : String -> Node msg
text =
    Text


{-| Memoise a subtree: skip re-rendering while its inputs are referentially
unchanged (`VirtualDom.lazy`). The body returns raw `Html`, not an `Element` —
a typed subtree is `\model -> HtmlIr.Element.toHtml (myView model)` — because
memoisation compares the function and each argument by **reference**; any
per-render wrapper (an inline lambda, a packed tuple/record) allocates fresh and
silently never memoises. So the body **must be a stable top-level function** and
each argument a stable reference — exactly what `elm/html`'s `lazy` requires.
Lift the result into a slot with [`fromNode`](#fromNode). Safe: mints no row.
-}
lazy : (a -> Html msg) -> a -> Node msg
lazy f a =
    Raw (VirtualDom.lazy f a)


{-| [`lazy`](#lazy) for a two-argument view.
-}
lazy2 : (a -> b -> Html msg) -> a -> b -> Node msg
lazy2 f a b =
    Raw (VirtualDom.lazy2 f a b)


{-| [`lazy`](#lazy) for a three-argument view.
-}
lazy3 : (a -> b -> c -> Html msg) -> a -> b -> c -> Node msg
lazy3 f a b c =
    Raw (VirtualDom.lazy3 f a b c)


{-| [`lazy`](#lazy) for a four-argument view.
-}
lazy4 : (a -> b -> c -> d -> Html msg) -> a -> b -> c -> d -> Node msg
lazy4 f a b c d =
    Raw (VirtualDom.lazy4 f a b c d)


{-| [`lazy`](#lazy) for a five-argument view.
-}
lazy5 : (a -> b -> c -> d -> e -> Html msg) -> a -> b -> c -> d -> e -> Node msg
lazy5 f a b c d e =
    Raw (VirtualDom.lazy5 f a b c d e)


{-| [`lazy`](#lazy) for a six-argument view.
-}
lazy6 : (a -> b -> c -> d -> e -> g -> Html msg) -> a -> b -> c -> d -> e -> g -> Node msg
lazy6 f a b c d e g =
    Raw (VirtualDom.lazy6 f a b c d e g)


{-| [`lazy`](#lazy) for a seven-argument view.
-}
lazy7 : (a -> b -> c -> d -> e -> g -> h -> Html msg) -> a -> b -> c -> d -> e -> g -> h -> Node msg
lazy7 f a b c d e g h =
    Raw (VirtualDom.lazy7 f a b c d e g h)


{-| [`lazy`](#lazy) for an eight-argument view.
-}
lazy8 : (a -> b -> c -> d -> e -> g -> h -> i -> Html msg) -> a -> b -> c -> d -> e -> g -> h -> i -> Node msg
lazy8 f a b c d e g h i =
    Raw (VirtualDom.lazy8 f a b c d e g h i)


{-| Prepend one attribute to a node. A `Text` or `Raw` leaf cannot carry an
attribute, so each is promoted to a `<span>` that holds it — the attribute is
never silently dropped (`text "x"` given `slot="s"` becomes
`<span slot="s">x</span>`).
-}
addAttribute : Attr capability msg -> Node msg -> Node msg
addAttribute (Attr a) n =
    case n of
        Tag tag attrs children ->
            Tag tag (a :: attrs) children

        KeyedTag tag attrs children ->
            KeyedTag tag (a :: attrs) children

        Text s ->
            Tag "span" [ a ] [ Text s ]

        Raw h ->
            Tag "span" [ a ] [ Raw h ]


{-| Collapse a node tree to `Html` — the render boundary.
-}
toHtml : Node msg -> Html msg
toHtml n =
    case n of
        Tag tag attrs children ->
            VirtualDom.node tag attrs (List.map toHtml children)

        KeyedTag tag attrs children ->
            VirtualDom.keyedNode tag attrs (List.map (Tuple.mapSecond toHtml) children)

        Text s ->
            VirtualDom.text s

        Raw h ->
            h


{-| Unwrap an `Element` to its `Node`. Safe out-bound: rows are discarded,
never re-asserted.
-}
toNode : Element accepts admittedBy msg -> Node msg
toNode (Element n) =
    n


{-| Map an element's message type. Structural — rows and tree shape are
preserved (contrast the retired runtime, which rendered eagerly on map).
-}
mapElement : (a -> b) -> Element accepts admittedBy a -> Element accepts admittedBy b
mapElement f (Element n) =
    Element (mapNode f n)


{-| Map a node's message type, structurally: tag nodes map their attributes
(via `VirtualDom.mapAttribute`) and recurse; `Raw` maps with `Html.map` (lazy
in the virtual-dom). No branch renders.
-}
mapNode : (a -> b) -> Node a -> Node b
mapNode f n =
    case n of
        Tag tag attrs children ->
            Tag tag (List.map (VirtualDom.mapAttribute f) attrs) (List.map (mapNode f) children)

        KeyedTag tag attrs children ->
            KeyedTag tag (List.map (VirtualDom.mapAttribute f) attrs) (List.map (Tuple.mapSecond (mapNode f)) children)

        Text s ->
            Text s

        Raw h ->
            Raw (VirtualDom.map f h)


{-| Map an attribute's message type. Capability row preserved.
-}
mapAttribute : (a -> b) -> Attr capability a -> Attr capability b
mapAttribute f (Attr a) =
    Attr (VirtualDom.mapAttribute f a)


{-| Unwrap to the underlying `Html.Attribute`. Safe out-bound.
-}
toHtmlAttribute : Attr capability msg -> Html.Attribute msg
toHtmlAttribute (Attr a) =
    a


{-| A value token's underlying string. Safe out-bound.
-}
toString : Value tags -> String
toString (Value s) =
    s
