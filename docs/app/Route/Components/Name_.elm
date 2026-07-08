module Route.Components.Name_ exposing (ActionData, Data, Model, Msg, route)

{-| The per-component **API reference** page (`/components/:slug`), re-authored on the
new Vocab API (opus). Data-driven: one pre-rendered page per component in
`data/reference.json`, each showing the component name, overview, and its API members
(types + functions with signatures + docs) in the content-pane + card pattern using
real `M3e.*` components. (The original also embedded per-component _live demos_, which
imported all 55 component modules; those are deferred — this restores the reference.)
-}

import BackendTask exposing (BackendTask)
import Dict
import Doc
import Doc.Data exposing (Component, allComponents, allUsage)
import Doc.Usage as Usage exposing (UsageExample)
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Head
import Kit
import Layout
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.List as List_
import M3e.ListItem as ListItem
import M3e.Record.Heading as Heading
import M3e.SuggestionChip as SuggestionChip
import M3e.Value as Value exposing (Supported)
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import UrlPath exposing (UrlPath)
import View exposing (View)


type alias Model =
    Usage.Model


type alias Msg =
    Usage.Msg


type alias RouteParams =
    { name : String }


type alias Data =
    { component : Component, usage : List UsageExample }


type alias ActionData =
    {}


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
    ( Usage.init, Effect.none )


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ msg model =
    ( Usage.update msg model, Effect.none )


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
                            :: Usage.usageBlocks 0 model app.data.usage
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
        [ SuggestionChip.view [] [ Kit.text cat ] ]


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
apiSection : List Doc.Data.Member -> Element { s | html : Supported, heading : Supported, card : Supported, listItem : Supported } msg
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
apiGroup : List Doc.Data.Member -> ( String, List String ) -> Maybe (Element { s | html : Supported, card : Supported, listItem : Supported } msg)
apiGroup members ( label, roles ) =
    case List.filter (\m -> List.member m.role roles) members of
        [] ->
            Nothing

        group ->
            Just
                (Layout.div "space-y-3"
                    [ Kit.overline [ Kit.onSurfaceVariant ] [ Kit.text label ]
                    , Card.view [ Card.variant Value.outlined ]
                        [ Card.content (List_.view [] (List.map memberRow group)) ]
                    ]
                )


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] items


{-| One API member: the syntax-highlighted signature (`type Name` for aliases /
unions, `name : signature` for values) and its Markdown-rendered doc. The kind
eyebrow is gone — the enclosing group heading now conveys what each row is.
-}
memberRow : Doc.Data.Member -> Element { s | listItem : Supported } msg
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
        (Doc.elmSignature sig
            :: (if m.doc == "" then
                    []

                else
                    [ ListItem.supportingText (Doc.markdown m.doc) ]
               )
        )
