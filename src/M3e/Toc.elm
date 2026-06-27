module M3e.Toc exposing
    ( view
    , Option
    , maxDepth, title, overline
    )

{-| `<m3e-toc>` — a table of contents that auto-generates in-page navigation
links from the headings in a target content area and highlights the section in
view as the user scrolls.

Spec (per docs/CONVENTIONS.md):

  - Required: { for : String }
    (`for` = the DOM id of the content area to index; a TOC without
    a target is non-functional — required by the a11y/usefulness rule)
  - Options: maxDepth, title, overline
  - Slots: "title" ← a `<span>` carrying the heading above the list;
    "overline" ← a `<span>` carrying the small eyebrow label
    (both are named slots — inject with Node.withSlot)
  - Properties: max-depth (DOM property, via Node.property — introspectable)
  - Attrs: for via Node.attribute (relational — introspectable)
  - Escape: none (leaf structure; callers style via host attributes)
  - Tag: toc

@docs view
@docs Option
@docs maxDepth, title, overline

-}

import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node
import M3e.Renderable exposing (Renderable, Supported)


{-| An option configuring the `<m3e-toc>` element.
-}
type alias Option msg =
    Internal.Option Config msg


{-| The maximum nesting depth of the generated list (positive integer).
Omit to keep `m3e-toc`'s default of 2.
-}
maxDepth : Int -> Option msg
maxDepth d =
    Internal.option (\c -> { c | maxDepth = Just d })


{-| Heading shown above the generated list (e.g. "On this page") — injected
into the `title` slot inside a `<span>`.
-}
title : String -> Option msg
title t =
    Internal.option (\c -> { c | title = Just t })


{-| Small overline label rendered above the title — injected into the
`overline` slot inside a `<span>`.
-}
overline : String -> Option msg
overline o =
    Internal.option (\c -> { c | overline = Just o })


type alias Config =
    { maxDepth : Maybe Int
    , title : Maybe String
    , overline : Maybe String
    }


{-| Render the table of contents, indexing the content area named by `for`.
-}
view : { for : String } -> List (Option msg) -> Renderable { s | toc : Supported } msg
view req opts =
    let
        c : Config
        c =
            Internal.applyOptions opts
                { maxDepth = Nothing, title = Nothing, overline = Nothing }
    in
    Internal.fromNode
        (Node.element "m3e-toc"
            (List.filterMap identity
                [ Just (Node.attribute "for" req.for)
                , Maybe.map (\d -> Node.property "maxDepth" (Encode.float (toFloat d))) c.maxDepth
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
