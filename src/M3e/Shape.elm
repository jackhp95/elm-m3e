module M3e.Shape exposing
    ( Name, Option
    , view
    , name
    )

{-| `<m3e-shape>` — a clipped/shaped container.

Spec (per docs/CONVENTIONS.md):

  - Required:   { content : List (Renderable any msg) }
                (the content IS what the element is about — it clips/shapes it)
  - Options:    name (which Material 3 shape to clip to)
  - Slots:      default slot ← arbitrary content (free row; no slot is injected,
                so the raw `html` escape is valid inside `content`)
  - Properties: none (no boolean DOM properties)
  - Attrs:      name via Cem.M3e.Shape.name (codegen attr; opaque/non-introspectable)
  - Escape:     html (default-slot region; include via Renderable.html)
  - Tag:        shape

NOTE: Ui.Shape has `withClass`. Per ADR 0004, M3e components do NOT bake
classes. The `content` required field + `name` option cover the full public
surface; callers style the host element themselves.

-}

import Cem.M3e.Shape as Cem
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


{-| The set of Material 3 shape names — re-exported from `Cem.M3e.Shape`.
Use the constructors from that module directly (e.g. `Cem.M3e.Shape.Circle`).
-}
type alias Name =
    Cem.Name


type Option msg
    = ShapeName Name


{-| Clip the content to the named Material 3 shape. Omitting this option
leaves the content unclipped (the element's own default).
-}
name : Name -> Option msg
name =
    ShapeName


type alias Config =
    { name : Maybe Name }


apply : Option msg -> Config -> Config
apply opt c =
    case opt of
        ShapeName n ->
            { c | name = Just n }


view : { content : List (Renderable any msg) } -> List (Option msg) -> Renderable { s | shape : Supported } msg
view req opts =
    let
        c =
            List.foldl apply { name = Nothing } opts
    in
    Renderable.fromNode
        (Node.element "m3e-shape"
            (List.filterMap identity
                [ Maybe.map (\n -> Node.rawAttr (Cem.name n)) c.name
                ]
            )
            (List.map Renderable.toNode req.content)
        )
