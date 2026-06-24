module Route.Reference exposing (ActionData, Data, Model, Msg, route)

{-| Complete API reference for every Ui.\* module, extracted from the library
source at build time (scripts/extract-reference.mjs -> data/reference.json).
Accurate by construction — module overviews plus every exposed member's
signature and doc comment.
-}

import BackendTask exposing (BackendTask)
import BackendTask.File
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, a, code, div, p, section, text)
import Html.Attributes exposing (class, href, id)
import Json.Decode as Decode
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import Ui.Card as Card
import Ui.Divider as Divider
import Ui.Heading as Heading
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


pageHeading : Html msg
pageHeading =
    Heading.new
        |> Heading.withLevel 1
        |> Heading.withVariant Heading.Display
        |> Heading.withSize Heading.Small
        |> Heading.withContent (text "Component reference")
        |> Heading.view


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view app _ =
    { title = "elm-m3e · component reference"
    , body =
        [ div [ class "mx-auto max-w-5xl" ]
            [ pageHeading
            , p [ class "mt-2 max-w-2xl text-body-large text-on-surface-variant" ]
                [ text "Every "
                , code [ class "rounded bg-surface-container px-1.5 py-0.5 text-body-medium" ] [ text "Ui.*" ]
                , text " module, its overview, and every exposed value — extracted from the library source at build time."
                ]
            , indexGrid app.data
            , div [ class "mt-12 space-y-12" ] (List.map componentBlock app.data)
            ]
        ]
    }


indexGrid : List Component -> Html msg
indexGrid components =
    div [ class "mt-8 flex flex-wrap gap-2" ]
        (List.map
            (\c ->
                a
                    [ href ("#" ++ c.slug)
                    , class "rounded-full border border-outline px-3 py-1 text-label-medium text-on-surface-variant hover:bg-surface-container hover:text-on-surface no-underline"
                    ]
                    [ text c.name ]
            )
            components
        )


componentBlock : Component -> Html msg
componentBlock c =
    section [ id c.slug, class "scroll-mt-6 space-y-4" ]
        [ Divider.new |> Divider.view
        , Heading.new
            |> Heading.withLevel 2
            |> Heading.withVariant Heading.Headline
            |> Heading.withSize Heading.Small
            |> Heading.withContent (code [ class "text-primary" ] [ text ("Ui." ++ c.name) ])
            |> Heading.view
        , prose "max-w-2xl text-body-medium text-on-surface-variant" c.overview
        , div [ class "space-y-3" ] (List.map memberRow c.members)
        ]


memberRow : Member -> Html msg
memberRow m =
    let
        sig =
            if m.kind == "type" then
                "type " ++ m.name

            else if m.signature == "" then
                m.name

            else
                m.name ++ " : " ++ m.signature
    in
    Card.new Card.Outlined
        |> Card.withBody
            (div []
                [ pre_ sig
                , if m.doc == "" then
                    text ""

                  else
                    prose "mt-2 text-body-small text-on-surface-variant" m.doc
                ]
            )
        |> Card.view


pre_ : String -> Html msg
pre_ s =
    Html.pre [ class "overflow-x-auto text-body-small text-on-surface" ]
        [ code [] [ text s ] ]


{-| Render \\n\\n-separated text as paragraphs.
-}
prose : String -> String -> Html msg
prose cls s =
    div [ class cls ]
        (s
            |> String.split "\n\n"
            |> List.filter (\para -> String.trim para /= "")
            |> List.map (\para -> p [ class "mt-2 first:mt-0 whitespace-pre-line" ] [ text para ])
        )
