module Route.Components.Name_ exposing (ActionData, Data, Model, Msg, route)

{-| The per-component **API reference** page (`/components/:slug`), re-authored on the
new Vocab API (opus). Data-driven: one pre-rendered page per component in
`data/reference.json`, each showing the component name, overview, and its API members
(types + functions with signatures + docs) in the content-pane + card pattern using
real `M3e.*` components. (The original also embedded per-component _live demos_, which
imported all 55 component modules; those are deferred — this restores the reference.)
-}

import BackendTask exposing (BackendTask)
import BackendTask.File
import Dict exposing (Dict)
import Doc
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Head
import Json.Decode as Decode
import Kit
import Layout
import M3e.ButtonSegment as ButtonSegment
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.List as List_
import M3e.ListItem as ListItem
import M3e.Record.Heading as Heading
import M3e.SegmentedButton as SegmentedButton
import M3e.Value as Value exposing (Supported)
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import UrlPath exposing (UrlPath)
import View exposing (View)


{-| Which API layer each Usage example is shown in: the strict top (`M3e.*`), the
loose middle (`M3e.Cem.*`), the bottom (`M3e.Cem.Html.*`), or the raw `<m3e-*>`
HTML. Every shipped example carries all four (verified supersets of each other),
so the per-example tab strip is never partial.
-}
type Layer
    = Top
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


type alias RouteParams =
    { name : String }


type alias Member =
    { name : String, kind : String, signature : String, doc : String }


type alias Component =
    { name : String, slug : String, overview : String, members : List Member }


{-| A verified Usage example: its live-preview HTML and the derived Elm in each
API layer (top/middle/bottom). `section` groups examples under a sub-heading
("" = ungrouped).
-}
type alias UsageExample =
    { title : String
    , section : String
    , html : String
    , top : String
    , mid : String
    , bottom : String
    }


type alias Data =
    { component : Component, usage : List UsageExample }


type alias ActionData =
    {}


memberDecoder : Decode.Decoder Member
memberDecoder =
    Decode.map4 Member
        (Decode.field "name" Decode.string)
        (Decode.field "kind" Decode.string)
        (Decode.field "signature" Decode.string)
        (Decode.field "doc" Decode.string)


componentDecoder : Decode.Decoder Component
componentDecoder =
    Decode.map4 Component
        (Decode.field "name" Decode.string)
        (Decode.field "slug" Decode.string)
        (Decode.field "overview" Decode.string)
        (Decode.field "members" (Decode.list memberDecoder))


usageExampleDecoder : Decode.Decoder UsageExample
usageExampleDecoder =
    Decode.map6 UsageExample
        (Decode.field "title" Decode.string)
        (Decode.oneOf [ Decode.field "section" Decode.string, Decode.succeed "" ])
        (Decode.field "html" Decode.string)
        (Decode.field "top" Decode.string)
        (Decode.field "mid" Decode.string)
        (Decode.field "bottom" Decode.string)


allComponents : BackendTask FatalError (List Component)
allComponents =
    BackendTask.File.jsonFile (Decode.list componentDecoder) "data/reference.json"
        |> BackendTask.allowFatal


{-| All Usage examples keyed by component slug. Missing file / entry ⇒ no Usage.
-}
allUsage : BackendTask FatalError (Dict String (List UsageExample))
allUsage =
    BackendTask.File.jsonFile
        (Decode.dict (Decode.field "examples" (Decode.list usageExampleDecoder)))
        "data/examples.json"
        |> BackendTask.allowFatal


route : StatefulRoute RouteParams Data ActionData Model Msg
route =
    RouteBuilder.preRender { head = head, pages = pages, data = data }
        |> RouteBuilder.buildWithLocalState
            { view = view
            , init = init
            , update = update
            , subscriptions = subscriptions
            }


init : App Data ActionData RouteParams -> Shared.Model -> ( Model, Effect Msg )
init _ _ =
    ( { layers = Dict.empty }, Effect.none )


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ msg model =
    case msg of
        SelectLayer index layer ->
            ( { model | layers = Dict.insert index layer model.layers }, Effect.none )


subscriptions : RouteParams -> UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions _ _ _ _ =
    Sub.none


pages : BackendTask FatalError (List RouteParams)
pages =
    allComponents |> BackendTask.map (List.map (\c -> { name = c.slug }))


data : RouteParams -> BackendTask FatalError Data
data routeParams =
    BackendTask.map2 Data
        (componentFor routeParams)
        (allUsage |> BackendTask.map (Dict.get routeParams.name >> Maybe.withDefault []))


componentFor : RouteParams -> BackendTask FatalError Component
componentFor routeParams =
    allComponents
        |> BackendTask.andThen
            (\components ->
                case List.filter (\c -> c.slug == routeParams.name) components of
                    c :: _ ->
                        BackendTask.succeed c

                    [] ->
                        BackendTask.fail (FatalError.fromString ("Unknown component: " ++ routeParams.name))
            )


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    []


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view app _ model =
    let
        component : Component
        component =
            app.data.component
    in
    { title = component.name ++ " · elm-m3e"
    , body =
        [ Element.toNode
            (Element.map PagesMsg.fromMsg
                (pane
                    [ -- One vertical rhythm (`space-y-10`) governs every top-level doc
                      -- section — intro, Usage, API — so their spacing is uniform.
                      Layout.div "space-y-10"
                        (Layout.div "space-y-4"
                            [ Heading.view { content = Kit.text component.name }
                                [ Heading.variant Value.display, Heading.size Value.small, Heading.level 1 ]
                                []
                            , Layout.div "max-w-2xl text-on-surface-variant"
                                [ Doc.markdown component.overview ]
                            ]
                            :: usageBlocks model app.data.usage
                            ++ [ apiSection component.members ]
                        )
                    ]
                )
            )
        ]
    }


