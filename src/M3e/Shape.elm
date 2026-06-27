module M3e.Shape exposing
    ( view
    , Name, Option
    , name, attributes
    )

{-| `<m3e-shape>` — a clipped/shaped container.

Spec (per docs/CONVENTIONS.md):

  - Required: { content : List (Renderable any msg) }
    (the content IS what the element is about — it clips/shapes it)
  - Options: name (which Material 3 shape to clip to)
  - Slots: default slot ← arbitrary content (free row; no slot is injected,
    so the raw `html` escape is valid inside `content`)
  - Properties: none (no boolean DOM properties)
  - Attrs: name via Cem.M3e.Shape.name (codegen attr; opaque/non-introspectable)
  - Escape: html (default-slot region; include via Renderable.html)
  - Tag: shape

NOTE: `m3e-shape`'s host hard-sets `width: var(--m3e-shape-size, 3rem)` with
`aspect-ratio: 1/1`, so a caller that needs non-default dimensions must style
the host. Per ADR 0007 that goes through the `attributes` escape
(`Node.rawAttr (class "h-36 w-full")`), not a baked class.

@docs view
@docs Name, Option
@docs name, attributes

-}

import Cem.M3e.Shape as Cem
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


{-| The set of Material 3 shape names — re-exported from `Cem.M3e.Shape`.
Use the constructors from that module directly (e.g. `Cem.M3e.Shape.Circle`).
-}
type alias Name =
    Cem.Name


{-| An option configuring a shape container.
-}
type alias Option msg =
    Internal.Option (Config msg) msg


{-| Clip the content to the named Material 3 shape. Omitting this option
leaves the content unclipped (the element's own default).
-}
name : Name -> Option msg
name n =
    Internal.option (\c -> { c | name = Just n })


{-| Escape hatch: add raw attributes to the host element — the canonical way to
size the shape (`Node.rawAttr (class "h-36 w-full")`), since its host has a
fixed default width. See ADR 0007.
-}
attributes : List (Node.Attr msg) -> Option msg
attributes attrs =
    Internal.option (\c -> { c | attributes = c.attributes ++ attrs })


type alias Config msg =
    { name : Maybe Name
    , attributes : List (Node.Attr msg)
    }


{-| Render a shape container clipping `content` to the named Material 3 shape.
-}
view : { content : List (Renderable any msg) } -> List (Option msg) -> Renderable { s | shape : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts { name = Nothing, attributes = [] }
    in
    Internal.fromNode
        (Node.element "m3e-shape"
            (List.filterMap identity
                [ Maybe.map (\n -> Node.rawAttr (Cem.name n)) c.name
                ]
                ++ c.attributes
            )
            (List.map Renderable.toNode req.content)
        )
