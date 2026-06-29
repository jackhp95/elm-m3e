module M3e.Card exposing
    ( Option, Orientation, ButtonType
    , variant, orientation, actionable, inline, media, headline, subhead, body, actions, footer
    , formType, name, value
    , href, target, rel, download
    , view
    )

{-| `<m3e-card>` — a flexible content container (Material 3 Cards).

Spec (per docs/CONVENTIONS.md):

  - Required: (none — container only, variant optional)
  - Options: variant, orientation, actionable, inline, media, headline, subhead,
    body, actions, footer, href, target, rel, download
  - Slots:
    header : region (free row — any Element; wrapped in div[slot=header])
    content : region (free row — headline + subhead; wrapped in div[slot=content])
    actions : homogeneous List (Element { button : Supported })
    footer : region (free row)
    (default): free row — body items, no slot injected
  - Properties: actionable, inline (DOM properties)
  - Attrs: variant, orientation, href, target, rel, download
  - Escape: html (default slot / all regions)
  - Tag: card

`body` items go into the card's DEFAULT SLOT (no slot wrapper) so that
existing code and the IntrospectionTest (which counts direct children) keep
working: with only `body` set, the card's children are exactly the body items.


# Type

@docs Option, Orientation, ButtonType


# Options

@docs variant, orientation, actionable, inline, media, headline, subhead, body, actions, footer
@docs formType, name, value
@docs href, target, rel, download

@docs view

-}

import Json.Encode as Encode
import M3e.Attr as Attr
import M3e.Element as Element exposing (Element, Supported)
import M3e.Internal as Internal
import M3e.Node as Node exposing (Node)
import M3e.Value as Value exposing (Value)



-- TYPES ------------------------------------------------------------------


{-| Container style — `elevated`, `filled`, or `outlined`, supplied as shared
[`M3e.Value`](M3e-Value) tokens.
-}
type alias Variants =
    Value
        { elevated : Supported
        , filled : Supported
        , outlined : Supported
        }


{-| Layout orientation of the card, supplied as shared
[`M3e.Value`](M3e-Value) tokens. Default
[`vertical`](M3e-Value#vertical).

Upstream: `orientation` attribute on `<m3e-card>` — `"vertical"` or
`"horizontal"`.

-}
type alias Orientation =
    Value
        { vertical : Supported
        , horizontal : Supported
        }


{-| Form submission type for a card acting as a form submitter, supplied as
shared [`M3e.Value`](M3e-Value) tokens. Upstream: `FormSubmitter` mixin →
`type` attribute (`FormSubmitterType`), default
[`button`](M3e-Value#button). Only relevant when using the card as an
interactive button in a form context (i.e. when `actionable = True`).
-}
type alias ButtonType =
    Value
        { submit : Supported
        , reset : Supported
        , button : Supported
        }


type alias Config msg =
    { variant : Maybe Variants
    , orientation : Maybe Orientation
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
    , href : Maybe String
    , target : Maybe String
    , rel : Maybe String
    , download : Maybe String
    }


{-| An opaque configuration option for [`view`](#view).
-}
type alias Option msg =
    Internal.Option (Config msg) msg


defaultConfig : Config msg
defaultConfig =
    { variant = Nothing
    , orientation = Nothing
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
    , href = Nothing
    , target = Nothing
    , rel = Nothing
    , download = Nothing
    }



-- OPTIONS ------------------------------------------------------------------


{-| Set the container style (`elevated`, `filled`, or `outlined`).
-}
variant : Variants -> Option msg
variant v =
    Internal.option (\c -> { c | variant = Just v })


{-| Set the layout orientation (`Vertical` or `Horizontal`; default `Vertical`).

Upstream: `orientation` attribute on `<m3e-card>`.

-}
orientation : Orientation -> Option msg
orientation o =
    Internal.option (\c -> { c | orientation = Just o })


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


{-| Make the card a link to the given URL.

Upstream: `LinkButton` mixin → `href` attribute on `<m3e-card>`.

-}
href : String -> Option msg
href =
    Attr.href


{-| Set the link target (e.g. `"_blank"`); only meaningful with [`href`](#href).

Upstream: `LinkButton` mixin → `target` attribute on `<m3e-card>`.

-}
target : String -> Option msg
target =
    Attr.target


{-| Set the link relationship (e.g. `"noreferrer noopener"`); only meaningful
with [`href`](#href).

Upstream: `LinkButton` mixin → `rel` attribute on `<m3e-card>`.

-}
rel : String -> Option msg
rel =
    Attr.rel


{-| Request the link target be downloaded (optionally with a new filename).
Only meaningful with [`href`](#href).

Upstream: `LinkButton` mixin → `download` attribute on `<m3e-card>`.

-}
download : String -> Option msg
download =
    Attr.download



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
                [ Maybe.map (\v -> Node.attribute "variant" (Value.toString v)) cfg.variant
                , Maybe.map (\o -> Node.attribute "orientation" (Value.toString o)) cfg.orientation
                , Just (Node.property "actionable" (Encode.bool cfg.actionable))
                , Just (Node.property "inline" (Encode.bool cfg.inline))
                , Maybe.map (\t -> Node.attribute "type" (Value.toString t)) cfg.formType
                , Maybe.map (\v -> Node.attribute "name" v) cfg.name
                , Maybe.map (\v -> Node.attribute "value" v) cfg.value
                , Maybe.map (\v -> Node.attribute "href" v) cfg.href
                , Maybe.map (\v -> Node.attribute "target" v) cfg.target
                , Maybe.map (\v -> Node.attribute "rel" v) cfg.rel
                , Maybe.map (\v -> Node.attribute "download" v) cfg.download
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


