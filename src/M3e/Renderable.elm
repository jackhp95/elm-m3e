module M3e.Renderable exposing (Renderable, Supported, fromNode, toNode, html, element)

{-| One content type for every slot. Each component `view` pins its own kind by
ANNOTATING its result (via `fromNode`). Two escapes:

  - `html` for default-slot REGIONS (no slot is injected, so raw Html is fine),
  - `element` for NAMED slots (you build a slot-capable element the parent can
    stamp `slot=` onto) — so the slot can never be silently dropped.

-}

import Html exposing (Html)
import M3e.Node as Node exposing (Node)


type Renderable supported msg
    = Renderable (Node msg)


type Supported
    = Supported


{-| Internal primitive: a component annotates the result to fix its tag. In the
published package this lives in an unexposed `M3e.Internal` module so consumers
can't forge tags; exposed here for the prototype.
-}
fromNode : Node msg -> Renderable any msg
fromNode =
    Renderable


toNode : Renderable supported msg -> Node msg
toNode (Renderable n) =
    n


html : Html msg -> Renderable { s | html : Supported } msg
html h =
    Renderable (Node.raw h)


element : { tag : String } -> List (Node.Attr msg) -> List (Node msg) -> Renderable { s | element : Supported } msg
element config attrs children =
    Renderable (Node.element config.tag attrs children)
