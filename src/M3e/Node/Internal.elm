module M3e.Node.Internal exposing
    ( Node(..)
    , fromComponent, addAttr, addChild, text, raw, toHtml, map
    )

{-| The **unfenced** interior of [`M3e.Node`](M3e-Node): the opaque `Node` type
_with its constructors_ plus every operation, including the raw-`Html` escape
[`raw`](#raw). Importable only by generated `M3e.*` code and a team's `Seam`
module (enforced by `NoInternalImportOutsideAllowed`); userland sees `Node` as an
opaque type through [`M3e.Node`](M3e-Node), which withholds both the constructors
and `raw` so arbitrary `Html` cannot be smuggled into the IR outside the seam.

@docs Node
@docs fromComponent, addAttr, addChild, text, raw, toHtml, map

-}

import Html exposing (Html)
import M3e.Html.Attr as Attr exposing (Attr)


{-| An `Element`-branch, a `Text` leaf, or a `Raw` `Html` escape hatch.
-}
type Node msg
    = Element
        { component : List (Attr () msg) -> List (Html msg) -> Html msg
        , attrs : List (Attr () msg)
        , children : List (Node msg)
        }
    | Text String
    | Raw (Html msg)


{-| Build an element node from a bottom-layer component function, its attributes,
and its child nodes.
-}
fromComponent : (List (Attr () msg) -> List (Html msg) -> Html msg) -> List (Attr () msg) -> List (Node msg) -> Node msg
fromComponent component attrs children =
    Element { component = component, attrs = attrs, children = children }


{-| Prepend an attribute to a node. `Text` and `Raw` leaves can't carry one, so
each is promoted to a `<span>` that holds the attribute (see the inline notes) —
the attribute is never silently dropped.
-}
addAttr : Attr () msg -> Node msg -> Node msg
addAttr a node =
    case node of
        Element d ->
            Element { d | attrs = a :: d.attrs }

        Text s ->
            -- A text node can't carry an attribute (slot=, class=, …), so applying one
            -- would silently drop it. Promote the text to a <span> that holds the
            -- attribute — so `text "x"` placed in a named slot becomes
            -- `<span slot="x">x</span>` automatically, with no userland wrapping.
            Element
                { component = \attrs kids -> Html.span (List.map Attr.toAttribute attrs) kids
                , attrs = [ a ]
                , children = [ Text s ]
                }

        Raw h ->
            -- A Raw node holds opaque Html and can't take an attribute directly, so
            -- dropping it would silently misplace slotted content (e.g. a mapped
            -- element given a `slot=` would land in the default slot). Promote it to
            -- a <span> that carries the attribute and wraps the raw Html — mirroring
            -- the Text case.
            Element
                { component = \attrs _ -> Html.span (List.map Attr.toAttribute attrs) [ h ]
                , attrs = [ a ]
                , children = []
                }


{-| Append a child Node to an Element node's children list. If the target Node
is a `Text` or `Raw` leaf, no-op (leaves can't hold children). Used by generated
Build slot setters.
-}
addChild : Node msg -> Node msg -> Node msg
addChild child parent =
    case parent of
        Element rec ->
            Element { rec | children = rec.children ++ [ child ] }

        Text _ ->
            parent

        Raw _ ->
            parent


{-| A text leaf node.
-}
text : String -> Node msg
text =
    Text


{-| Wrap raw `Html` as a node (escape hatch). This is the point where untyped
`Html` enters the IR, so it lives here, out of `M3e.Node`'s public surface.
-}
raw : Html msg -> Node msg
raw =
    Raw


{-| Collapse the lazy node tree to `Html`.
-}
toHtml : Node msg -> Html msg
toHtml node =
    case node of
        Element d ->
            d.component d.attrs (List.map toHtml d.children)

        Text s ->
            Html.text s

        Raw h ->
            h


{-| Map the message type. The IR stores partially-applied bottom-layer functions
(monomorphic in msg), so a structural remap isn't possible; instead this renders
to `Html` and crosses the boundary with `Html.map` (eager, like any msg boundary).
-}
map : (a -> b) -> Node a -> Node b
map f node =
    Raw (Html.map f (toHtml node))