{-| The API-reference section: a heading over an outlined card listing every member.
-}
apiSection : List Member -> Element { s | html : Supported, heading : Supported, card : Supported } msg
apiSection members =
    Layout.div "space-y-4"
        [ Heading.view { content = Kit.text "API" }
            [ Heading.variant Value.headline, Heading.size Value.small, Heading.level 2 ]
            []
        , Card.view [ Card.variant Value.outlined ]
            [ Card.content (List_.view [] (List_.children (List.map memberRow members))) ]
        ]


{-| Render the Usage section as a single spacing-consistent block: a "Usage"
heading over its per-section sub-headings and examples. Empty ⇒ nothing (so it
drops cleanly out of the top-level `space-y-10` rhythm).
-}
usageBlocks : Model -> List UsageExample -> List (Element { s | html : Supported, heading : Supported, card : Supported, segmentedButton : Supported } Msg)
usageBlocks model examples =
    case examples of
        [] ->
            []

        _ ->
            [ Layout.div "space-y-6"
                (Heading.view { content = Kit.text "Usage" }
                    [ Heading.variant Value.headline, Heading.size Value.small, Heading.level 2 ]
                    []
                    :: List.concatMap (sectionBlock model)
                        (groupBySection (List.indexedMap Tuple.pair examples))
                )
            ]


{-| One section: an optional sub-heading (skipped for the ungrouped "" section)
followed by each example's live preview paired with its per-example code tabs.
Examples carry their page-global index so each tab strip stays independent.
-}
sectionBlock : Model -> ( String, List ( Int, UsageExample ) ) -> List (Element { s | html : Supported, heading : Supported, card : Supported, segmentedButton : Supported } Msg)
sectionBlock model ( section, examples ) =
    let
        heading : List (Element { s | html : Supported, heading : Supported, card : Supported, segmentedButton : Supported } Msg)
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
between the API layers: strict top (`M3e.*`), loose middle (`M3e.Cem.*`), bottom
(`M3e.Cem.Html.*`), or raw HTML. Every example carries all four, so the tabs are
never partial; the selection lives in `model.layers` keyed by this example's
index, defaulting to `Top`. Grouped as one `space-y-3` block so title/preview/
tabs/code stay tight while sections stay apart.
-}
exampleBlock : Model -> ( Int, UsageExample ) -> Element { s | html : Supported, heading : Supported, card : Supported, segmentedButton : Supported } Msg
exampleBlock model ( index, ex ) =
    let
        layer : Layer
        layer =
            Dict.get index model.layers |> Maybe.withDefault Top
    in
    Layout.div "space-y-3"
        [ Kit.paragraph Value.medium [ Kit.onSurfaceVariant ] [ Kit.text ex.title ]
        , Doc.showcase (Doc.rawPreview ex.html)
        , layerTabs index layer
        , codeFor layer ex
        ]


{-| The per-example tab strip: a single-select `SegmentedButton` (the same control
the app already uses for its theme toggles) whose checked segment is this example's
current layer and whose clicks record a `SelectLayer` for this example's index only.
-}
layerTabs : Int -> Layer -> Element { s | segmentedButton : Supported } Msg
layerTabs index current =
    SegmentedButton.view []
        (List.map
            (\( label, layer ) ->
                SegmentedButton.child
                    (ButtonSegment.view
                        [ ButtonSegment.checked (layer == current)
                        , ButtonSegment.onClick (SelectLayer index layer)
                        ]
                        [ ButtonSegment.child (Kit.text label) ]
                    )
            )
            [ ( "Top", Top ), ( "Middle", Middle ), ( "Bottom", Bottom ), ( "HTML", Raw ) ]
        )


{-| The code block for the selected layer. The three Elm layers highlight as Elm;
the raw `<m3e-*>` HTML layer highlights as plain markup.
-}
codeFor : Layer -> UsageExample -> Element { s | html : Supported } msg
codeFor layer ex =
    case layer of
        Top ->
            Doc.code_ Doc.Elm ex.top

        Middle ->
            Doc.code_ Doc.Elm ex.mid

        Bottom ->
            Doc.code_ Doc.Elm ex.bottom

        Raw ->
            Doc.code_ Doc.NoLang ex.html


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


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


{-| One API member: an optional kind overline (only for non-`value` kinds such
as `type` — the ubiquitous "value" eyebrow was pure noise), the syntax-highlighted
`name : signature`, and its Markdown-rendered doc.
-}
memberRow : Member -> Element { s | listItem : Supported } msg
memberRow m =
    ListItem.view []
        ((if m.kind == "" || m.kind == "value" then
            []

          else
            [ ListItem.overline (Kit.text m.kind) ]
         )
            ++ ListItem.child
                (Doc.elmSignature
                    (if m.signature == "" then
                        m.name

                     else
                        m.name ++ " : " ++ m.signature
                    )
                )
            :: (if m.doc == "" then
                    []

                else
                    [ ListItem.supportingText (Doc.markdown m.doc) ]
               )
        )
