module Ui.Card exposing
    ( Card
    , Variant(..)
    , new
    , withMedia, withHeadline, withSubhead, withBody, withActions, withFooter
    , view
    )

{-| Typed builder for `<m3e-card>` — a flexible container for content
and actions about a single subject. Mirrors the Material 3 [Cards][m3]
surface 1:1.

[m3]: https://m3.material.io/components/cards/overview


# Anatomy and slots

Per Material spec, the container is the only _required_ part of a card;
every other slot is optional. The six anatomy parts map onto this
module's slot setters:

| Material part | Setter | Type |
| ------------------ | -------------- | ----------------------------------------------- |
| Container | `new` | `Variant -> Card msg` (required) |
| Image / media | `withMedia` | `Html msg` |
| Headline | `withHeadline` | `String` |
| Subhead | `withSubhead` | `String` |
| Supporting text | `withBody` | `Html msg` |
| Buttons | `withActions` | `List (Ui.Button.Button msg)` |
| (Footer extension) | `withFooter` | `Html msg` |

The actions slot is **typed to action buttons only** — a toggle button
in the actions row is not standard m3 and is therefore unrepresentable.
Other slots accept `Html msg` because Material describes cards as
"flexible layouts" containing "anything from images to headlines to
lists."


# Quick examples

A minimal card — variant + headline + body:

    Ui.Card.new Ui.Card.Outlined
        |> Ui.Card.withHeadline "Pending audits"
        |> Ui.Card.withBody (text "5 audits awaiting your review.")
        |> Ui.Card.view

A richer card — media at the top, two-line title, one action:

    Ui.Card.new Ui.Card.Elevated
        |> Ui.Card.withMedia
            (img [ src "/cover.jpg", alt "" ] [])
        |> Ui.Card.withHeadline "Compliance scorecard"
        |> Ui.Card.withSubhead "Updated 2 hours ago"
        |> Ui.Card.withBody (text "All checks passing.")
        |> Ui.Card.withActions
            [ Ui.Button.button
                { label = "View details"
                , variant = Ui.Button.Text
                , onClick = ViewScorecardRequested
                }
            ]
        |> Ui.Card.view


# Type

@docs Card


# Configuration

@docs Variant


# Constructor

@docs new


# Modifiers

@docs withMedia, withHeadline, withSubhead, withBody, withActions, withFooter


# Render

@docs view

-}

import Html exposing (Html)
import Html.Attributes as Attr
import M3e.Card
import Ui.Button



-- TYPES ------------------------------------------------------------------


{-| A card, built with `new` and configured with `with*` modifiers.
-}
type Card msg
    = Card (Config msg)


type alias Config msg =
    { variant : Variant
    , media : Maybe (Html msg)
    , headline : Maybe String
    , subhead : Maybe String
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


{-| Set the headline — the primary title of the card. Per Material
guidance, keep it short and descriptive.

    Ui.Card.new Ui.Card.Outlined
        |> Ui.Card.withHeadline "Compliance scorecard"

-}
withHeadline : String -> Card msg -> Card msg
withHeadline headline (Card cfg) =
    Card { cfg | headline = Just headline }


{-| Set the subhead — secondary text rendered immediately below the
headline. Use for context (e.g. last-updated time, parent category).

    Ui.Card.new Ui.Card.Outlined
        |> Ui.Card.withHeadline "Compliance scorecard"
        |> Ui.Card.withSubhead "Updated 2 hours ago"

-}
withSubhead : String -> Card msg -> Card msg
withSubhead subhead (Card cfg) =
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

The list is **typed to `Ui.Button.Button Ui.Button.Action msg`** — that
is, action buttons created by `Ui.Button.button` or
`Ui.Button.buttonLink`. A `Ui.Button.toggle` value will not type-check
here, because a selection toggle in a card's actions row is not standard
Material guidance.

    Ui.Card.new Ui.Card.Outlined
        |> Ui.Card.withHeadline "Save changes?"
        |> Ui.Card.withActions
            [ Ui.Button.button
                { label = "Discard", variant = Ui.Button.Text, onClick = Discarded }
            , Ui.Button.button
                { label = "Save", variant = Ui.Button.Filled, onClick = Saved }
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
        [ variantAttr cfg.variant ]
        (List.concat
            [ headerSection cfg
            , bodySection cfg.body
            , actionsSection cfg.actions
            , footerSection cfg.footer
            ]
        )


headerSection : Config msg -> List (Html msg)
headerSection cfg =
    let
        parts : List (Html msg)
        parts =
            List.filterMap identity
                [ Maybe.map renderMedia cfg.media
                , Maybe.map renderHeadline cfg.headline
                , Maybe.map renderSubhead cfg.subhead
                ]
    in
    case parts of
        [] ->
            []

        _ ->
            [ Html.div [ M3e.Card.headerSlot ] parts ]


renderMedia : Html msg -> Html msg
renderMedia media =
    Html.div [ Attr.class "ds-card-media" ] [ media ]


renderHeadline : String -> Html msg
renderHeadline text =
    Html.h3 [ Attr.class "ds-card-headline" ] [ Html.text text ]


renderSubhead : String -> Html msg
renderSubhead text =
    Html.p [ Attr.class "ds-card-subhead" ] [ Html.text text ]


bodySection : Maybe (Html msg) -> List (Html msg)
bodySection body =
    case body of
        Nothing ->
            []

        Just b ->
            [ Html.div [ M3e.Card.contentSlot ] [ b ] ]


actionsSection : List (Ui.Button.Button msg) -> List (Html msg)
actionsSection actions =
    case actions of
        [] ->
            []

        _ ->
            [ Html.div
                [ M3e.Card.actionsSlot, Attr.class "ds-card-actions" ]
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
            M3e.Card.variantElevated

        Filled ->
            M3e.Card.variantFilled

        Outlined ->
            M3e.Card.variantOutlined
