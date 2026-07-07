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
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.List as List_
import M3e.ListItem as ListItem
import M3e.Record.Heading as Heading
import M3e.SuggestionChip as SuggestionChip
import M3e.Tab as Tab
import M3e.Tabs as Tabs
import M3e.Value as Value exposing (Supported)
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import UrlPath exposing (UrlPath)
import View exposing (View)


{-| Which API surface a Usage example is shown in, by module name:

  - `Top` — `M3e` (the strict Standard surface, always present)
  - `Record` — `M3e.Record` (the ④ record-of-slots surface; per-example)
  - `Build` — `M3e.Build` (the ⑤ pipeline surface; per-example)
  - `Middle` — `M3e.Cem` (loose, always present)
  - `Bottom` — `M3e.Cem.Html` (raw elm/html-flavoured, always present)
  - `Raw` — the raw `<m3e-*>` HTML (always present)

`M3e`, `M3e.Cem`, `M3e.Cem.Html` and `HTML` are verified for every example, so
those four tabs are always offered. `M3e.Record` / `M3e.Build` are offered only
when this example cleanly converts to that surface (its `record` / `build` field
is non-null) — a composite gallery has no single-component record/build form, so
those tabs are hidden rather than shown as a hollow duplicate of `M3e`.

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


type alias RouteParams =
    { name : String }


type alias Member =
    { name : String, kind : String, signature : String, doc : String, role : String }


type alias Component =
    { name : String
    , slug : String
    , category : String
    , summary : String
    , overview : String
    , members : List Member
    }


{-| A verified Usage example: its live-preview HTML and the derived Elm in each
API surface. `top`/`mid`/`bottom` (M3e / M3e.Cem / M3e.Cem.Html) are present for
every example; `record` (M3e.Record) and `build` (M3e.Build) are present only
when the example cleanly converts to that single-component surface (else
`Nothing`, so the UI hides the tab). `section` groups examples under a
sub-heading ("" = ungrouped).
-}
type alias UsageExample =
    { title : String
    , section : String
    , html : String
    , top : String
    , mid : String
    , bottom : String
    , record : Maybe String
    , build : Maybe String
    }


type alias Data =
    { component : Component, usage : List UsageExample }


type alias ActionData =
    {}


memberDecoder : Decode.Decoder Member
memberDecoder =
    Decode.map5 Member
        (Decode.field "name" Decode.string)
        (Decode.field "kind" Decode.string)
        (Decode.field "signature" Decode.string)
        (Decode.field "doc" Decode.string)
        (Decode.oneOf [ Decode.field "role" Decode.string, Decode.succeed "" ])


componentDecoder : Decode.Decoder Component
componentDecoder =
    Decode.map6 Component
        (Decode.field "name" Decode.string)
        (Decode.field "slug" Decode.string)
        (Decode.oneOf [ Decode.field "category" Decode.string, Decode.succeed "" ])
        (Decode.oneOf [ Decode.field "summary" Decode.string, Decode.succeed "" ])
        (Decode.field "overview" Decode.string)
        (Decode.field "members" (Decode.list memberDecoder))


usageExampleDecoder : Decode.Decoder UsageExample
usageExampleDecoder =
    Decode.map8 UsageExample
        (Decode.field "title" Decode.string)
        (Decode.oneOf [ Decode.field "section" Decode.string, Decode.succeed "" ])
        (Decode.field "html" Decode.string)
        (Decode.field "top" Decode.string)
        (Decode.field "mid" Decode.string)
        (Decode.field "bottom" Decode.string)
        (Decode.oneOf [ Decode.field "record" (Decode.nullable Decode.string), Decode.succeed Nothing ])
        (Decode.oneOf [ Decode.field "build" (Decode.nullable Decode.string), Decode.succeed Nothing ])


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
                      -- section — header, Usage, API — so their spacing is uniform.
                      Layout.div "space-y-10"
                        (header component
                            :: usageBlocks model app.data.usage
                            ++ [ apiSection component.members ]
                        )
                    ]
                )
            )
        ]
    }


