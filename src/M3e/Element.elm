module M3e.Element exposing (Element, Supported, element, fromNode, html, text, toNode)

{-| One content type for every slot. Each component `view` pins its own kind by
annotating its result (via `M3e.Internal.fromNode`). Two escapes:

  - `html` for default-slot REGIONS (no slot is injected, so raw Html is fine),
  - `element` for NAMED slots (you build a slot-capable element the parent can
    stamp `slot=` onto) — so the slot can never be silently dropped.

`fromNode` is also exposed here for use in `Shared.view` where a `Node msg`
wrapping a whole page-body subtree needs to be passed into a component slot
(e.g. `Theme.view { content = List.map Element.fromNode nodes }`). Component
modules should still use `M3e.Internal.fromNode` to keep their phantom tags
unforgeable by general consumers.

@docs Element, Supported, element, fromNode, html, text, toNode

-}

import Html exposing (Html)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)


{-| Transparent alias for `M3e.Internal.Element`. Public consumers use this
name; the canonical definition lives in Internal.
-}
type alias Element supported msg =
    Internal.Element supported msg


{-| Transparent alias for `M3e.Internal.Supported`.
-}
type alias Supported =
    Internal.Supported


{-| Unwrap to the underlying `Node` for composition or rendering.
-}
toNode : Element supported msg -> Node msg
toNode =
    Internal.toNode


{-| Wrap a `Node` as an unconstrained `Element`. The phantom slot type is left
fully polymorphic (`any`), so the result fits any slot. Use this in
`Shared.view` to feed a pre-built `Node` tree into a component slot like
`Theme.view { content = List.map Element.fromNode nodes }`.

Do NOT use this in component modules to annotate their own output — use
`M3e.Internal.fromNode` there so the phantom tag remains precise and unforgeable.

-}
fromNode : Node msg -> Element any msg
fromNode =
    Internal.fromNode


{-| Lift raw `Html` into an element that fits any **default-slot region**
(`{ s | html : Supported }`). Do NOT use this in named slots — the slot
attribute can't be stamped onto opaque `Html`.
-}
html : Html msg -> Element { s | html : Supported } msg
html h =
    Internal.fromNode (Node.raw h)


{-| Build a named-slot-capable element. The parent can stamp `slot=` onto this
node because it is a real IR element (not opaque `Html`).
-}
element : { tag : String } -> List (Node.Attr msg) -> List (Node msg) -> Element { s | element : Supported } msg
element config attrs children =
    Internal.fromNode (Node.element config.tag attrs children)


{-| A bit of text as a slottable element — `<span>text</span>`. The terse tier-1
for the common "just words" case of a named slot (a field hint, a chip label):
a bare `String` has no element to carry the injected `slot=`, but this does.
-}
text : String -> Element { s | element : Supported } msg
text content =
    element { tag = "span" } [] [ Node.text content ]
