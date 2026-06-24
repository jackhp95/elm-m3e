module Ui.Tooltip exposing
    ( Tooltip, Plain, Rich
    , Position(..)
    , plain, rich
    , withAttributes
    , withId, withPosition, withHideDelay, withActions
    , view
    )

{-| Typed builder for `<m3e-tooltip>` / `<m3e-rich-tooltip>` — short
labels that appear when an element is focused or hovered. Mirrors the
Material 3 [Tooltips][m3] surface.

[m3]: https://m3.material.io/components/tooltips/overview


# Two kinds, gated by the type system

  - **Plain** (`plain`) — single-line text labels for icon buttons and
    other glyph-only controls. Rendered via `<m3e-tooltip>`.
  - **Rich** (`rich`) — multi-line content, optionally with actions.
    Rendered via `<m3e-rich-tooltip>`.

Use plain tooltips for brief labels (≤ 1 line); use rich tooltips when
you need formatted text, supporting context, or actions.


# Required-by-design

`plain` requires:

  - `anchorId` — the `id` of the element the tooltip describes. Tooltips
    are positioned relative to this element.
  - `label` — the tooltip text.

`rich` requires:

  - `anchorId` — same as plain.
  - `content` — `Html msg` content.

`withActions` is gated to **rich** tooltips only at the type level —
plain tooltips can't carry actions, by the m3 spec.


# Quick examples

A plain tooltip on an icon button:

    div []
        [ Ui.IconButton.button { icon = …, label = "Delete", … } |> Ui.IconButton.view
        , Ui.Tooltip.plain { anchorId = "delete-btn", label = "Delete this row" }
            |> Ui.Tooltip.view
        ]

A rich tooltip with explanation and an action:

    Ui.Tooltip.rich
        { anchorId = "audit-status"
        , content = explainerHtml
        }
        |> Ui.Tooltip.withActions
            [ Ui.Button.new { label = "Learn more", variant = Ui.Button.Text }
                |> Ui.Button.withOnClick LearnMoreClicked
            ]
        |> Ui.Tooltip.view


# Type

@docs Tooltip, Plain, Rich


# Configuration

@docs Position


# Constructors

@docs plain, rich


# Host attributes

@docs withAttributes


# Modifiers

@docs withId, withPosition, withHideDelay, withActions


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import M3e.RichTooltip
import M3e.Tooltip
import Ui.Button



-- TYPES ------------------------------------------------------------------


{-| A tooltip, parameterized by its kind tag.
-}
type Tooltip kind msg
    = Tooltip (Config msg)


{-| Phantom tag for plain tooltips. Has no values.
-}
type Plain
    = PlainPhantomTag Never


{-| Phantom tag for rich tooltips. Has no values.
-}
type Rich
    = RichPhantomTag Never


{-| Tooltip anchor position relative to the anchored element.
-}
type Position
    = Above
    | Below
    | Before
    | After


type alias Config msg =
    { id : Maybe String
    , attributes : List (Attribute msg)
    , anchorId : String
    , kind : Kind msg
    , position : Maybe Position
    , hideDelay : Maybe Int
    , actions : List (Ui.Button.Button msg)
    }


type Kind msg
    = PlainKind String
    | RichKind (Html msg)



-- CONSTRUCTORS -----------------------------------------------------------


{-| Construct a plain (text-only) tooltip.
-}
plain : { anchorId : String, label : String } -> Tooltip Plain msg
plain c =
    Tooltip
        { id = Nothing
        , attributes = []
        , anchorId = c.anchorId
        , kind = PlainKind c.label
        , position = Nothing
        , hideDelay = Nothing
        , actions = []
        }


{-| Construct a rich tooltip (HTML content; can carry actions).
-}
rich : { anchorId : String, content : Html msg } -> Tooltip Rich msg
rich c =
    Tooltip
        { id = Nothing
        , attributes = []
        , anchorId = c.anchorId
        , kind = RichKind c.content
        , position = Nothing
        , hideDelay = Nothing
        , actions = []
        }



-- MODIFIERS --------------------------------------------------------------


{-| Append attributes to the rendered tooltip host — `<m3e-tooltip>` for a
plain tooltip, `<m3e-rich-tooltip>` for a rich one. Structural attributes are
emitted after these, so callers can't clobber them.
-}
withAttributes : List (Attribute msg) -> Tooltip kind msg -> Tooltip kind msg
withAttributes attributes (Tooltip cfg) =
    Tooltip { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the `id` on the tooltip element.
-}
withId : String -> Tooltip kind msg -> Tooltip kind msg
withId id (Tooltip cfg) =
    Tooltip { cfg | id = Just id }


{-| Set the anchor position.
-}
withPosition : Position -> Tooltip kind msg -> Tooltip kind msg
withPosition p (Tooltip cfg) =
    Tooltip { cfg | position = Just p }


{-| Set the hide-delay in milliseconds.
-}
withHideDelay : Int -> Tooltip kind msg -> Tooltip kind msg
withHideDelay ms (Tooltip cfg) =
    Tooltip { cfg | hideDelay = Just ms }


{-| Add actions to a rich tooltip. Compile-error on plain tooltips
(plain tooltips don't carry actions per m3 spec).
-}
withActions :
    List (Ui.Button.Button msg)
    -> Tooltip Rich msg
    -> Tooltip Rich msg
withActions actions (Tooltip cfg) =
    Tooltip { cfg | actions = actions }



-- RENDER -----------------------------------------------------------------


{-| Render the tooltip to `Html`.
-}
view : Tooltip kind msg -> Html msg
view (Tooltip cfg) =
    case cfg.kind of
        PlainKind label ->
            M3e.Tooltip.component
                (cfg.attributes
                    ++ List.filterMap identity
                        [ Maybe.map Attr.id cfg.id
                        , Just (M3e.Tooltip.for cfg.anchorId)
                        , Maybe.map plainPositionAttr cfg.position
                        , Maybe.map (M3e.Tooltip.hideDelay << toFloat) cfg.hideDelay
                        ]
                )
                [ Html.text label ]

        RichKind content ->
            M3e.RichTooltip.component
                (cfg.attributes
                    ++ List.filterMap identity
                        [ Maybe.map Attr.id cfg.id
                        , Just (M3e.RichTooltip.for cfg.anchorId)
                        , Maybe.map richPositionAttr cfg.position
                        , Maybe.map (M3e.RichTooltip.hideDelay << toFloat) cfg.hideDelay
                        ]
                )
                (content :: actionsElement cfg.actions)


plainPositionAttr : Position -> Html.Attribute msg
plainPositionAttr p =
    case p of
        Above ->
            M3e.Tooltip.position M3e.Tooltip.Above

        Below ->
            M3e.Tooltip.position M3e.Tooltip.Below

        Before ->
            M3e.Tooltip.position M3e.Tooltip.Before

        After ->
            M3e.Tooltip.position M3e.Tooltip.After


richPositionAttr : Position -> Html.Attribute msg
richPositionAttr p =
    case p of
        Above ->
            M3e.RichTooltip.position M3e.RichTooltip.AboveAfter

        Below ->
            M3e.RichTooltip.position M3e.RichTooltip.BelowBefore

        Before ->
            M3e.RichTooltip.position M3e.RichTooltip.Before

        After ->
            M3e.RichTooltip.position M3e.RichTooltip.After


actionsElement :
    List (Ui.Button.Button msg)
    -> List (Html msg)
actionsElement actions =
    case actions of
        [] ->
            []

        _ ->
            [ Html.div [ M3e.RichTooltip.actionsSlot ]
                (List.map Ui.Button.view actions)
            ]
