module M3e.Node exposing
    ( Node(..)
    , fromComponent, addAttr, text, raw, toHtml, map
    )

{-| The lazy intermediate representation every `Element` is built from: a `Node`
is either a component (a partially-applied bottom-layer render function plus its
attributes and children), a text leaf, or an escape hatch holding raw `Html`.
Keeping construction lazy lets the typed layers above rearrange and re-slot
content before anything is rendered; [`toHtml`](#toHtml) collapses it to `Html`.

@docs Node
@docs fromComponent, addAttr, text, raw, toHtml, map

-}

import Html exposing (Html)
import M3e.Cem.Attr as Attr exposing (Attr)


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


{-| Prepend an attribute to a node. A `Text` leaf can't carry one, so it is
promoted to a `<span>` that holds the attribute (see the inline note).
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

        Raw _ ->
            node


{-| A text leaf node.
-}
text : String -> Node msg
text =
    Text


{-| Wrap raw `Html` as a node (escape hatch).
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
