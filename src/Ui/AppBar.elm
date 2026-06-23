module Ui.AppBar exposing
    ( AppBar
    , Size(..)
    , new
    , withId, withSize, withCentered, withLeading, withTrailing
    , view
    )

{-| Typed builder for `<m3e-app-bar>` — top-of-screen chrome that hosts
title, navigation affordances, and contextual actions. Mirrors the
Material 3 [App bars][m3] surface.

[m3]: https://m3.material.io/components/app-bars/overview


# Type

@docs AppBar


# Configuration

@docs Size


# Constructor

@docs new


# Modifiers

@docs withId, withSize, withCentered, withLeading, withTrailing


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import M3e.AppBar


{-| An app bar.
-}
type AppBar msg
    = AppBar (Config msg)


type alias Config msg =
    { id : Maybe String
    , title : String
    , size : Size
    , centered : Bool
    , leading : Maybe (Html msg)
    , trailing : List (Html msg)
    }


{-| App bar size. Defaults to `Small`.
-}
type Size
    = Small
    | Medium
    | Large


{-| Construct an app bar with the given title.
-}
new : String -> AppBar msg
new title =
    AppBar
        { id = Nothing
        , title = title
        , size = Small
        , centered = False
        , leading = Nothing
        , trailing = []
        }


{-| Set the `id` attribute.
-}
withId : String -> AppBar msg -> AppBar msg
withId id (AppBar cfg) =
    AppBar { cfg | id = Just id }


{-| Set the app bar size.
-}
withSize : Size -> AppBar msg -> AppBar msg
withSize s (AppBar cfg) =
    AppBar { cfg | size = s }


{-| Center the title.
-}
withCentered : Bool -> AppBar msg -> AppBar msg
withCentered b (AppBar cfg) =
    AppBar { cfg | centered = b }


{-| Set the leading affordance (typically a back/menu icon button).
-}
withLeading : Html msg -> AppBar msg -> AppBar msg
withLeading html (AppBar cfg) =
    AppBar { cfg | leading = Just html }


{-| Set trailing actions.
-}
withTrailing : List (Html msg) -> AppBar msg -> AppBar msg
withTrailing items (AppBar cfg) =
    AppBar { cfg | trailing = items }


{-| Render the app bar.
-}
view : AppBar msg -> Html msg
view (AppBar cfg) =
    M3e.AppBar.component
        (List.filterMap identity
            [ Maybe.map Attr.id cfg.id
            , Just (sizeAttr cfg.size)
            , Just (M3e.AppBar.centered cfg.centered)
            ]
        )
        (List.concat
            [ leadingSlot cfg.leading
            , [ Html.span [] [ Html.text cfg.title ] ]
            , trailingSlot cfg.trailing
            ]
        )


leadingSlot : Maybe (Html msg) -> List (Html msg)
leadingSlot leading =
    case leading of
        Nothing ->
            []

        Just html ->
            [ Html.span [ Attr.attribute "slot" "leading" ] [ html ] ]


trailingSlot : List (Html msg) -> List (Html msg)
trailingSlot items =
    case items of
        [] ->
            []

        _ ->
            [ Html.span [ Attr.attribute "slot" "trailing" ] items ]


sizeAttr : Size -> Html.Attribute msg
sizeAttr s =
    case s of
        Small ->
            M3e.AppBar.size M3e.AppBar.Small

        Medium ->
            Attr.attribute "size" "medium"

        Large ->
            Attr.attribute "size" "large"
