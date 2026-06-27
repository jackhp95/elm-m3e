module M3e.ScrollContainer exposing
    ( Dividers(..)
    , Option
    , attributes
    , dividers
    , thin
    , view
    )

{-| `<m3e-scroll-container>` — a vertically scrollable content region
that shows dividers above/below when scrolled (utility element).

Spec (per docs/CONVENTIONS.md):

  - Required: { content : List (Renderable any msg) }
    (arbitrary content region — the free row var means this
    cannot live in an Option, so it's in the required record)
  - Options: dividers, thin
  - Slots: default slot ← arbitrary content (free row; `html` escape valid)
  - Properties: thin (Node.property — introspectable/testable)
  - Attrs: dividers (Node.attribute — enum string, non-property)
  - Escape: html (default-slot region)
  - Tag: scrollContainer

-}

import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


{-| Which dividers to show when content is scrolled.
-}
type Dividers
    = AboveBelow
    | Above
    | Below
    | None


type alias Option msg =
    Internal.Option (Config msg) msg


{-| Set which dividers appear when content is scrolled
(default `AboveBelow`).
-}
dividers : Dividers -> Option msg
dividers d =
    Internal.option (\c -> { c | dividers = d })


{-| Use thin scrollbars (default false).
-}
thin : Bool -> Option msg
thin b =
    Internal.option (\c -> { c | thin = b })


{-| Escape hatch: add raw attributes to the host element. The host
(`:host { display: block }`) does not stretch on its own, so this is how a
caller gives it a height (`Node.rawAttr (class "h-full")`) or any other
host-level styling.
-}
attributes : List (Node.Attr msg) -> Option msg
attributes attrs =
    Internal.option (\c -> { c | attributes = c.attributes ++ attrs })


type alias Config msg =
    { dividers : Dividers
    , thin : Bool
    , attributes : List (Node.Attr msg)
    }


view :
    { content : List (Renderable any msg) }
    -> List (Option msg)
    -> Renderable { s | scrollContainer : Supported } msg
view req opts =
    let
        c =
            Internal.applyOptions opts { dividers = AboveBelow, thin = False, attributes = [] }
    in
    Internal.fromNode
        (Node.element "m3e-scroll-container"
            (List.filterMap identity
                [ Just (Node.attribute "dividers" (dividersToString c.dividers))
                , if c.thin then
                    Just (Node.property "thin" (Encode.bool True))

                  else
                    Nothing
                ]
                ++ c.attributes
            )
            (List.map Renderable.toNode req.content)
        )


dividersToString : Dividers -> String
dividersToString d =
    case d of
        AboveBelow ->
            "above-below"

        Above ->
            "above"

        Below ->
            "below"

        None ->
            "none"
