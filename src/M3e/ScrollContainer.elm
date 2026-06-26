module M3e.ScrollContainer exposing
    ( Dividers(..), Option
    , view
    , dividers, thin
    )

{-| `<m3e-scroll-container>` — a vertically scrollable content region
that shows dividers above/below when scrolled (utility element).

Spec (per docs/CONVENTIONS.md):

  - Required:   { content : List (Renderable any msg) }
               (arbitrary content region — the free row var means this
               cannot live in an Option, so it's in the required record)
  - Options:    dividers, thin
  - Slots:      default slot ← arbitrary content (free row; `html` escape valid)
  - Properties: thin (Node.property — introspectable/testable)
  - Attrs:      dividers (Node.attribute — enum string, non-property)
  - Escape:     html (default-slot region)
  - Tag:        scrollContainer

-}

import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)


{-| Which dividers to show when content is scrolled. -}
type Dividers
    = AboveBelow
    | Above
    | Below
    | None


type Option msg
    = DividersOpt Dividers
    | Thin Bool


{-| Set which dividers appear when content is scrolled
(default `AboveBelow`). -}
dividers : Dividers -> Option msg
dividers =
    DividersOpt


{-| Use thin scrollbars (default false). -}
thin : Bool -> Option msg
thin =
    Thin


type alias Config =
    { dividers : Dividers
    , thin : Bool
    }


apply : Option msg -> Config -> Config
apply opt c =
    case opt of
        DividersOpt d ->
            { c | dividers = d }

        Thin b ->
            { c | thin = b }


view :
    { content : List (Renderable any msg) }
    -> List (Option msg)
    -> Renderable { s | scrollContainer : Supported } msg
view req opts =
    let
        c =
            List.foldl apply { dividers = AboveBelow, thin = False } opts
    in
    Renderable.fromNode
        (Node.element "m3e-scroll-container"
            (List.filterMap identity
                [ Just (Node.attribute "dividers" (dividersToString c.dividers))
                , if c.thin then
                    Just (Node.property "thin" (Encode.bool True))

                  else
                    Nothing
                ]
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
