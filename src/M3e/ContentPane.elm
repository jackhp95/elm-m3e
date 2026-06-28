module M3e.ContentPane exposing (view)

{-| `<m3e-content-pane>` — a shaped, vertically scrollable surface.

Spec (per docs/CONVENTIONS.md):

  - Required: { content : List (Element any msg) }
    (content renders into the default slot)
  - Options: (none declared by CEM)
  - Slots: default ← arbitrary content (free row)
  - Properties: none
  - Attrs: none
  - Events: none
  - Escape: html (default-slot region)
  - Tag: contentPane

@docs view

-}

import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| Render the content pane, placing `content` into its default slot.

    M3e.ContentPane.view { content = [ bodyText ] }

-}
view :
    { content : List (Element any msg) }
    -> Element { s | contentPane : Supported } msg
view req =
    Internal.fromNode
        (Node.element "m3e-content-pane"
            []
            (List.map Element.toNode req.content)
        )