{-| The page header, mirroring the matraic component pages: the component name as
a display heading (with its category chip alongside), the cleaned one-line CEM
summary, and a barrel-first install card. The verbose Component Info / Events /
Slots prose that used to trail the summary is dropped — the colocated API section
below now documents the same events and slots, so repeating them here was clutter.
-}
header : Component -> Element { s | html : Supported, heading : Supported, suggestionChip : Supported } msg
header component =
    Layout.div "space-y-4"
        (Layout.div "flex flex-wrap items-center gap-3"
            (Heading.view { content = Kit.text component.name }
                [ Heading.variant Value.display, Heading.size Value.small, Heading.level 1 ]
                []
                :: categoryChip component.category
            )
            :: summaryBlock component.summary
            ++ [ installCard ]
        )


{-| The component's category as a non-interactive suggestion chip, alongside the
title. Empty ⇒ nothing (many derived/record modules carry no category).
-}
categoryChip : String -> List (Element { s | suggestionChip : Supported } msg)
categoryChip cat =
    if cat == "" then
        []

    else
        [ SuggestionChip.view [] [ SuggestionChip.child (Kit.text cat) ] ]


{-| The one-line summary paragraph, constrained to a comfortable reading measure.
Empty ⇒ nothing.
-}
summaryBlock : String -> List (Element { s | html : Supported } msg)
summaryBlock summary =
    if summary == "" then
        []

    else
        [ Layout.div "max-w-2xl"
            [ Kit.paragraph Value.large [ Kit.onSurfaceVariant ] [ Kit.text summary ] ]
        ]


{-| The install snippet: the barrel-first imports every Usage example's top
surface uses (`M3e.button`, `M3e.variant`, `M3e.Value.elevated`). Rendered as the
same filled, rounded code block the Usage section uses (matraic's install card is
a bare `<pre>`); wrapping it in an outlined Card would nest a surface-container
fill inside a card border — a box-in-box that fights the M3 surface roles.
-}
installCard : Element { s | html : Supported } msg
installCard =
    Doc.code_ Doc.Elm "import M3e\nimport M3e.Value"


{-| The API-reference section, rendered like an elm module page: the members
grouped by role (constructor + its colocated type aliases, then attribute setters,
slot setters, and events), each group an overline-labelled outlined card. Members
keep their `@docs` order within a group. Empty groups drop out.
-}
apiSection : List Member -> Element { s | html : Supported, heading : Supported, card : Supported, listItem : Supported } msg
apiSection members =
    Layout.div "space-y-6"
        (Heading.view { content = Kit.text "API" }
            [ Heading.variant Value.headline, Heading.size Value.small, Heading.level 2 ]
            []
            :: List.filterMap (apiGroup members) apiGroups
        )


{-| The API groups, in render order, each with the member roles it collects. The
constructor group also carries any exposed `type` aliases/unions so a caps/record
type sits beside the `view` that consumes it. The trailing group catches helper
values (e.g. `M3e.Action` combinators) that are neither attrs, slots, nor events.
-}
apiGroups : List ( String, List String )
apiGroups =
    [ ( "Constructor", [ "ctor", "type" ] )
    , ( "Attributes", [ "attr" ] )
    , ( "Slots", [ "slot" ] )
    , ( "Events", [ "event" ] )
    , ( "Other", [ "other", "" ] )
    ]


{-| One API group: an overline label over an outlined card listing its members.
`Nothing` when the group has no members, so it drops out of the section rhythm.
-}
apiGroup : List Member -> ( String, List String ) -> Maybe (Element { s | html : Supported, card : Supported, listItem : Supported } msg)
apiGroup members ( label, roles ) =
    case List.filter (\m -> List.member m.role roles) members of
        [] ->
            Nothing

        group ->
            Just
                (Layout.div "space-y-3"
                    [ Kit.overline [ Kit.onSurfaceVariant ] [ Kit.text label ]
                    , Card.view [ Card.variant Value.outlined ]
                        [ Card.content (List_.view [] (List_.children (List.map memberRow group))) ]
                    ]
                )


