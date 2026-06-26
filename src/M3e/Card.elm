module M3e.Card exposing
    ( Card, Variant(..)
    , new
    , withVariant, withActionable, withInline
    , withMedia, withHeadline, withSubhead, withBody, withActions, withFooter
    , toNode
    )

{-| `<m3e-card>` — a flexible content container (Material 3 Cards).

Spec (per docs/CONVENTIONS.md):

  - Required:   (none — container only, variant optional)
  - Options:    variant, actionable, inline
  - Slots:
      header   : region (free row — any Renderable; wrapped in div[slot=header])
      content  : region (free row — headline + subhead; wrapped in div[slot=content])
      actions  : homogeneous List (Renderable { button : Supported })
      footer   : region (free row)
      (default): free row — withBody items, no slot injected
  - Properties: actionable, inline (DOM properties)
  - Attrs:      variant
  - Escape:     html (default slot / all regions)
  - Tag:        card

`withBody` items go into the card's DEFAULT SLOT (no slot wrapper) so that
existing code and the IntrospectionTest (which counts direct children) keep
working: with only `withBody` set, the card's children are exactly the body
items.

-}

import Json.Encode as Encode
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


type Card msg
    = Card (Config msg)



-- CONSTRUCTOR ------------------------------------------------------------


new : Card msg
new =
    Card
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



-- MODIFIERS --------------------------------------------------------------


withVariant : Variant -> Card msg -> Card msg
withVariant v (Card cfg) =
    Card { cfg | variant = Just v }


withActionable : Bool -> Card msg -> Card msg
withActionable b (Card cfg) =
    Card { cfg | actionable = b }


withInline : Bool -> Card msg -> Card msg
withInline b (Card cfg) =
    Card { cfg | inline = b }


withMedia : Renderable any msg -> Card msg -> Card msg
withMedia item (Card cfg) =
    Card { cfg | media = Just (Renderable.toNode item) }


withHeadline : Renderable any msg -> Card msg -> Card msg
withHeadline item (Card cfg) =
    Card { cfg | headline = Just (Renderable.toNode item) }


withSubhead : Renderable any msg -> Card msg -> Card msg
withSubhead item (Card cfg) =
    Card { cfg | subhead = Just (Renderable.toNode item) }


{-| Add items to the card's DEFAULT slot (no slot wrapper). Keeps the
IntrospectionTest's child-count assertion working.
-}
withBody : List (Renderable any msg) -> Card msg -> Card msg
withBody items (Card cfg) =
    Card { cfg | body = List.map Renderable.toNode items }


withActions : List (Renderable { s | button : Supported } msg) -> Card msg -> Card msg
withActions items (Card cfg) =
    Card { cfg | actions = List.map Renderable.toNode items }


withFooter : Renderable any msg -> Card msg -> Card msg
withFooter item (Card cfg) =
    Card { cfg | footer = Just (Renderable.toNode item) }



-- RENDER -----------------------------------------------------------------


toNode : Card msg -> Node msg
toNode (Card cfg) =
    Node.element "m3e-card"
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


mediaSection : Maybe (Node msg) -> Maybe (Node msg)
mediaSection media =
    Maybe.map
        (\m -> Node.element "div" [ Node.attribute "slot" "header" ] [ m ])
        media


contentSection : Maybe (Node msg) -> Maybe (Node msg) -> Maybe (Node msg)
contentSection headline subhead =
    case List.filterMap identity [ headline, subhead ] of
        [] ->
            Nothing

        parts ->
            Just (Node.element "div" [ Node.attribute "slot" "content" ] parts)


actionsSection : List (Node msg) -> Maybe (Node msg)
actionsSection actions =
    case actions of
        [] ->
            Nothing

        _ ->
            Just (Node.element "div" [ Node.attribute "slot" "actions" ] actions)


footerSection : Maybe (Node msg) -> Maybe (Node msg)
footerSection footer =
    Maybe.map
        (\f -> Node.element "div" [ Node.attribute "slot" "footer" ] [ f ])
        footer


variantString : Variant -> String
variantString v =
    case v of
        Elevated ->
            "elevated"

        Filled ->
            "filled"

        Outlined ->
            "outlined"
