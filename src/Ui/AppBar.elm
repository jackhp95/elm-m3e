module Ui.AppBar exposing
    ( AppBar
    , Size(..)
    , new
    , withAttributes
    , withId, withSize, withCentered
    , withTitle, withTitleHtmlElementEscapeHatch
    , withSubtitle, withSubtitleHtmlElementEscapeHatch
    , withLeadingIconButton, withLeadingHtmlElementEscapeHatch
    , withTrailingIconButton, withTrailingHtmlElementEscapeHatch
    , view
    )

{-| Typed builder for `<m3e-app-bar>` — top-of-screen chrome that hosts
title, navigation affordances, and contextual actions. Mirrors the
Material 3 [App bars][m3] surface.

[m3]: https://m3.material.io/components/app-bars/overview

The app bar is the page's top **header** surface: a title (with optional
subtitle), a leading affordance, and trailing actions. For a free-standing
row of contextual action buttons, reach for `Ui.Toolbar`; for top-level
destination switching, the navigation trio (`Ui.NavigationBar` /
`Ui.NavigationRail` / `Ui.NavigationDrawer`).


# Slots are attribute-injected, never wrapped

Each slot setter owns only the slot **attribute** (`slot="title"`, etc.) — it
never wraps your content in a builder-chosen element. There are two ways to
fill a slot, and both put the slot attribute on the element you actually
render (so it projects directly, with no stray `<span>`):

  - **typed** (`withTitle`, `withLeadingIconButton`, …) — pass a `Ui.*`
    builder; the slot attribute is injected via that builder's own
    `withAttributes`, then it renders its own element.
  - **element escape hatch** (`with…HtmlElementEscapeHatch tag attrs children`)
    — pass an element constructor (`Html.div`, `Html.a`, …), its attributes,
    and its children; the slot attribute is prepended to `attrs` and the
    element is rendered as `tag (slot :: attrs) children`.

Content is `Html msg` / `Ui.*` throughout — never a `String` the builder
secretly wraps in a text node.


# Type

@docs AppBar


# Configuration

@docs Size


# Constructor

@docs new


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withSize, withCentered
@docs withTitle, withTitleHtmlElementEscapeHatch
@docs withSubtitle, withSubtitleHtmlElementEscapeHatch
@docs withLeadingIconButton, withLeadingHtmlElementEscapeHatch
@docs withTrailingIconButton, withTrailingHtmlElementEscapeHatch


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import M3e.AppBar
import Ui.Heading
import Ui.IconButton


{-| An app bar.
-}
type AppBar msg
    = AppBar (Config msg)


{-| A slot-fillable child: given the slot attribute the app bar wants to put
on it, it produces the element carrying that attribute. This is how a slot is
filled without a wrapper — the attribute lands on the caller's real element.
-}
type alias Slotted msg =
    Attribute msg -> Html msg


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , title : Maybe (Slotted msg)
    , subtitle : Maybe (Slotted msg)
    , size : Size
    , centered : Bool
    , leading : Maybe (Slotted msg)
    , trailing : List (Slotted msg)
    }


{-| App bar size — the `size` attribute (default `Small`). Drives the bar's
height and title prominence; `Large` gives the most vertical room for a
two-line title/subtitle.
-}
type Size
    = Small
    | Medium
    | Large


