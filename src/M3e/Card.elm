module M3e.Card exposing
    ( Option, Variant(..)
    , variant, actionable, inline, media, headline, subhead, body, actions, footer
    , view
    )

{-| `<m3e-card>` — a flexible content container (Material 3 Cards).

Spec (per docs/CONVENTIONS.md):

  - Required: (none — container only, variant optional)
  - Options: variant, actionable, inline, media, headline, subhead,
    body, actions, footer
  - Slots:
    header : region (free row — any Renderable; wrapped in div[slot=header])
    content : region (free row — headline + subhead; wrapped in div[slot=content])
    actions : homogeneous List (Renderable { button : Supported })
    footer : region (free row)
    (default): free row — body items, no slot injected
  - Properties: actionable, inline (DOM properties)
  - Attrs: variant
  - Escape: html (default slot / all regions)
  - Tag: card

`body` items go into the card's DEFAULT SLOT (no slot wrapper) so that
existing code and the IntrospectionTest (which counts direct children) keep
working: with only `body` set, the card's children are exactly the body items.


# Type

@docs Option, Variant


# Options

@docs variant, actionable, inline, media, headline, subhead, body, actions, footer


# View

@docs view

-}

import Json.Encode as Encode
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)
import M3e.Renderable as Renderable exposing (Renderable, Supported)



-- TYPES ------------------------------------------------------------------


{-| Container style — `Elevated`, `Filled`, or `Outlined`.
-}
type Variant
    = Elevated
    | Filled
    | Outlined


type alias Config msg =
    { variant : Maybe Variant
    , actionable : Bool
    , inline : Bool
    , media : Maybe (Node msg)
    , headline : Maybe (Node msg)
    , subhead : Maybe (Node msg)
    , actions : List (Node msg)
    , footer : Maybe (Node msg)
    , body : List (Node msg)
    }


{-| An opaque configuration option for [`view`](#view).
-}
type alias Option msg =
    Internal.Option (Config msg) msg


defaultConfig : Config msg
defaultConfig =
    { variant = Nothing
    , actionable = False
    , inline = False
    , media = Nothing
    , headline = Nothing
    , subhead = Nothing
    , actions = []
    , footer = Nothing
    , body = []
    }



-- OPTIONS ------------------------------------------------------------------


{-| Set the container style (`Elevated`, `Filled`, or `Outlined`).
-}
variant : Variant -> Option msg
variant v =
    Internal.option (\c -> { c | variant = Just v })


{-| Make the whole card a single interactive surface (the `actionable` DOM
property). Default false.
-}
actionable : Bool -> Option msg
actionable b =
    Internal.option (\c -> { c | actionable = b })


{-| Lay the card out inline rather than as a block (the `inline` DOM
property). Default false.
-}
inline : Bool -> Option msg
inline b =
    Internal.option (\c -> { c | inline = b })


{-| Media (e.g. an image) shown in the card's `header` slot.
-}
media : Renderable any msg -> Option msg
media item =
    Internal.option (\c -> { c | media = Just (Renderable.toNode item) })


{-| Headline shown in the card's `content` slot.
-}
headline : Renderable any msg -> Option msg
headline item =
    Internal.option (\c -> { c | headline = Just (Renderable.toNode item) })


{-| Subhead shown beneath the headline in the card's `content` slot.
-}
subhead : Renderable any msg -> Option msg
subhead item =
    Internal.option (\c -> { c | subhead = Just (Renderable.toNode item) })


{-| Body content placed in the card's default slot (no slot wrapper).
-}
body : List (Renderable any msg) -> Option msg
body items =
    Internal.option (\c -> { c | body = List.map Renderable.toNode items })


{-| Action buttons shown in the card's `actions` slot.
-}
actions : List (Renderable { s | button : Supported } msg) -> Option msg
actions items =
    Internal.option (\c -> { c | actions = List.map Renderable.toNode items })


{-| Footer content shown in the card's `footer` region.
-}
footer : Renderable any msg -> Option msg
footer item =
    Internal.option (\c -> { c | footer = Just (Renderable.toNode item) })



-- VIEW ------------------------------------------------------------------


{-| Render the card.
-}
view : List (Option msg) -> Renderable { s | card : Supported } msg
view opts =
    let
        cfg =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-card"
            (List.filterMap identity
                [ Maybe.map (\v -> Node.attribute "variant" (variantString v)) cfg.variant
                , if cfg.actionable then
                    Just (Node.property "actionable" (Encode.bool True))

                  else
                    Nothing
                , if cfg.inline then
                    Just (Node.property "inline" (Encode.bool True))

                  else
                    Nothing
                ]
            )
            (List.filterMap identity
                [ mediaSection cfg.media
                , contentSection cfg.headline cfg.subhead
                , actionsSection cfg.actions
                , footerSection cfg.footer
                ]
                ++ cfg.body
            )
        )



-- INTERNAL RENDER HELPERS -----------------------------------------------


mediaSection : Maybe (Node msg) -> Maybe (Node msg)
mediaSection maybeMedia =
    Maybe.map
        (\m -> Node.element "div" [ Node.attribute "slot" "header" ] [ m ])
        maybeMedia


contentSection : Maybe (Node msg) -> Maybe (Node msg) -> Maybe (Node msg)
contentSection maybeHeadline maybeSubhead =
    case List.filterMap identity [ maybeHeadline, maybeSubhead ] of
        [] ->
            Nothing

        parts ->
            Just (Node.element "div" [ Node.attribute "slot" "content" ] parts)


actionsSection : List (Node msg) -> Maybe (Node msg)
actionsSection actionNodes =
    case actionNodes of
        [] ->
            Nothing

        _ ->
            Just (Node.element "div" [ Node.attribute "slot" "actions" ] actionNodes)


footerSection : Maybe (Node msg) -> Maybe (Node msg)
footerSection maybeFooter =
    Maybe.map
        (\f -> Node.element "div" [ Node.attribute "slot" "footer" ] [ f ])
        maybeFooter


variantString : Variant -> String
variantString v =
    case v of
        Elevated ->
            "elevated"

        Filled ->
            "filled"

        Outlined ->
            "outlined"
