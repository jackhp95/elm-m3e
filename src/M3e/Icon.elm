module M3e.Icon exposing (view)

{-| `<m3e-icon>` — a single Material Symbol. The glyph rides the `name`
ATTRIBUTE (the element has no slot for it; passing it as a child is the F1 bug).
Option-less, so `view` takes only its required record.
-}

import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)
import M3e.Internal as Internal


view : { name : String } -> Renderable { s | icon : Supported } msg
view req =
    Internal.fromNode (Node.element "m3e-icon" [ Node.attribute "name" req.name ] [])
