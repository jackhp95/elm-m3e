module M3e.Card exposing (Card, new, withBody, toNode)

{-| Default-slot region: a FREE row, so anything goes — including the raw `html`
escape (no slot is injected here, so raw Html is fine).
-}

import M3e.Node as Node exposing (Node)
import M3e.Renderable as Renderable exposing (Renderable)


type Card msg
    = Card { body : List (Node msg) }


new : Card msg
new =
    Card { body = [] }


withBody : List (Renderable any msg) -> Card msg -> Card msg
withBody items (Card cfg) =
    Card { cfg | body = List.map Renderable.toNode items }


toNode : Card msg -> Node msg
toNode (Card cfg) =
    Node.element "m3e-card" [] cfg.body
