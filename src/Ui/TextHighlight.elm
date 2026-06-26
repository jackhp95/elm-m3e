module Ui.TextHighlight exposing
    ( TextHighlight, new
    , withAttributes
    , withTerm
    , MatchMode(..), withMode
    , withCaseSensitive, withDisabled
    , view
    )

{-| Typed builder for `<m3e-text-highlight>`. Wraps `Cem.M3e.TextHighlight`.

**Utility element — outside the documented Material component set.**
`m3e-text-highlight` is not one of the 53 documented Material 3
components; it ships only as a vendor binding (`Cem.M3e.TextHighlight`) as a
text-rendering helper. It is kept here for parity with the vendor
surface, but it does not correspond to a documented Material component,
so it sits outside the "one module per documented component" map.

Visually emphasizes substrings matching a search term inside arbitrary
text content — useful for search results, autocomplete suggestions, and
filtered list rows.

    Ui.TextHighlight.new
        |> Ui.TextHighlight.withTerm model.query
        |> Ui.TextHighlight.view [ text supplier.name ]


# Construction

@docs TextHighlight, new


# Host attributes

@docs withAttributes


# Search term

@docs withTerm


# Match mode

@docs MatchMode, withMode


# Modifiers

@docs withCaseSensitive, withDisabled


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Cem.M3e.TextHighlight


{-| The text highlight opaque type. Build via `new`.
-}
type TextHighlight msg
    = TextHighlight (Config msg)


{-| How the term is matched against the content.
-}
type MatchMode
    = Contains
    | StartsWith
    | EndsWith


type alias Config msg =
    { attributes : List (Attribute msg)
    , term : Maybe String
    , mode : MatchMode
    , caseSensitive : Bool
    , disabled : Bool
    }


{-| Construct a fresh text highlight with no term (a no-op until set).
-}
new : TextHighlight msg
new =
    TextHighlight
        { attributes = []
        , term = Nothing
        , mode = Contains
        , caseSensitive = False
        , disabled = False
        }


{-| Append attributes to the underlying `<m3e-text-highlight>` host element —
the escape hatch for styling the component itself. Structural attributes are
emitted after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> TextHighlight msg -> TextHighlight msg
withAttributes attributes (TextHighlight cfg) =
    TextHighlight { cfg | attributes = cfg.attributes ++ attributes }


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


{-| Disable highlighting (renders the children unaltered).
-}
withDisabled : Bool -> TextHighlight msg -> TextHighlight msg
withDisabled flag (TextHighlight cfg) =
    TextHighlight { cfg | disabled = flag }


{-| Render the highlight around the given children. The term highlights
matching substrings inside the children's text content.
-}
view : List (Html msg) -> TextHighlight msg -> Html msg
view children (TextHighlight cfg) =
    Cem.M3e.TextHighlight.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Cem.M3e.TextHighlight.term cfg.term
                , Just (toM3eMode cfg.mode)
                , if cfg.caseSensitive then
                    Just (Cem.M3e.TextHighlight.caseSensitive True)

                  else
                    Nothing
                , if cfg.disabled then
                    Just (Cem.M3e.TextHighlight.disabled True)

                  else
                    Nothing
                ]
        )
        children


toM3eMode : MatchMode -> Html.Attribute msg
toM3eMode m =
    case m of
        Contains ->
            Cem.M3e.TextHighlight.mode Cem.M3e.TextHighlight.Contains

        StartsWith ->
            Cem.M3e.TextHighlight.mode Cem.M3e.TextHighlight.StartsWith

        EndsWith ->
            Cem.M3e.TextHighlight.mode Cem.M3e.TextHighlight.EndsWith
