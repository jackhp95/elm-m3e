module Ui.TextHighlight exposing
    ( TextHighlight, new
    , withTerm
    , MatchMode(..), withMode
    , withCaseSensitive, withDisabled
    , view
    )

{-| Typed builder for M3 text highlighting. Wraps `M3e.TextHighlight`.

Visually emphasizes substrings matching a search term inside arbitrary
text content — useful for search results, autocomplete suggestions, and
filtered list rows.

    Ui.TextHighlight.new
        |> Ui.TextHighlight.withTerm model.query
        |> Ui.TextHighlight.view [ text supplier.name ]


# Construction

@docs TextHighlight, new


# Search term

@docs withTerm


# Match mode

@docs MatchMode, withMode


# Modifiers

@docs withCaseSensitive, withDisabled


# Render

@docs view

-}

import Html exposing (Html)
import M3e.TextHighlight


type TextHighlight msg
    = TextHighlight Config


{-| How the term is matched against the content.
-}
type MatchMode
    = Contains
    | StartsWith
    | EndsWith


type alias Config =
    { term : Maybe String
    , mode : MatchMode
    , caseSensitive : Bool
    , disabled : Bool
    }


new : TextHighlight msg
new =
    TextHighlight
        { term = Nothing
        , mode = Contains
        , caseSensitive = False
        , disabled = False
        }


{-| Set the search term to highlight.
-}
withTerm : String -> TextHighlight msg -> TextHighlight msg
withTerm t (TextHighlight cfg) =
    TextHighlight { cfg | term = Just t }


{-| Set the match mode. Default is `Contains`.
-}
withMode : MatchMode -> TextHighlight msg -> TextHighlight msg
withMode m (TextHighlight cfg) =
    TextHighlight { cfg | mode = m }


{-| Enable case-sensitive matching. Default is case-insensitive.
-}
withCaseSensitive : Bool -> TextHighlight msg -> TextHighlight msg
withCaseSensitive flag (TextHighlight cfg) =
    TextHighlight { cfg | caseSensitive = flag }


withDisabled : Bool -> TextHighlight msg -> TextHighlight msg
withDisabled flag (TextHighlight cfg) =
    TextHighlight { cfg | disabled = flag }


{-| Render the highlight around the given children. The term highlights
matching substrings inside the children's text content.
-}
view : List (Html msg) -> TextHighlight msg -> Html msg
view children (TextHighlight cfg) =
    M3e.TextHighlight.component
        (List.filterMap identity
            [ Maybe.map M3e.TextHighlight.term cfg.term
            , Just (toM3eMode cfg.mode)
            , if cfg.caseSensitive then
                Just (M3e.TextHighlight.caseSensitive True)

              else
                Nothing
            , if cfg.disabled then
                Just (M3e.TextHighlight.disabled True)

              else
                Nothing
            ]
        )
        children


toM3eMode : MatchMode -> Html.Attribute msg
toM3eMode m =
    case m of
        Contains ->
            (M3e.TextHighlight.mode M3e.TextHighlight.Contains)

        StartsWith ->
            (M3e.TextHighlight.mode M3e.TextHighlight.StartsWith)

        EndsWith ->
            (M3e.TextHighlight.mode M3e.TextHighlight.EndsWith)
