module Ui.Toc exposing
    ( Toc, new
    , withAttributes
    , withId, withFor, withMaxDepth
    , withTitle, withOverline
    , view
    )

{-| Typed builder for `<m3e-toc>` — a table of contents that links to the
sections of the current page and highlights the active one as the user
scrolls.

Reach for a TOC for **in-page navigation** down a long document. Sibling
navigation: `Ui.Breadcrumb` shows cross-page hierarchy depth, `Ui.Tabs`
switches peer views, and `Ui.Paginator` moves through pages of data.

Pair with a content area whose id you pass to `withFor`; m3e
auto-generates the TOC items by walking that subtree's headings and
highlights the section in view. To omit a heading from the generated
list, add the `m3e-toc-ignore` attribute to that heading element.

Size or otherwise style the TOC column from the call site via
`withAttributes` (the builder bakes in no layout/styling of its own).

    div []
        [ Ui.Toc.new
            |> Ui.Toc.withId "page-toc"
            |> Ui.Toc.withFor "page-content"
            |> Ui.Toc.withMaxDepth 2
            |> Ui.Toc.withTitle (text "On this page")
            |> Ui.Toc.view
        , div [ id "page-content" ]
            [-- page sections with <h2>, <h3>, etc.
            ]
        ]


# Construction

@docs Toc, new


# Host attributes

@docs withAttributes


# Identity, target, depth

@docs withId, withFor, withMaxDepth


# Slots

@docs withTitle, withOverline


# Render

@docs view

-}

import Html exposing (Attribute, Html, span)
import Html.Attributes as Attr
import Cem.M3e.Toc


{-| The TOC opaque type. Build via `new`.
-}
type Toc msg
    = Toc (Config msg)


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , for : Maybe String
    , maxDepth : Maybe Int
    , title : Maybe (Html msg)
    , overline : Maybe (Html msg)
    }


{-| Construct a fresh TOC with no target or slots configured.
-}
new : Toc msg
new =
    Toc
        { id = Nothing
        , attributes = []
        , for = Nothing
        , maxDepth = Nothing
        , title = Nothing
        , overline = Nothing
        }


{-| Append attributes to the underlying `<m3e-toc>` host element — the escape
hatch for styling/sizing the TOC column (the builder bakes in none of its own).
Structural attributes are emitted after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Toc msg -> Toc msg
withAttributes attributes (Toc cfg) =
    Toc { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` attribute.
-}
withId : String -> Toc msg -> Toc msg
withId id (Toc cfg) =
    Toc { cfg | id = Just id }


{-| The DOM id of the content area whose headings the TOC should index.
-}
withFor : String -> Toc msg -> Toc msg
withFor forId (Toc cfg) =
    Toc { cfg | for = Just forId }


{-| The maximum nesting depth of the generated table of contents, as a
positive integer; deeper headings are not listed. Omit to keep m3e's
default of `2`.
-}
withMaxDepth : Int -> Toc msg -> Toc msg
withMaxDepth depth (Toc cfg) =
    Toc { cfg | maxDepth = Just depth }


{-| Set the heading shown above the generated list, via the `title` slot
(e.g. "On this page").
-}
withTitle : Html msg -> Toc msg -> Toc msg
withTitle title (Toc cfg) =
    Toc { cfg | title = Just title }


{-| Set the small overline label rendered above the title, via the
`overline` slot — a category or eyebrow over the heading.
-}
withOverline : Html msg -> Toc msg -> Toc msg
withOverline overline (Toc cfg) =
    Toc { cfg | overline = Just overline }


{-| Render the TOC.
-}
view : Toc msg -> Html msg
view (Toc cfg) =
    Cem.M3e.Toc.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Maybe.map Cem.M3e.Toc.for cfg.for
                , Maybe.map (toFloat >> Cem.M3e.Toc.maxDepth) cfg.maxDepth
                ]
        )
        (List.filterMap identity
            [ Maybe.map (\o -> span [ Cem.M3e.Toc.overlineSlot ] [ o ]) cfg.overline
            , Maybe.map (\t -> span [ Cem.M3e.Toc.titleSlot ] [ t ]) cfg.title
            ]
        )