{-| Render the Usage section as a single spacing-consistent block: a "Usage"
heading over its per-section sub-headings and examples. Empty ⇒ nothing (so it
drops cleanly out of the top-level `space-y-10` rhythm).
-}
usageBlocks : Model -> List UsageExample -> List (Element { s | html : Supported, heading : Supported, card : Supported, tabs : Supported } Msg)
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
between the API surfaces by module name (`M3e`, optionally `M3e.Record` /
`M3e.Build`, `M3e.Cem`, `M3e.Cem.Html`, `HTML`). The selection lives in
`model.layers` keyed by this example's index, defaulting to `Top`. Grouped as one
`space-y-3` block so title/preview/tabs/code stay tight while sections stay apart.
-}
exampleBlock : Model -> ( Int, UsageExample ) -> Element { s | html : Supported, heading : Supported, card : Supported, tabs : Supported } Msg
exampleBlock model ( index, ex ) =
    let
        layer : Layer
        layer =
            Dict.get index model.layers |> Maybe.withDefault Top
    in
    Layout.div "space-y-3"
        [ Kit.paragraph Value.medium [ Kit.onSurfaceVariant ] [ Kit.text ex.title ]
        , Doc.showcase (Doc.rawPreview ex.html)
        , layerTabs index layer ex
        , codeFor layer ex
        ]


{-| The surfaces offered for one example, in fixed order. `M3e`, `M3e.Cem`,
`M3e.Cem.Html` and `HTML` are universal; `M3e.Record` / `M3e.Build` appear only
when this example converted to that single-component surface (its field is
non-null). Order: M3e, M3e.Record, M3e.Build, M3e.Cem, M3e.Cem.Html, HTML.
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
    in
    ( "M3e", Top )
        :: (optional ex.record "M3e.Record" Record
                ++ optional ex.build "M3e.Build" Build
                ++ [ ( "M3e.Cem", Middle )
                   , ( "M3e.Cem.Html", Bottom )
                   , ( "HTML", Raw )
                   ]
           )


{-| The per-example surface selector: a single-select `Tabs` bar whose selected
tab is this example's current layer and whose clicks record a `SelectLayer` for
this example's index only. The tabs are dynamic per example (four or six); `Tabs`
paginates/scrolls them horizontally on narrow viewports natively, so there's no
`overflow-x-auto` wrapper — that wrapper forces `overflow-y: auto` (CSS spec) and
trips a spurious vertical scrollbar on the control's state-layer bleed.
-}
layerTabs : Int -> Layer -> UsageExample -> Element { s | html : Supported, tabs : Supported } Msg
layerTabs index current ex =
    Tabs.view []
        (List.map
            (\( label, layer ) ->
                Tabs.child
                    (Tab.view
                        [ Tab.selected (layer == current)
                        , Tab.onClick (SelectLayer index layer)
                        ]
                        [ Tab.child (Kit.text label) ]
                    )
            )
            (layersFor ex)
        )


{-| The code block for the selected surface. The Elm surfaces highlight as Elm;
the raw `<m3e-*>` HTML surface highlights as plain markup. `Record` / `Build` are
optional — if the selected surface isn't available for this example (its field is
`Nothing`), fall back to the always-present `M3e` (top) code.
-}
codeFor : Layer -> UsageExample -> Element { s | html : Supported } msg
codeFor layer ex =
    case layer of
        Top ->
            Doc.code_ Doc.Elm ex.top

        Record ->
            case ex.record of
                Just code ->
                    Doc.code_ Doc.Elm code

                Nothing ->
                    Doc.code_ Doc.Elm ex.top

        Build ->
            case ex.build of
                Just code ->
                    Doc.code_ Doc.Elm code

                Nothing ->
                    Doc.code_ Doc.Elm ex.top

        Middle ->
            Doc.code_ Doc.Elm ex.mid

        Bottom ->
            Doc.code_ Doc.Elm ex.bottom

        Raw ->
            Doc.code_ Doc.Xml ex.html


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


{-| One API member: the syntax-highlighted signature (`type Name` for aliases /
unions, `name : signature` for values) and its Markdown-rendered doc. The kind
eyebrow is gone — the enclosing group heading now conveys what each row is.
-}
memberRow : Member -> Element { s | listItem : Supported } msg
memberRow m =
    let
        sig : String
        sig =
            if m.kind == "type" then
                "type " ++ m.name

            else if m.signature == "" then
                m.name

            else
                m.name ++ " : " ++ m.signature
    in
    ListItem.view []
        (ListItem.child (Doc.elmSignature sig)
            :: (if m.doc == "" then
                    []

                else
                    [ ListItem.supportingText (Doc.markdown m.doc) ]
               )
        )