{-| Construct an app bar. Fill slots with the `with*` modifiers — every slot is
optional.
-}
new : AppBar msg
new =
    AppBar
        { id = Nothing
        , attributes = []
        , title = Nothing
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


{-| Set the app bar size (default `Small`).
-}
withSize : Size -> AppBar msg -> AppBar msg
withSize s (AppBar cfg) =
    AppBar { cfg | size = s }


{-| Center the title and subtitle — the `centered` attribute (default
`False`, i.e. start-aligned).
-}
withCentered : Bool -> AppBar msg -> AppBar msg
withCentered b (AppBar cfg) =
    AppBar { cfg | centered = b }



-- SLOT HELPERS -----------------------------------------------------------


{-| Fill a slot from a typed builder: inject the slot attribute via the
builder's `withAttributes`, then render it.
-}
fromBuilder : (List (Attribute msg) -> b -> b) -> (b -> Html msg) -> b -> Slotted msg
fromBuilder addAttrs render builder slot =
    render (addAttrs [ slot ] builder)


{-| Fill a slot from a caller-provided element: prepend the slot attribute to
the caller's attributes and render their element.
-}
fromElement : (List (Attribute msg) -> List (Html msg) -> Html msg) -> List (Attribute msg) -> List (Html msg) -> Slotted msg
fromElement tag attrs children slot =
    tag (slot :: attrs) children



-- TITLE / SUBTITLE -------------------------------------------------------


{-| Set the title from a `Ui.Heading` (the M3 title typescale comes from the
`m3e-heading` element). The slot attribute is injected onto the heading.
-}
withTitle : Ui.Heading.Heading msg -> AppBar msg -> AppBar msg
withTitle heading (AppBar cfg) =
    AppBar { cfg | title = Just (fromBuilder Ui.Heading.withAttributes Ui.Heading.view heading) }


{-| Set the title from an arbitrary element (`tag attrs children`). The slot
attribute is prepended to `attrs`.
-}
withTitleHtmlElementEscapeHatch : (List (Attribute msg) -> List (Html msg) -> Html msg) -> List (Attribute msg) -> List (Html msg) -> AppBar msg -> AppBar msg
withTitleHtmlElementEscapeHatch tag attrs children (AppBar cfg) =
    AppBar { cfg | title = Just (fromElement tag attrs children) }


{-| Set the subtitle from a `Ui.Heading`. Rides the `subtitle` slot; the
element stacks it under the title at the proper M3 typescale.
-}
withSubtitle : Ui.Heading.Heading msg -> AppBar msg -> AppBar msg
withSubtitle heading (AppBar cfg) =
    AppBar { cfg | subtitle = Just (fromBuilder Ui.Heading.withAttributes Ui.Heading.view heading) }


{-| Set the subtitle from an arbitrary element.
-}
withSubtitleHtmlElementEscapeHatch : (List (Attribute msg) -> List (Html msg) -> Html msg) -> List (Attribute msg) -> List (Html msg) -> AppBar msg -> AppBar msg
withSubtitleHtmlElementEscapeHatch tag attrs children (AppBar cfg) =
    AppBar { cfg | subtitle = Just (fromElement tag attrs children) }



-- LEADING ----------------------------------------------------------------


{-| Set the leading affordance from a `Ui.IconButton` (the common case — a
menu / back / drawer-toggle button). The slot attribute is injected onto the
icon button.
-}
withLeadingIconButton : Ui.IconButton.IconButton msg -> AppBar msg -> AppBar msg
withLeadingIconButton iconButton (AppBar cfg) =
    AppBar { cfg | leading = Just (fromBuilder Ui.IconButton.withAttributes Ui.IconButton.view iconButton) }


{-| Set the leading affordance from an arbitrary element — for the heterogeneous
cases (a brand mark, an avatar, a responsive wrapper). The slot attribute is
prepended to `attrs`.
-}
withLeadingHtmlElementEscapeHatch : (List (Attribute msg) -> List (Html msg) -> Html msg) -> List (Attribute msg) -> List (Html msg) -> AppBar msg -> AppBar msg
withLeadingHtmlElementEscapeHatch tag attrs children (AppBar cfg) =
    AppBar { cfg | leading = Just (fromElement tag attrs children) }



-- TRAILING (appends) -----------------------------------------------------


{-| Append a trailing action from a `Ui.IconButton`. Call once per action; the
`m3e-app-bar` lays multiple trailing children out as a flex row.
-}
withTrailingIconButton : Ui.IconButton.IconButton msg -> AppBar msg -> AppBar msg
withTrailingIconButton iconButton (AppBar cfg) =
    AppBar { cfg | trailing = cfg.trailing ++ [ fromBuilder Ui.IconButton.withAttributes Ui.IconButton.view iconButton ] }


{-| Append a trailing action from an arbitrary element (e.g. a `Ui.Search`, a
`Ui.Avatar`, or an `<a>` link wrapping an icon button).
-}
withTrailingHtmlElementEscapeHatch : (List (Attribute msg) -> List (Html msg) -> Html msg) -> List (Attribute msg) -> List (Html msg) -> AppBar msg -> AppBar msg
withTrailingHtmlElementEscapeHatch tag attrs children (AppBar cfg) =
    AppBar { cfg | trailing = cfg.trailing ++ [ fromElement tag attrs children ] }



-- RENDER -----------------------------------------------------------------


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
            [ slotInto M3e.AppBar.leadingSlot cfg.leading
            , slotInto M3e.AppBar.titleSlot cfg.title
            , slotInto M3e.AppBar.subtitleSlot cfg.subtitle
            , List.map (\fill -> fill M3e.AppBar.trailingSlot) cfg.trailing
            ]
        )


slotInto : Attribute msg -> Maybe (Slotted msg) -> List (Html msg)
slotInto slot maybeFill =
    case maybeFill of
        Just fill ->
            [ fill slot ]

        Nothing ->
            []


sizeAttr : Size -> Html.Attribute msg
sizeAttr s =
    case s of
        Small ->
            M3e.AppBar.size M3e.AppBar.Small

        Medium ->
            M3e.AppBar.size M3e.AppBar.Medium

        Large ->
            M3e.AppBar.size M3e.AppBar.Large
