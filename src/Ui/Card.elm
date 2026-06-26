module Ui.Card exposing
    ( Card
    , Variant(..)
    , new
    , withAttributes
    , withMedia, withHeadline, withHeadlineEscapeHatchHtml, withSubhead, withSubheadEscapeHatchHtml, withBody, withActions, withFooter
    , view
    )

{-| Typed builder for `<m3e-card>` — a flexible container for content
and actions about a single subject. Mirrors the Material 3 [Cards][m3]
surface 1:1.

[m3]: https://m3.material.io/components/cards/overview

Reach for a card to group related content and actions about **one**
subject, sitting persistently in the page flow. For transient focus use a
different surface: `Ui.Dialog` (a modal prompt/decision that blocks the
page), `Ui.BottomSheet` (a sheet from the bottom, mobile-friendly), or
`Ui.Menu` (a small list of actions anchored to a trigger). To show or hide
a section in place, use `Ui.Disclosure`.


# Anatomy and slots

Per Material spec, the container is the only _required_ part of a card;
every other slot is optional. The six anatomy parts map onto this
module's slot setters:

| Material part | Setter | Type |
| ------------------ | -------------- | ----------------------------------------------- |
| Container | `new` | `Variant -> Card msg` (required) |
| Image / media | `withMedia` | `Html msg` |
| Headline | `withHeadline` | `Ui.Heading msg` |
| Subhead | `withSubhead` | `Ui.Heading msg` |
| Supporting text | `withBody` | `Html msg` |
| Buttons | `withActions` | `List (Ui.Button.Button msg)` |
| (Footer extension) | `withFooter` | `Html msg` |

The actions slot takes `Ui.Button.Button msg` values — action buttons by
convention (a selection toggle in a card's actions row isn't standard m3,
though the type doesn't forbid it).
Other slots accept `Html msg` because Material describes cards as
"flexible layouts" containing "anything from images to headlines to
lists."


# Quick examples

A minimal card — variant + headline + body:

    Ui.Card.new Ui.Card.Outlined
        |> Ui.Card.withHeadline (Ui.Heading.title "Pending audits")
        |> Ui.Card.withBody (text "5 audits awaiting your review.")
        |> Ui.Card.view

A richer card — media at the top, two-line title, one action:

    Ui.Card.new Ui.Card.Elevated
        |> Ui.Card.withMedia
            (img [ src "/cover.jpg", alt "" ] [])
        |> Ui.Card.withHeadline (Ui.Heading.title "Compliance scorecard")
        |> Ui.Card.withSubhead (Ui.Heading.label "Updated 2 hours ago")
        |> Ui.Card.withBody (text "All checks passing.")
        |> Ui.Card.withActions
            [ Ui.Button.new { label = "View details", variant = Ui.Button.Text }
                |> Ui.Button.withOnClick ViewScorecardRequested
            ]
        |> Ui.Card.view


# Type

@docs Card


# Configuration

@docs Variant


# Constructor

@docs new


# Modifiers

@docs withAttributes
@docs withMedia, withHeadline, withHeadlineEscapeHatchHtml, withSubhead, withSubheadEscapeHatchHtml, withBody, withActions, withFooter


# Render

@docs view

-}

import Html exposing (Attribute, Html)
import M3e.Card
import Ui.Button
import Ui.Heading



-- TYPES ------------------------------------------------------------------


{-| A card, built with `new` and configured with `with*` modifiers.
-}
type Card msg
    = Card (Config msg)


type alias Config msg =
    { variant : Variant
    , attributes : List (Attribute msg)
    , media : Maybe (Html msg)
    , headline : Maybe (Html msg)
    , subhead : Maybe (Html msg)
    , body : Maybe (Html msg)
    , actions : List (Ui.Button.Button msg)
    , footer : Maybe (Html msg)
    }


{-| Container style. Per Material 3, the three styles are content-tied
visual-weight choices.

  - **Elevated** — raised surface with a shadow; highest emphasis.
  - **Filled** — solid tonal surface; medium emphasis. Useful in
    backgrounds where shadows compete visually.
  - **Outlined** — bordered surface, no fill; lowest emphasis. Useful
    for dense layouts or when the card sits inside another container.

-}
type Variant
    = Elevated
    | Filled
    | Outlined



-- CONSTRUCTOR ------------------------------------------------------------


{-| Construct a card with the given variant. Every other slot is
optional; add them via `with*` modifiers.

    Ui.Card.new Ui.Card.Outlined
        |> Ui.Card.withHeadline "Pending audits"
        |> Ui.Card.view

-}
new : Variant -> Card msg
new variant =
    Card
        { variant = variant
        , attributes = []
        , media = Nothing
        , headline = Nothing
        , subhead = Nothing
        , body = Nothing
        , actions = []
        , footer = Nothing
        }



-- MODIFIERS --------------------------------------------------------------


{-| Set the media block (typically an image or video). Renders at the
top of the card, above any headline.

    Ui.Card.new Ui.Card.Elevated
        |> Ui.Card.withMedia (img [ src "/cover.jpg", alt "" ] [])

-}
withMedia : Html msg -> Card msg -> Card msg
withMedia media (Card cfg) =
    Card { cfg | media = Just media }


{-| Append attributes to the underlying `<m3e-card>` host element — the
escape hatch for styling the card itself (`class`, `data-*`, `aria-*`, extra
handlers, …). The card's own structural attributes (e.g. `variant`) are
emitted after these, so a stray caller attribute can't break the contract.

    Ui.Card.new Ui.Card.Outlined
        |> Ui.Card.withAttributes [ class "h-full" ]

-}
withAttributes : List (Attribute msg) -> Card msg -> Card msg
withAttributes attributes (Card cfg) =
    Card { cfg | attributes = cfg.attributes ++ attributes }


{-| Set the headline — the primary title of the card — as a typed
`Ui.Heading`. The M3 typescale comes from the `m3e-heading` element itself;
use `Ui.Heading.title` for the common case.

    Ui.Card.new Ui.Card.Outlined
        |> Ui.Card.withHeadline (Ui.Heading.title "Compliance scorecard")

-}
withHeadline : Ui.Heading.Heading msg -> Card msg -> Card msg
withHeadline heading (Card cfg) =
    Card { cfg | headline = Just (Ui.Heading.view heading) }


{-| Escape hatch: set the headline to arbitrary `Html` when a `Ui.Heading`
is too restrictive.
-}
withHeadlineEscapeHatchHtml : Html msg -> Card msg -> Card msg
withHeadlineEscapeHatchHtml headline (Card cfg) =
    Card { cfg | headline = Just headline }


{-| Set the subhead — secondary text below the headline — as a typed
`Ui.Heading` (commonly `Ui.Heading.label`).

    Ui.Card.new Ui.Card.Outlined
        |> Ui.Card.withHeadline (Ui.Heading.title "Compliance scorecard")
        |> Ui.Card.withSubhead (Ui.Heading.label "Updated 2 hours ago")

-}
withSubhead : Ui.Heading.Heading msg -> Card msg -> Card msg
withSubhead heading (Card cfg) =
    Card { cfg | subhead = Just (Ui.Heading.view heading) }


{-| Escape hatch: set the subhead to arbitrary `Html`.
-}
withSubheadEscapeHatchHtml : Html msg -> Card msg -> Card msg
withSubheadEscapeHatchHtml subhead (Card cfg) =
    Card { cfg | subhead = Just subhead }


{-| Set the supporting text / main content block. Renders below the
headline/subhead pair.

    Ui.Card.new Ui.Card.Outlined
        |> Ui.Card.withBody (text "5 audits awaiting your review.")

-}
withBody : Html msg -> Card msg -> Card msg
withBody body (Card cfg) =
    Card { cfg | body = Just body }


{-| Set the actions row — buttons that act on the card's content.

The list takes `Ui.Button.Button msg` values — action buttons by
convention (a selection toggle in a card's actions row isn't standard
Material guidance, though the type doesn't forbid it).

    Ui.Card.new Ui.Card.Outlined
        |> Ui.Card.withHeadline "Save changes?"
        |> Ui.Card.withActions
            [ Ui.Button.new { label = "Discard", variant = Ui.Button.Text }
                |> Ui.Button.withOnClick Discarded
            , Ui.Button.new { label = "Save", variant = Ui.Button.Filled }
                |> Ui.Button.withOnClick Saved
            ]

-}
withActions :
    List (Ui.Button.Button msg)
    -> Card msg
    -> Card msg
withActions actions (Card cfg) =
    Card { cfg | actions = actions }


{-| Set the footer — supplementary content rendered below the actions
row. Use sparingly; most cards don't need one.
-}
withFooter : Html msg -> Card msg -> Card msg
withFooter footer (Card cfg) =
    Card { cfg | footer = Just footer }



-- RENDER -----------------------------------------------------------------


{-| Render the card to `Html`. Use this as the final step of the builder
pipeline.
-}
view : Card msg -> Html msg
view (Card cfg) =
    M3e.Card.component
        (cfg.attributes ++ [ variantAttr cfg.variant ])
        (List.concat
            [ mediaSection cfg.media
            , contentSection cfg
            , actionsSection cfg.actions
            , footerSection cfg.footer
            ]
        )


{-| The media (image/video) rides the `header` slot — that is what `m3e-card`
styles as the full-bleed media region (`::slotted(img[slot=header])`). It is
the only thing in `header`; the title block lives in `content` below.
-}
mediaSection : Maybe (Html msg) -> List (Html msg)
mediaSection media =
    case media of
        Nothing ->
            []

        Just m ->
            [ Html.div [ M3e.Card.headerSlot ] [ m ] ]


{-| The card's text block — headline, subhead, then body — all in the
`content` slot (the padded supporting-text region). Keeping the headline and
subhead here (not in `header`, which is the media slot) is what stops them
being clipped behind the media on a media card.
-}
contentSection : Config msg -> List (Html msg)
contentSection cfg =
    let
        parts : List (Html msg)
        parts =
            List.filterMap identity
                [ cfg.headline
                , cfg.subhead
                , cfg.body
                ]
    in
    case parts of
        [] ->
            []

        _ ->
            [ Html.div [ M3e.Card.contentSlot ] parts ]


actionsSection : List (Ui.Button.Button msg) -> List (Html msg)
actionsSection actions =
    case actions of
        [] ->
            []

        _ ->
            [ Html.div
                [ M3e.Card.actionsSlot ]
                (List.map Ui.Button.view actions)
            ]


footerSection : Maybe (Html msg) -> List (Html msg)
footerSection footer =
    case footer of
        Nothing ->
            []

        Just f ->
            [ Html.div [ M3e.Card.footerSlot ] [ f ] ]



-- ATTRIBUTE HELPERS ------------------------------------------------------


variantAttr : Variant -> Html.Attribute msg
variantAttr v =
    case v of
        Elevated ->
            M3e.Card.variant M3e.Card.Elevated

        Filled ->
            M3e.Card.variant M3e.Card.Filled

        Outlined ->
            M3e.Card.variant M3e.Card.Outlined
