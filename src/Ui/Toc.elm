module Ui.Toc exposing
    ( Toc, new
    , withAttributes
    , withId, withFor, withMaxDepth
    , withTitle, withOverline
    , view
    )

{-| Typed builder for an M3 table-of-contents sidebar. Wraps
`M3e.Toc`. Pair with a content area whose id you pass to `withFor`;
m3e auto-generates the TOC items by walking that subtree's headings.

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
import M3e.Toc


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


withId : String -> Toc msg -> Toc msg
withId id (Toc cfg) =
    Toc { cfg | id = Just id }


{-| The DOM id of the content area whose headings the TOC should index.
-}
withFor : String -> Toc msg -> Toc msg
withFor forId (Toc cfg) =
    Toc { cfg | for = Just forId }


{-| How deep into the heading hierarchy the TOC should descend. m3e
treats this as a positive integer.
-}
withMaxDepth : Int -> Toc msg -> Toc msg
withMaxDepth depth (Toc cfg) =
    Toc { cfg | maxDepth = Just depth }


withTitle : Html msg -> Toc msg -> Toc msg
withTitle title (Toc cfg) =
    Toc { cfg | title = Just title }


withOverline : Html msg -> Toc msg -> Toc msg
withOverline overline (Toc cfg) =
    Toc { cfg | overline = Just overline }


view : Toc msg -> Html msg
view (Toc cfg) =
    M3e.Toc.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Maybe.map M3e.Toc.for cfg.for
                , Maybe.map (toFloat >> M3e.Toc.maxDepth) cfg.maxDepth
                ]
        )
        (List.filterMap identity
            [ Maybe.map (\o -> span [ M3e.Toc.overlineSlot ] [ o ]) cfg.overline
            , Maybe.map (\t -> span [ M3e.Toc.titleSlot ] [ t ]) cfg.title
            ]
        )
