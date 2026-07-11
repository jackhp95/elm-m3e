module Doc.Usage exposing
    ( Layer
    , Model
    , Msg
    , UsageExample
    , init
    , update
    , usageBlocks
    , usageExampleDecoder
    )

import Dict exposing (Dict)
import Doc
import Doc.Slider
import Json.Decode as Decode
import Kit
import Layout
import M3e
import M3e.Element exposing (Element)
import M3e.Record.Heading as Heading
import M3e.Tab as Tab
import M3e.Token as Value exposing (Supported)


{-| Which API surface a Usage example is shown in, by module name:

  - `Top` — `M3e` (the strict Standard surface, always present)
  - `Record` — `M3e.Record` (the ④ record-of-slots surface; per-example)
  - `Build` — `M3e.Build` (the ⑤ pipeline surface; per-example)
  - `Middle` — `M3e.Html` (loose, always present)
  - `Bottom` — `M3e.Raw` (raw elm/html-flavoured, always present)
  - `Raw` — the raw `<m3e-*>` HTML (always present)

`M3e`, `M3e.Html`, `M3e.Raw` and `HTML` are verified for every example, so
those four tabs are always offered. `M3e.Record` / `M3e.Build` are offered
whenever `M3e` (`top`) is — when their own field is non-null they show a real
translation, and when it's null they show an _identical-by-design_ rationale
(the example's content carried nothing for that surface to enforce). Only a
composite with no single-component `top` form drops them entirely.

-}
type Layer
    = Top
    | Record
    | Build
    | Middle
    | Bottom
    | Raw


{-| Per-example layer selection, keyed by each example's global index on the page
(assigned before section grouping). A missing key means the example is still on
its default top layer — so the model starts empty and only records deviations,
and each example's tabs move independently of every other's.
-}
type alias Model =
    { layers : Dict Int Layer }


type Msg
    = SelectLayer Int Layer


init : Model
init =
    { layers = Dict.empty }


update : Msg -> Model -> Model
update (SelectLayer index layer) model =
    { model | layers = Dict.insert index layer model.layers }


{-| A verified Usage example: its live-preview HTML and the derived Elm in each
API surface. Every Elm surface is optional — `top`/`mid`/`bottom` (M3e /
M3e.Html / M3e.Raw) and `record` (M3e.Record) / `build` (M3e.Build) are each
present only when that surface compiled to a distinct form for this example (else
`Nothing`; the UI hides the `top`/`mid`/`bottom` tab, but keeps `record`/`build`
as an identical-by-design rationale tab). `html` is the one guaranteed surface — its live preview always
renders. `section` groups examples under a sub-heading ("" = ungrouped).
-}
type alias UsageExample =
    { title : String
    , section : String
    , html : String
    , top : Maybe String
    , mid : Maybe String
    , bottom : Maybe String
    , record : Maybe String
    , build : Maybe String
    }


usageExampleDecoder : Decode.Decoder UsageExample
usageExampleDecoder =
    Decode.map8 UsageExample
        (Decode.field "title" Decode.string)
        (Decode.oneOf [ Decode.field "section" Decode.string, Decode.succeed "" ])
        (Decode.field "html" Decode.string)
        (Decode.oneOf [ Decode.field "top" (Decode.nullable Decode.string), Decode.succeed Nothing ])
        (Decode.oneOf [ Decode.field "mid" (Decode.nullable Decode.string), Decode.succeed Nothing ])
        (Decode.oneOf [ Decode.field "bottom" (Decode.nullable Decode.string), Decode.succeed Nothing ])
        (Decode.oneOf [ Decode.field "record" (Decode.nullable Decode.string), Decode.succeed Nothing ])
        (Decode.oneOf [ Decode.field "build" (Decode.nullable Decode.string), Decode.succeed Nothing ])


{-| Render the Usage section as a single spacing-consistent block: a "Usage"
heading over its per-section sub-headings and examples. Empty ⇒ nothing (so it
drops cleanly out of the top-level `space-y-10` rhythm).

`offset` shifts every example's page-global index so that stacked components on
one page get disjoint tab-state ranges in a shared `Model`.

-}
usageBlocks : Int -> Model -> List UsageExample -> List (Element { s | html : Supported, heading : Supported, card : Supported, tabs : Supported } Msg)
usageBlocks offset model examples =
    case examples of
        [] ->
            []

        _ ->
            [ Layout.div "space-y-6"
                (Heading.view { content = Kit.text "Usage" }
                    [ Heading.variant Value.headline, Heading.size Value.small, Heading.level 2 ]
                    []
                    :: List.concatMap (sectionBlock model)
                        (groupBySection (List.indexedMap (\i ex -> ( offset + i, ex )) examples))
                )
            ]


{-| One section: an optional sub-heading (skipped for the ungrouped "" section)
followed by each example's live preview paired with its per-example code tabs.
Examples carry their page-global index so each tab strip stays independent.
-}
sectionBlock : Model -> ( String, List ( Int, UsageExample ) ) -> List (Element { s | html : Supported, heading : Supported, card : Supported, tabs : Supported } Msg)
sectionBlock model ( section, examples ) =
    let
        heading : List (Element { s | html : Supported, heading : Supported, card : Supported, tabs : Supported } Msg)
        heading =
            if section == "" then
                []

            else
                [ Heading.view { content = Kit.text section }
                    [ Heading.variant Value.title, Heading.size Value.large, Heading.level 3 ]
                    []
                ]
    in
    heading ++ List.map (exampleBlock model) examples


{-| A live preview paired with a per-example tab strip that switches its code
between the API surfaces by module name (optionally `M3e`, `M3e.Record` /
`M3e.Build`, `M3e.Html`, `M3e.Raw`, and always `HTML`). The selection lives in
`model.layers` keyed by this example's index, defaulting to the first available
surface (`defaultLayerFor`). Grouped as one
`space-y-3` block so title/preview/tabs/code stay tight while sections stay apart.
-}
exampleBlock : Model -> ( Int, UsageExample ) -> Element { s | html : Supported, heading : Supported, card : Supported, tabs : Supported } Msg
exampleBlock model ( index, ex ) =
    let
        layer : Layer
        layer =
            Dict.get index model.layers |> Maybe.withDefault (defaultLayerFor ex)
    in
    Layout.div "space-y-3"
        [ Kit.paragraph Value.medium [ Kit.onSurfaceVariant ] [ Kit.text ex.title ]
        , Doc.showcase (Doc.rawPreview ex.html)
        , layerTabs index layer ex
        , Doc.Slider.slidingPanels
            (activeIndexFor layer ex)
            (List.map (\( _, l ) -> codeFor l ex) (layersFor ex))
        ]


{-| The 0-based position of the selected `layer` within `layersFor ex` — the panel
`slidingPanels` translates into view. Every panel in `layersFor ex` is mounted (one
`codeFor` surface each) so the prior panel can slide out as the new one slides in;
this index just drives the track offset. Clamps to 0 if the layer isn't offered
(unreachable — the selection comes from `defaultLayerFor`/a tab click, both drawn
from `layersFor`).
-}
activeIndexFor : Layer -> UsageExample -> Int
activeIndexFor layer ex =
    layersFor ex
        |> List.map Tuple.second
        |> List.indexedMap Tuple.pair
        |> List.filter (\( _, l ) -> l == layer)
        |> List.head
        |> Maybe.map Tuple.first
        |> Maybe.withDefault 0


{-| The surfaces offered for one example, in fixed order. Each Elm surface
(`M3e`, `M3e.Record`, `M3e.Build`, `M3e.Html`, `M3e.Raw`) appears only when
it compiled for this example (its field is non-null); `HTML` is the one universal
surface and is always offered last. Order: M3e, M3e.Record, M3e.Build, M3e.Html,
M3e.Raw, HTML.
-}
layersFor : UsageExample -> List ( String, Layer )
layersFor ex =
    let
        optional : Maybe String -> String -> Layer -> List ( String, Layer )
        optional field label layer =
            case field of
                Just _ ->
                    [ ( label, layer ) ]

                Nothing ->
                    []

        -- Record/Build are offered whenever the top surface exists. When their
        -- own field is present they show a real translation; when it's null they
        -- show an identical-by-design rationale (see `codeFor`) instead of being
        -- silently hidden. Only a null `top` (a composite with no single-component
        -- form) drops them entirely.
        recordBuild : Maybe String -> String -> Layer -> List ( String, Layer )
        recordBuild field label layer =
            case ( field, ex.top ) of
                ( Nothing, Nothing ) ->
                    []

                _ ->
                    [ ( label, layer ) ]
    in
    optional ex.top "M3e" Top
        ++ recordBuild ex.record "M3e.Record" Record
        ++ recordBuild ex.build "M3e.Build" Build
        ++ optional ex.mid "M3e.Html" Middle
        ++ optional ex.bottom "M3e.Raw" Bottom
        ++ [ ( "HTML", Raw ) ]


{-| The layer an example opens on when the user hasn't chosen one: the first
surface `layersFor` offers (its strictest available Elm surface, or `HTML` when
no Elm surface compiled). `HTML` is always present, so the fallback is total.
-}
defaultLayerFor : UsageExample -> Layer
defaultLayerFor ex =
    layersFor ex |> List.head |> Maybe.map Tuple.second |> Maybe.withDefault Raw


{-| The per-example surface selector: a single-select `Tabs` bar whose selected
tab is this example's current layer and whose clicks record a `SelectLayer` for
this example's index only. The tabs are dynamic per example (four to six); `Tabs`
paginates/scrolls them horizontally on narrow viewports natively, so there's no
`overflow-x-auto` wrapper — that wrapper forces `overflow-y: auto` (CSS spec) and
trips a spurious vertical scrollbar on the control's state-layer bleed.
-}
layerTabs : Int -> Layer -> UsageExample -> Element { s | html : Supported, tabs : Supported } Msg
layerTabs index current ex =
    M3e.tabs []
        (List.map
            (\( label, layer ) ->
                M3e.tab
                    [ M3e.attrSelected (layer == current)
                    , Tab.onClick (SelectLayer index layer)
                    ]
                    [ Kit.text label ]
            )
            (layersFor ex)
        )


{-| The code block for the selected surface. The Elm surfaces highlight as Elm;
the raw `<m3e-*>` HTML surface highlights as plain markup.

`Top`/`Middle`/`Bottom` are only offered by `layersFor` when their field is
present, so their `Nothing` branch is defensive (falls back to HTML). `Record`
and `Build` ARE offered with a null field — when this example's content had
nothing for that surface to lift, the surface is identical to `M3e` by design, so
we show a short rationale instead of a hollow duplicate.

-}
codeFor : Layer -> UsageExample -> Element { s | html : Supported } msg
codeFor layer ex =
    let
        elmOrHtml : Maybe String -> Element { s | html : Supported } msg
        elmOrHtml field =
            case field of
                Just code ->
                    Doc.code_ Doc.Elm code

                Nothing ->
                    Doc.code_ Doc.Xml ex.html

        recordBuildCode : Maybe String -> String -> Element { s | html : Supported } msg
        recordBuildCode field surface =
            case field of
                Just code ->
                    Doc.code_ Doc.Elm code

                Nothing ->
                    identicalSurfaceNote surface
    in
    case layer of
        Top ->
            elmOrHtml ex.top

        Record ->
            recordBuildCode ex.record "M3e.Record"

        Build ->
            recordBuildCode ex.build "M3e.Build"

        Middle ->
            elmOrHtml ex.mid

        Bottom ->
            elmOrHtml ex.bottom

        Raw ->
            Doc.code_ Doc.Xml ex.html


{-| Shown on a `Record`/`Build` tab whose surface is identical to `M3e` for this
example: the example's content carried no required slots or attributes for the
record/pipeline surface to enforce, so the translator emitted no distinct form.
We surface that fact rather than hiding the tab (a hidden tab reads as "this
surface doesn't apply", which is the wrong lesson — it applies, it's just a no-op
here).
-}
identicalSurfaceNote : String -> Element { s | html : Supported } msg
identicalSurfaceNote surface =
    Doc.message
        (surface
            ++ " is identical to the M3e tab for this example — its content has no required slots or attributes for the "
            ++ surface
            ++ " surface to enforce, so it would be a hollow duplicate of M3e. Reach for "
            ++ surface
            ++ " on an example whose composition it can hold a guarantee over."
        )


{-| Group indexed examples by `.section`, preserving first-seen order of both
sections and examples within each section (indices stay attached).
-}
groupBySection : List ( Int, UsageExample ) -> List ( String, List ( Int, UsageExample ) )
groupBySection examples =
    let
        sections : List String
        sections =
            List.foldl
                (\( _, ex ) acc ->
                    if List.member ex.section acc then
                        acc

                    else
                        acc ++ [ ex.section ]
                )
                []
                examples
    in
    List.map (\sec -> ( sec, List.filter (\( _, ex ) -> ex.section == sec) examples )) sections
