module M3e.AppBar exposing (AppBar, Trailing, new, withTrailing, toNode)

{-| `Trailing` accepts the spec kinds plus the slot-capable `element` escape —
NOT the raw `html` escape, because a parent must stamp `slot="trailing"` onto
each child, which it can only do to an element. So the slot can never be dropped.
-}

import M3e.Node as Node exposing (Node)
import M3e.Renderable as Renderable exposing (Renderable, Supported)


type AppBar msg
    = AppBar { trailing : List (Node msg) }


type alias Trailing msg =
    Renderable
        { iconButton : Supported
        , search : Supported
        , avatar : Supported
        , element : Supported
        }
        msg


new : AppBar msg
new =
    AppBar { trailing = [] }


withTrailing : List (Trailing msg) -> AppBar msg -> AppBar msg
withTrailing items (AppBar cfg) =
    AppBar { cfg | trailing = List.map (Renderable.toNode >> Node.withSlot "trailing") items }


toNode : AppBar msg -> Node msg
toNode (AppBar cfg) =
    Node.element "m3e-app-bar" [] cfg.trailing
