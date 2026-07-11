module M3e.Node exposing
    ( Node
    , fromComponent, addAttr, addChild, text, toHtml, map
    )

{-| The lazy intermediate representation every `Element` is built from: a `Node`
is either a component (a partially-applied bottom-layer render function plus its
attributes and children), a text leaf, or an escape hatch holding raw `Html`.
Keeping construction lazy lets the typed layers above rearrange and re-slot
content before anything is rendered; [`toHtml`](#toHtml) collapses it to `Html`.

The type is **opaque** and the raw-`Html` constructor (`raw`) is _not_
re-exported here — both live in [`M3e.Node.Internal`](M3e-Node-Internal),
reachable only by generated `M3e.*` code and a team's `Seam` module. The typed
builders, the extraction [`toHtml`](#toHtml), and `map` stay public.

@docs Node
@docs fromComponent, addAttr, addChild, text, toHtml, map

-}

import Html exposing (Html)
import M3e.Html.Attr exposing (Attr)
import M3e.Node.Internal as I


{-| The opaque lazy IR node, re-exported from
[`M3e.Node.Internal`](M3e-Node-Internal). Construct one with the typed builders
below (or, inside a `Seam`, with the internal `raw` escape).
-}
type alias Node msg =
    I.Node msg


{-| Build an element node from a bottom-layer component function, its attributes,
and its child nodes.
-}
fromComponent : (List (Attr () msg) -> List (Html msg) -> Html msg) -> List (Attr () msg) -> List (Node msg) -> Node msg
fromComponent =
    I.fromComponent


{-| Prepend an attribute to a node. `Text` and `Raw` leaves are promoted to a
`<span>` that holds the attribute — the attribute is never silently dropped.
-}
addAttr : Attr () msg -> Node msg -> Node msg
addAttr =
    I.addAttr


{-| Append a child Node to an Element node's children list; a no-op on `Text`/`Raw`
leaves. Used by generated Build slot setters.
-}
addChild : Node msg -> Node msg -> Node msg
addChild =
    I.addChild


{-| A text leaf node.
-}
text : String -> Node msg
text =
    I.text


{-| Collapse the lazy node tree to `Html`.
-}
toHtml : Node msg -> Html msg
toHtml =
    I.toHtml


{-| Map the message type (eager render across the msg boundary — see
[`M3e.Node.Internal.map`](M3e-Node-Internal#map)).
-}
map : (a -> b) -> Node a -> Node b
map =
    I.map
