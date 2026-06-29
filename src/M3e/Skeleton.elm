module M3e.Skeleton exposing
    ( view
    , Animation, Option
    , loaded, shape, animation, attributes
    )

{-| `<m3e-skeleton>` — a loading placeholder that mimics content layout.

Spec (per docs/CONVENTIONS.md):

  - Required: { content : List (Element any msg) }
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
@docs Animation, Option
@docs loaded, shape, animation, attributes

-}

import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Value as Value exposing (Value)


{-| Placeholder shape, supplied as shared [`M3e.Value`](M3e-Value) tokens
(`auto`, `circular`, `rounded`, or `square`). Default is `auto` (adapts to the
mimicked content).
-}
type alias Shapes =
    Value
        { auto : Supported
        , circular : Supported
        , rounded : Supported
        , square : Supported
        }


{-| Loading animation, supplied as shared [`M3e.Value`](M3e-Value) tokens
([`none`](M3e-Value#none), [`pulse`](M3e-Value#pulse), or
[`wave`](M3e-Value#wave)). Mirrors the `m3e-skeleton` `animation` attribute.
The element default is `wave`.
-}
type alias Animation =
    Value
        { none : Supported
        , pulse : Supported
        , wave : Supported
        }


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


{-| Set the placeholder shape (default `auto`). Maps to the `shape` attribute.
-}
shape : Shapes -> Option msg
shape s =
    Internal.option (\c -> { c | shape = Just s })


{-| Set the loading animation (default `wave`). Maps to the `animation`
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
    , shape : Maybe Shapes
    , animation : Maybe Animation
    , attributes : List (Node.Attr msg)
    }


{-| Render a skeleton placeholder around `content`, showing a shimmer until
`loaded` is set, then revealing the projected content.
-}
view : { content : List (Element any msg) } -> List (Option msg) -> Element { s | skeleton : Supported } msg
view req opts =
    let
        c : Config msg
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
                [ Just (Node.property "loaded" (Encode.bool c.loaded))
                , Maybe.map (\s -> Node.attribute "shape" (Value.toString s)) c.shape
                , Maybe.map (\a -> Node.attribute "animation" (Value.toString a)) c.animation
                ]
                ++ c.attributes
            )
            (List.map Element.toNode req.content)
        )
