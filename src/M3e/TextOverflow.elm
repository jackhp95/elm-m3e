module M3e.TextOverflow exposing (view)

{-| `<m3e-text-overflow>` — an inline container that truncates overflowing
text with an ellipsis.

Spec (per docs/CONVENTIONS.md):

  - Required: { content : List (Element any msg) }
    (content renders into the default slot)
  - Options: (none declared by CEM)
  - Slots: default ← arbitrary content (free row)
  - Properties: none
  - Attrs: none
  - Events: none
  - Escape: html (default-slot region)
  - Tag: textOverflow

@docs view

-}

import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node


{-| Render the text overflow container, placing `content` into its default slot.

    M3e.TextOverflow.view { content = [ labelText ] }

-}
view :
    { content : List (Element any msg) }
    -> Element { s | textOverflow : Supported } msg
view req =
    Internal.fromNode
        (Node.element "m3e-text-overflow"
            []
            (List.map Element.toNode req.content)
        )
