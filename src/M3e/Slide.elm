module M3e.Slide exposing
    ( Option
    , view, slide
    , disabled, vertical, threshold
    )

{-| `<m3e-slide-group>` / `<m3e-slide>` — a horizontal (or vertical) slide
group with directional pagination controls.

Spec (per docs/CONVENTIONS.md):

  - Required: { slides : List (Renderable { slide : Supported } msg) }
    (homogeneous list slot — a slide group is meaningless without
    slides; typed list constrains children to `slide`-tagged nodes)
  - Options: disabled, vertical, threshold
  - Slots: default slot ← `m3e-slide` children (no slot= injection)
  - Properties: disabled, vertical, threshold — via Node.property (introspectable)
  - Attrs: none (all configurable state is via DOM property)
  - Escape: html (inside each individual slide's content region)
  - Tag: slide (module tag; the `slide` helper also carries this tag)


## Child constructor

`slide content` wraps arbitrary `Renderable` content in an `<m3e-slide>`
element and returns a `Renderable { s | slide : Supported }` that can be
placed in the `slides` list.

@docs Option
@docs view, slide
@docs disabled, vertical, threshold

-}

import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


{-| Configuration option for a slide group, built by the helpers below.
-}
type alias Option msg =
    Internal.Option Config msg


{-| Disable the pagination buttons (content still renders, controls go inert).
-}
disabled : Bool -> Option msg
disabled b =
    Internal.option (\c -> { c | disabled = b })


{-| Set vertical orientation — content flows top-to-bottom (default: false).
-}
vertical : Bool -> Option msg
vertical b =
    Internal.option (\c -> { c | vertical = b })


{-| Scroll threshold in pixels at which the pagination controls begin to show
(default: 0).
-}
threshold : Float -> Option msg
threshold px =
    Internal.option (\c -> { c | threshold = Just px })


type alias Config =
    { disabled : Bool
    , vertical : Bool
    , threshold : Maybe Float
    }


{-| Wrap arbitrary content in an `<m3e-slide>` element — the child unit of a
slide group. Pass a list of `Renderable` children as the slide's content.
-}
slide : List (Renderable any msg) -> Renderable { s | slide : Supported } msg
slide content =
    Internal.fromNode
        (Node.element "m3e-slide"
            []
            (List.map Renderable.toNode content)
        )


{-| Render a slide group from a list of `slide` children, with directional
pagination controls.
-}
view :
    { slides : List (Renderable { slide : Supported } msg) }
    -> List (Option msg)
    -> Renderable { s | slide : Supported } msg
view req opts =
    let
        c : Config
        c =
            Internal.applyOptions opts
                { disabled = False, vertical = False, threshold = Nothing }
    in
    Internal.fromNode
        (Node.element "m3e-slide-group"
            (List.filterMap identity
                [ if c.disabled then
                    Just (Node.property "disabled" (Encode.bool True))

                  else
                    Nothing
                , if c.vertical then
                    Just (Node.property "vertical" (Encode.bool True))

                  else
                    Nothing
                , Maybe.map (\px -> Node.property "threshold" (Encode.float px)) c.threshold
                ]
            )
            (List.map Renderable.toNode req.slides)
        )
