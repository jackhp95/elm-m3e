module M3e.Skeleton exposing
    ( view
    , Shape(..), Animation(..), Option
    , loaded, shape, animation, attributes
    )

{-| `<m3e-skeleton>` — a loading placeholder that mimics content layout.

Spec (per docs/CONVENTIONS.md):

  - Required: { content : List (Renderable any msg) }
    (the content being mimicked / revealed on load)
  - Options: loaded, shape, animation
  - Slots: default slot ← arbitrary content (free row)
  - Properties: loaded — via Node.property (Cem uses Html.Attributes.property)
  - Attrs: shape, animation — via Node.rawAttr (Cem uses Html.Attributes.attribute)
  - Escape: html (default-slot region)
  - Tag: skeleton

Passing an empty `content` list is valid — the skeleton then acts as a
standalone shimmer placeholder sized by the caller's classes.

@docs view
@docs Shape, Animation, Option
@docs loaded, shape, animation, attributes

-}

import Cem.M3e.Skeleton as Cem
import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


{-| Placeholder shape. Mirrors the `m3e-skeleton` `shape` attribute. Default is
`Auto` (adapts to the mimicked content).
-}
type Shape
    = Auto
    | Circular
    | Rounded
    | Square


{-| Loading animation. Mirrors the `m3e-skeleton` `animation` attribute.
Default is `Wave`.
-}
type Animation
    = None
    | Pulse
    | Wave


{-| An option configuring a skeleton placeholder.
-}
type alias Option msg =
    Internal.Option (Config msg) msg


{-| Mark the skeleton's content as loaded (default `False`). When `True`,
the element fades out the shimmer and reveals its projected content.
Maps to the `loaded` DOM property.
-}
loaded : Bool -> Option msg
loaded b =
    Internal.option (\c -> { c | loaded = b })


{-| Set the placeholder shape (default `Auto`). Maps to the `shape` attribute.
-}
shape : Shape -> Option msg
shape s =
    Internal.option (\c -> { c | shape = Just s })


{-| Set the loading animation (default `Wave`). Maps to the `animation`
attribute.
-}
animation : Animation -> Option msg
animation a =
    Internal.option (\c -> { c | animation = Just a })


{-| Escape hatch: add raw attributes to the host element. `m3e-skeleton`'s host
is `display: contents`, so a standalone shimmer must be sized via slotted
children; this escape covers any other host-level styling. See ADR 0007.
-}
attributes : List (Node.Attr msg) -> Option msg
attributes attrs =
    Internal.option (\c -> { c | attributes = c.attributes ++ attrs })


type alias Config msg =
    { loaded : Bool
    , shape : Maybe Shape
    , animation : Maybe Animation
    , attributes : List (Node.Attr msg)
    }


{-| Render a skeleton placeholder around `content`, showing a shimmer until
`loaded` is set, then revealing the projected content.
-}
view : { content : List (Renderable any msg) } -> List (Option msg) -> Renderable { s | skeleton : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts
                { loaded = False
                , shape = Nothing
                , animation = Nothing
                , attributes = []
                }
    in
    Internal.fromNode
        (Node.element "m3e-skeleton"
            (List.filterMap identity
                [ if c.loaded then
                    Just (Node.property "loaded" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map (\s -> Node.rawAttr (Cem.shape (toCemShape s))) c.shape
                , Maybe.map (\a -> Node.rawAttr (Cem.animation (toCemAnimation a))) c.animation
                ]
                ++ c.attributes
            )
            (List.map Renderable.toNode req.content)
        )


toCemShape : Shape -> Cem.Shape
toCemShape s =
    case s of
        Auto ->
            Cem.Auto

        Circular ->
            Cem.Circular

        Rounded ->
            Cem.Rounded

        Square ->
            Cem.Square


toCemAnimation : Animation -> Cem.Animation
toCemAnimation a =
    case a of
        None ->
            Cem.None

        Pulse ->
            Cem.Pulse

        Wave ->
            Cem.Wave
