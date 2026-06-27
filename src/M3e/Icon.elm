module M3e.Icon exposing (view)

{-| `<m3e-icon>` — a single Material Symbol. The glyph rides the `name`
ATTRIBUTE (the element has no slot for it; passing it as a child is the F1 bug).
Option-less, so `view` takes only its required record.

@docs view

-}

import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable exposing (Renderable, Supported)


{-| Build the `<m3e-icon>` IR node. The `name` is the Material Symbol glyph
name, set on the `name` attribute.
-}
view : { name : String } -> Renderable { s | icon : Supported } msg
view req =
    Internal.fromNode (Node.element "m3e-icon" [ Node.attribute "name" req.name ] [])
