module Ux.ChipSet exposing (ChipSet, Item, new, withChips, toNode)

{-| Strict container: accepted set is `{ chip }` only — no escape at all. -}

import Ux.Node as Node exposing (Node)
import Ux.Renderable as Renderable exposing (Renderable, Supported)


type ChipSet msg
    = ChipSet { chips : List (Node msg) }


type alias Item msg =
    Renderable { chip : Supported } msg


new : ChipSet msg
new =
    ChipSet { chips = [] }


withChips : List (Item msg) -> ChipSet msg -> ChipSet msg
withChips items (ChipSet cfg) =
    ChipSet { cfg | chips = List.map Renderable.toNode items }


toNode : ChipSet msg -> Node msg
toNode (ChipSet cfg) =
    Node.element "m3e-chip-set" [ Node.attribute "role" "group" ] cfg.chips
