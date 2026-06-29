module M3e.Shape exposing
    ( view
    , Name, Option
    , name, attributes
    )

{-| `<m3e-shape>` — a clipped/shaped container.

Spec (per docs/CONVENTIONS.md):

  - Required: { content : List (Element any msg) }
    (the content IS what the element is about — it clips/shapes it)
  - Options: name (which Material 3 shape to clip to)
  - Slots: default slot ← arbitrary content (free row; no slot is injected,
    so the raw `html` escape is valid inside `content`)
  - Properties: none (no boolean DOM properties)
  - Attrs: name via Node.attribute "name" (shared M3e.Value token)
  - Escape: html (default-slot region; include via Element.html)
  - Tag: shape

NOTE: `m3e-shape`'s host hard-sets `width: var(--m3e-shape-size, 3rem)` with
`aspect-ratio: 1/1`, so a caller that needs non-default dimensions must style
the host. Per ADR 0007 that goes through the `attributes` escape
(`Node.rawAttr (class "h-36 w-full")`), not a baked class.

@docs view
@docs Name, Option
@docs name, attributes

-}

import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Value as Value exposing (Value)


{-| The set of Material 3 shape names, supplied as shared
[`M3e.Value`](M3e-Value) tokens (e.g. [`Value.circle`](M3e-Value#circle),
[`Value.heart`](M3e-Value#heart), [`Value.value12SidedCookie`](M3e-Value#value12SidedCookie)).
-}
type alias Name =
    Value
        { value12SidedCookie : Supported
        , value4LeafClover : Supported
        , value4SidedCookie : Supported
        , value6SidedCookie : Supported
        , value7SidedCookie : Supported
        , value8LeafClover : Supported
        , value9SidedCookie : Supported
        , arch : Supported
        , arrow : Supported
        , boom : Supported
        , bun : Supported
        , burst : Supported
        , circle : Supported
        , diamond : Supported
        , fan : Supported
        , flower : Supported
        , gem : Supported
        , ghostIsh : Supported
        , heart : Supported
        , hexagon : Supported
        , oval : Supported
        , pentagon : Supported
        , pill : Supported
        , pixelCircle : Supported
        , pixelTriangle : Supported
        , puffy : Supported
        , puffyDiamond : Supported
        , semicircle : Supported
        , slanted : Supported
        , softBoom : Supported
        , softBurst : Supported
        , square : Supported
        , sunny : Supported
        , triangle : Supported
        , verySunny : Supported
        }


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
view : { content : List (Element any msg) } -> List (Option msg) -> Element { s | shape : Supported } msg
view req opts =
    let
        c : Config msg
        c =
            Internal.applyOptions opts { name = Nothing, attributes = [] }
    in
    Internal.fromNode
        (Node.element "m3e-shape"
            (List.filterMap identity
                [ Maybe.map (\n -> Node.attribute "name" (Value.toString n)) c.name
                ]
                ++ c.attributes
            )
            (List.map Element.toNode req.content)
        )
