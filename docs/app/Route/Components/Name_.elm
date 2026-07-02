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
import EscapeHatch
import FatalError exposing (FatalError)
import Head
import Html exposing (code, p, text)
import Html.Attributes as Attr
import Json.Decode as Decode
import Kit
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.Heading as Heading
import M3e.List as List_
import M3e.ListItem as ListItem
import M3e.Value as Value exposing (Supported)
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    { name : String }


type alias Member =
    { name : String, kind : String, signature : String, doc : String }


type alias Component =
    { name : String, slug : String, overview : String, members : List Member }


{-| A verified Usage example: its live-preview HTML and the derived Elm code.
`section` groups examples under a sub-heading ("" = ungrouped).
-}
type alias UsageExample =
    { title : String, section : String, html : String, top : String }


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
    Decode.map4 UsageExample
        (Decode.field "title" Decode.string)
        (Decode.oneOf [ Decode.field "section" Decode.string, Decode.succeed "" ])
        (Decode.field "html" Decode.string)
        (Decode.field "top" Decode.string)


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


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.preRender { head = head, pages = pages, data = data }
        |> RouteBuilder.buildNoState { view = view }


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


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view app _ =
    let
        component =
            app.data.component
    in
    { title = component.name ++ " · elm-m3e"
    , body =
        List.map Element.toNode
            [ pane
                ([ Heading.view { content = Kit.text component.name }
                    [ Heading.variant Value.display, Heading.size Value.small, Heading.level "1" ]
                    []
                 , EscapeHatch.fromHtml (p [ Attr.class "max-w-2xl text-body-lg text-on-surface-variant" ] [ text component.overview ])
                 ]
                    ++ usageBlocks app.data.usage
                    ++ [ Heading.view { content = Kit.text "API" }
                            [ Heading.variant Value.headline, Heading.size Value.small, Heading.level "2" ]
                            []
                       , Card.view [ Card.variant Value.outlined ]
                            [ Card.content (List_.view [] (List_.children (List.map memberRow component.members))) ]
                       ]
                )
            ]
    }


{-| Render the Usage section: a "Usage" heading, then per-section sub-headings,
each followed by its examples (live preview + code). Empty ⇒ nothing.
-}
usageBlocks : List UsageExample -> List (Element { s | html : Supported, heading : Supported, card : Supported } msg)
usageBlocks examples =
    case examples of
        [] ->
            []

        _ ->
            Heading.view { content = Kit.text "Usage" }
                [ Heading.variant Value.headline, Heading.size Value.small, Heading.level "2" ]
                []
                :: List.concatMap sectionBlock (groupBySection examples)


{-| One section: an optional sub-heading (skipped for the ungrouped "" section)
followed by each example's live preview paired with its Elm code.
-}
sectionBlock : ( String, List UsageExample ) -> List (Element { s | html : Supported, heading : Supported, card : Supported } msg)
sectionBlock ( section, examples ) =
    let
        heading : List (Element { s | html : Supported, heading : Supported, card : Supported } msg)
        heading =
            if section == "" then
                []

            else
                [ Heading.view { content = Kit.text section }
                    [ Heading.variant Value.title, Heading.size Value.large, Heading.level "3" ]
                    []
                ]
    in
    heading ++ List.concatMap exampleBlock examples


exampleBlock : UsageExample -> List (Element { s | html : Supported, heading : Supported, card : Supported } msg)
exampleBlock ex =
    [ EscapeHatch.fromHtml (p [ Attr.class "text-body-md text-on-surface-variant" ] [ text ex.title ])
    , Doc.showcase (Doc.rawPreview ex.html)
    , Doc.code_ Doc.Elm ex.top
    ]


{-| Group examples by `.section`, preserving first-seen order of both sections
and examples within each section.
-}
groupBySection : List UsageExample -> List ( String, List UsageExample )
groupBySection examples =
    let
        sections : List String
        sections =
            List.foldl
                (\ex acc ->
                    if List.member ex.section acc then
                        acc

                    else
                        acc ++ [ ex.section ]
                )
                []
                examples
    in
    List.map (\sec -> ( sec, List.filter (\ex -> ex.section == sec) examples )) sections


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


{-| One API member: kind overline, name + signature, and its doc.
-}
memberRow : Member -> Element { s | listItem : Supported } msg
memberRow m =
    ListItem.view []
        (ListItem.overline (Kit.text m.kind)
            :: ListItem.child
                (EscapeHatch.fromHtml
                    (code [ Attr.class "text-body-md" ]
                        [ text
                            (if m.signature == "" then
                                m.name

                             else
                                m.name ++ " : " ++ m.signature
                            )
                        ]
                    )
                )
            :: (if m.doc == "" then
                    []

                else
                    [ ListItem.supportingText (Kit.text m.doc) ]
               )
        )
