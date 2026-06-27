module M3e.Element exposing (Element, Supported, element, html, text, toNode)

{-| One content type for every slot. Each component `view` pins its own kind by
annotating its result (via `M3e.Internal.fromNode`). Two escapes:

  - `html` for default-slot REGIONS (no slot is injected, so raw Html is fine),
  - `element` for NAMED slots (you build a slot-capable element the parent can
    stamp `slot=` onto) — so the slot can never be silently dropped.

`fromNode` is NOT exposed here — it lives in `M3e.Internal` so consumers
cannot forge phantom slot tags. Components import `M3e.Internal as Internal`
and call `Internal.fromNode` to annotate their output.

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
