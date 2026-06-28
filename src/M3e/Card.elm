module M3e.Card exposing
    ( Option, Variant(..), ButtonType(..)
    , variant, actionable, inline, media, headline, subhead, body, actions, footer
    , formType, name, value
    , view
    )

{-| `<m3e-card>` — a flexible content container (Material 3 Cards).

Spec (per docs/CONVENTIONS.md):

  - Required: (none — container only, variant optional)
  - Options: variant, actionable, inline, media, headline, subhead,
    body, actions, footer
  - Slots:
    header : region (free row — any Element; wrapped in div[slot=header])
    content : region (free row — headline + subhead; wrapped in div[slot=content])
    actions : homogeneous List (Element { button : Supported })
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

@docs Option, Variant, ButtonType


# Options

@docs variant, actionable, inline, media, headline, subhead, body, actions, footer
@docs formType, name, value

@docs view

-}

import Cem.M3e.Card as Cem
import Json.Encode as Encode
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)



-- TYPES ------------------------------------------------------------------


{-| Container style — `Elevated`, `Filled`, or `Outlined`.
-}
type Variant
    = Elevated
    | Filled
    | Outlined


{-| Form submission type for a card acting as a form submitter.
Upstream: `FormSubmitter` mixin → `type` attribute (`FormSubmitterType`),
default `"button"`. Only relevant when using the card as an interactive button
in a form context (i.e. when `actionable = True`).
-}
type ButtonType
    = Submit
    | Reset
    | Button


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
    , formType : Maybe ButtonType
    , name : Maybe String
    , value : Maybe String
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
    , formType = Nothing
    , name = Nothing
    , value = Nothing
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
media : Element any msg -> Option msg
media item =
    Internal.option (\c -> { c | media = Just (Element.toNode item) })


{-| Headline shown in the card's `content` slot.
-}
headline : Element any msg -> Option msg
headline item =
    Internal.option (\c -> { c | headline = Just (Element.toNode item) })


{-| Subhead shown beneath the headline in the card's `content` slot.
-}
subhead : Element any msg -> Option msg
subhead item =
    Internal.option (\c -> { c | subhead = Just (Element.toNode item) })


{-| Body content placed in the card's default slot (no slot wrapper).
-}
body : List (Element any msg) -> Option msg
body items =
    Internal.option (\c -> { c | body = List.map Element.toNode items })


{-| Action buttons shown in the card's `actions` slot.
-}
actions : List (Element { s | button : Supported } msg) -> Option msg
actions items =
    Internal.option (\c -> { c | actions = List.map Element.toNode items })


{-| Footer content shown in the card's `footer` region.
-}
footer : Element any msg -> Option msg
footer item =
    Internal.option (\c -> { c | footer = Just (Element.toNode item) })


{-| Set the form submission type. Only meaningful when the card is actionable
and inside a `<form>`. Upstream: `FormSubmitter` mixin → `type` attribute.
-}
formType : ButtonType -> Option msg
formType v =
    Internal.option (\c -> { c | formType = Just v })


{-| Set the form field name (the `name` attribute on `<m3e-card>`).
Upstream: `FormSubmitter` mixin → `name` attribute.
-}
name : String -> Option msg
name v =
    Internal.option (\c -> { c | name = Just v })


{-| Set the submitted value (the `value` attribute on `<m3e-card>`).
Upstream: `FormSubmitter` mixin → `value` attribute.
-}
value : String -> Option msg
value v =
    Internal.option (\c -> { c | value = Just v })



-- VIEW ------------------------------------------------------------------


{-| Render the card.
-}
view : List (Option msg) -> Element { s | card : Supported } msg
view opts =
    let
        cfg : Config msg
        cfg =
            Internal.applyOptions opts defaultConfig
    in
    Internal.fromNode
        (Node.element "m3e-card"
            (List.filterMap identity
                [ Maybe.map (\v -> Node.attribute "variant" (Cem.variantToString (toCemVariant v))) cfg.variant
                , Just (Node.property "actionable" (Encode.bool cfg.actionable))
                , Just (Node.property "inline" (Encode.bool cfg.inline))
                , Maybe.map (\t -> Node.attribute "type" (toTypeString t)) cfg.formType
                , Maybe.map (\v -> Node.attribute "name" v) cfg.name
                , Maybe.map (\v -> Node.attribute "value" v) cfg.value
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


toTypeString : ButtonType -> String
toTypeString t =
    case t of
        Submit ->
            "submit"

        Reset ->
            "reset"

        Button ->
            "button"


{-| Map the local variant to the generated `Cem.M3e.Card` enum, whose
`variantToString` is the single source of truth for the attribute value (kept
in sync with the element's CEM, so the string can't drift — #45).
-}
toCemVariant : Variant -> Cem.Variant
toCemVariant v =
    case v of
        Elevated ->
            Cem.Elevated

        Filled ->
            Cem.Filled

        Outlined ->
            Cem.Outlined
