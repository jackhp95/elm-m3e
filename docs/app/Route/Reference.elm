module Route.Reference exposing (ActionData, Data, Model, Msg, route)

{-| Complete API reference for every Ui.\* module, extracted from the library
source at build time (scripts/extract-reference.mjs -> data/reference.json).
Accurate by construction — module overviews plus every exposed member's
signature and doc comment.
-}

import BackendTask exposing (BackendTask)
import BackendTask.File
import Doc
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html
import Json.Decode as Decode
import Kit
import Layout
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Divider as Divider
import M3e.Element as Element exposing (Element)
import M3e.Record.Heading as Heading
import M3e.Value as Value exposing (Supported)
import Native
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import UrlPath
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


type alias Member =
    { name : String, kind : String, signature : String, doc : String }


type alias Component =
    { name : String, slug : String, overview : String, members : List Member }


type alias Data =
    List Component


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


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single { head = head, data = data }
        |> RouteBuilder.buildNoState { view = view }


data : BackendTask FatalError Data
data =
    BackendTask.File.jsonFile (Decode.list componentDecoder) "data/reference.json"
        |> BackendTask.allowFatal


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-m3e"
        , image =
            { url = [ "favicon.ico" ] |> UrlPath.join |> Pages.Url.fromPath
            , alt = "elm-m3e"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Complete API reference for every elm-m3e Ui.* component module."
        , locale = Nothing
        , title = "elm-m3e · component reference"
        }
        |> Seo.website


pageHeading : Element { s | heading : Supported } msg
pageHeading =
    Heading.view { content = Kit.text "Component reference" }
        [ Heading.variant Value.display, Heading.size Value.small, Heading.level 1 ]
        []


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] items


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view app _ =
    { title = "elm-m3e · component reference"
    , body =
        [ Element.toNode
            (pane
                [ pageHeading
                , Layout.div "mt-2 max-w-2xl"
                    [ Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "Every "
                        , Native.node (Html.node "code") [] [ Kit.text "Ui.*" ]
                        , Kit.text " module, its overview, and every exposed value — extracted from the library source at build time."
                        ]
                    ]
                , indexGrid app.data
                , Layout.div "mt-12 space-y-12"
                    (List.map componentBlock app.data)
                ]
            )
        ]
    }


indexGrid : List Component -> Element { s | html : Supported } msg
indexGrid components =
    Layout.div "mt-8 flex flex-wrap gap-2"
        (List.map
            (\c ->
                Doc.anchorPill { href = "#" ++ c.slug, label = c.name }
            )
            components
        )


componentBlock : Component -> Element { s | html : Supported } msg
componentBlock c =
    Native.section
        [ Native.attribute "id" c.slug, Layout.class "scroll-mt-6 space-y-4" ]
        [ Divider.view [] []
        , Native.node (Html.node "h2")
            []
            [ Kit.headline Value.small
                []
                [ Native.node (Html.node "code") [ Kit.tint [ Kit.primary ] ] [ Kit.text ("Ui." ++ c.name) ] ]
            ]
        , prose "max-w-2xl" Value.large c.overview
        , Layout.div "space-y-3"
            (List.map memberRow c.members)
        ]


memberRow : Member -> Element { s | card : Supported } msg
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
    Card.view
        [ Card.variant Value.outlined ]
        [ Card.content
            (Native.node (Html.node "div")
                []
                [ Doc.preBlock sig
                , if m.doc == "" then
                    Kit.text ""

                  else
                    prose "mt-2" Value.medium m.doc
                ]
            )
        ]


{-| Render \\n\\n-separated text as body paragraphs at the given type-scale size.
`layoutCls` carries only layout (e.g. `max-w-2xl`); typography/color come from the
`Kit` primitives.
-}
prose : String -> Kit.Size -> String -> Element { s | html : Supported } msg
prose layoutCls size s =
    Layout.div layoutCls
        (s
            |> String.split "\n\n"
            |> List.filter (\para -> String.trim para /= "")
            |> List.map
                (\para ->
                    Native.p [ Layout.class "mt-2 first:mt-0 whitespace-pre-line" ]
                        [ Kit.body size [ Kit.onSurfaceVariant ] [ Kit.text para ] ]
                )
        )
