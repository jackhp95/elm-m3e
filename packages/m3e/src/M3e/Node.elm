module M3e.Node exposing (Node(..), fromComponent, addAttr, text, raw, toHtml, map)

import Html exposing (Html)
import M3e.Cem.Attr as Attr exposing (Attr)

type Node msg
    = Element
        { component : List (Attr () msg) -> List (Html msg) -> Html msg
        , attrs : List (Attr () msg)
        , children : List (Node msg)
        }
    | Text String
    | Raw (Html msg)

fromComponent : (List (Attr () msg) -> List (Html msg) -> Html msg) -> List (Attr () msg) -> List (Node msg) -> Node msg
fromComponent component attrs children =
    Element { component = component, attrs = attrs, children = children }

addAttr : Attr () msg -> Node msg -> Node msg
addAttr a node =
    case node of
        Element d -> Element { d | attrs = a :: d.attrs }
        _ -> node

text : String -> Node msg
text = Text

raw : Html msg -> Node msg
raw = Raw

toHtml : Node msg -> Html msg
toHtml node =
    case node of
        Element d -> d.component d.attrs (List.map toHtml d.children)
        Text s -> Html.text s
        Raw h -> h

{-| Map the message type. The IR stores partially-applied bottom-layer functions
(monomorphic in msg), so a structural remap isn't possible; instead this renders
to `Html` and crosses the boundary with `Html.map` (eager, like any msg boundary). -}
map : (a -> b) -> Node a -> Node b
map f node = Raw (Html.map f (toHtml node))
