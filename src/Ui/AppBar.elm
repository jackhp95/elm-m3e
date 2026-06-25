module Ui.AppBar exposing
    ( AppBar
    , Size(..)
    , new
    , withAttributes
    , withId, withSize, withCentered, withSubtitle, withLeading, withTrailing
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


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withSize, withCentered, withSubtitle, withLeading, withTrailing


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import M3e.AppBar


{-| An app bar.
-}
type AppBar msg
    = AppBar (Config msg)


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , title : String
    , subtitle : Maybe String
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
        , attributes = []
        , title = title
        , subtitle = Nothing
        , size = Small
        , centered = False
        , leading = Nothing
        , trailing = []
        }


{-| Append attributes to the underlying `<m3e-app-bar>` host element — the
escape hatch for styling the component itself. Structural attributes are emitted
after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> AppBar msg -> AppBar msg
withAttributes attributes (AppBar cfg) =
    AppBar { cfg | attributes = cfg.attributes ++ attributes }


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


{-| Set a subtitle. Rides the `subtitle` slot of `m3e-app-bar`; the element
stacks it under the title at the proper M3 typescale. Prefer this over
dash-separating a long title (which would overflow on narrow viewports).
-}
withSubtitle : String -> AppBar msg -> AppBar msg
withSubtitle s (AppBar cfg) =
    AppBar { cfg | subtitle = Just s }


{-| Set the leading affordance — typically a `Ui.IconButton` rendered to Html
(`|> Ui.IconButton.view`), but this slot is naturally heterogeneous (e.g. a
brand icon, an avatar, a drawer toggle), so it stays `Html msg`.
-}
withLeading : Html msg -> AppBar msg -> AppBar msg
withLeading html (AppBar cfg) =
    AppBar { cfg | leading = Just html }


{-| Set the trailing actions. Compose `Ui.IconButton`s (with `withHref` /
`withTarget` for link actions), `Ui.Search`/`Ui.Avatar`/etc.; the slot is
naturally heterogeneous so it stays `List (Html msg)`.
-}
withTrailing : List (Html msg) -> AppBar msg -> AppBar msg
withTrailing items (AppBar cfg) =
    AppBar { cfg | trailing = items }


{-| Render the app bar.
-}
view : AppBar msg -> Html msg
view (AppBar cfg) =
    M3e.AppBar.component
        (cfg.attributes
            ++ List.filterMap identity
                [ Maybe.map Attr.id cfg.id
                , Just (sizeAttr cfg.size)
                , Just (M3e.AppBar.centered cfg.centered)
                ]
        )
        (List.concat
            [ leadingSlot cfg.leading
            , [ Html.span [ M3e.AppBar.titleSlot ] [ Html.text cfg.title ] ]
            , subtitleSlot cfg.subtitle
            , trailingSlot cfg.trailing
            ]
        )


leadingSlot : Maybe (Html msg) -> List (Html msg)
leadingSlot leading =
    case leading of
        Nothing ->
            []

        Just html ->
            [ Html.span [ M3e.AppBar.leadingSlot ] [ html ] ]


{-| Each trailing item rides its own `<span slot="trailing">`. The m3e-app-bar
shadow template lays multiple slotted children out as a flex row in its
`.trailing-icon` wrapper; wrapping them all in a single span here would defeat
that and stack them vertically.
-}
trailingSlot : List (Html msg) -> List (Html msg)
trailingSlot items =
    List.map (\item -> Html.span [ M3e.AppBar.trailingSlot ] [ item ]) items


subtitleSlot : Maybe String -> List (Html msg)
subtitleSlot subtitle =
    case subtitle of
        Nothing ->
            []

        Just s ->
            [ Html.span [ M3e.AppBar.subtitleSlot ] [ Html.text s ] ]


sizeAttr : Size -> Html.Attribute msg
sizeAttr s =
    case s of
        Small ->
            M3e.AppBar.size M3e.AppBar.Small

        Medium ->
            M3e.AppBar.size M3e.AppBar.Medium

        Large ->
            M3e.AppBar.size M3e.AppBar.Large
