module M3e.Toc exposing
    ( Option
    , view
    , maxDepth, title, overline
    )

{-| `<m3e-toc>` — a table of contents that auto-generates in-page navigation
links from the headings in a target content area and highlights the section in
view as the user scrolls.

Spec (per docs/CONVENTIONS.md):

  - Required:   { for : String }
                (`for` = the DOM id of the content area to index; a TOC without
                a target is non-functional — required by the a11y/usefulness rule)
  - Options:    maxDepth, title, overline
  - Slots:      "title" ← a `<span>` carrying the heading above the list;
                "overline" ← a `<span>` carrying the small eyebrow label
                (both are named slots — inject with Node.withSlot)
  - Properties: max-depth (DOM property, via Node.property — introspectable)
  - Attrs:      for via Node.attribute (relational — introspectable)
  - Escape:     none (leaf structure; callers style via host attributes)
  - Tag:        toc

-}

import Json.Encode as Encode
import M3e.Node as Node
import M3e.Renderable as Renderable exposing (Renderable, Supported)
import M3e.Internal as Internal


type Option msg
    = MaxDepth Int
    | Title String
    | Overline String


{-| The maximum nesting depth of the generated list (positive integer).
Omit to keep `m3e-toc`'s default of 2.
-}
maxDepth : Int -> Option msg
maxDepth =
    MaxDepth


{-| Heading shown above the generated list (e.g. "On this page") — injected
into the `title` slot inside a `<span>`.
-}
title : String -> Option msg
title =
    Title


{-| Small overline label rendered above the title — injected into the
`overline` slot inside a `<span>`.
-}
overline : String -> Option msg
overline =
    Overline


type alias Config =
    { maxDepth : Maybe Int
    , title : Maybe String
    , overline : Maybe String
    }


apply : Option msg -> Config -> Config
apply opt c =
    case opt of
        MaxDepth d ->
            { c | maxDepth = Just d }

        Title t ->
            { c | title = Just t }

        Overline o ->
            { c | overline = Just o }


view : { for : String } -> List (Option msg) -> Renderable { s | toc : Supported } msg
view req opts =
    let
        c =
            List.foldl apply
                { maxDepth = Nothing, title = Nothing, overline = Nothing }
                opts
    in
    Internal.fromNode
        (Node.element "m3e-toc"
            (List.filterMap identity
                [ Just (Node.attribute "for" req.for)
                , Maybe.map (\d -> Node.property "max-depth" (Encode.float (toFloat d))) c.maxDepth
                ]
            )
            (List.filterMap identity
                [ Maybe.map
                    (\o ->
                        Node.withSlot "overline"
                            (Node.element "span" [] [ Node.text o ])
                    )
                    c.overline
                , Maybe.map
                    (\t ->
                        Node.withSlot "title"
                            (Node.element "span" [] [ Node.text t ])
                    )
                    c.title
                ]
            )
        )
