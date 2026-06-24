module Ui.Toc exposing
    ( Toc, new
    , withId, withFor, withMaxDepth
    , withTitle, withOverline
    , view
    )

{-| Typed builder for an M3 table-of-contents sidebar. Wraps
`M3e.Toc`. Pair with a content area whose id you pass to `withFor`;
m3e auto-generates the TOC items by walking that subtree's headings.

Note: `view` emits a `ui-toc-auto-width` CSS class. That is a project
layout class (not a Material/CEM attribute) used to size the TOC column;
it has no effect on the underlying `<m3e-toc>` element's behaviour.

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


# Identity, target, depth

@docs withId, withFor, withMaxDepth


# Slots

@docs withTitle, withOverline


# Render

@docs view

-}

import Html exposing (Html, span)
import Html.Attributes as Attr
import M3e.Toc


type Toc msg
    = Toc (Config msg)


type alias Config msg =
    { id : Maybe String
    , for : Maybe String
    , maxDepth : Maybe Int
    , title : Maybe (Html msg)
    , overline : Maybe (Html msg)
    }


new : Toc msg
new =
    Toc
        { id = Nothing
        , for = Nothing
        , maxDepth = Nothing
        , title = Nothing
        , overline = Nothing
        }


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
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Maybe.map M3e.Toc.for cfg.for
            , Maybe.map (toFloat >> M3e.Toc.maxDepth) cfg.maxDepth
            , Just (Attr.class "ui-toc-auto-width")
            ]
        )
        (List.filterMap identity
            [ Maybe.map (\o -> span [ M3e.Toc.overlineSlot ] [ o ]) cfg.overline
            , Maybe.map (\t -> span [ M3e.Toc.titleSlot ] [ t ]) cfg.title
            ]
        )
