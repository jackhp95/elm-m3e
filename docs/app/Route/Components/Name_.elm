module Route.Components.Name_ exposing (ActionData, Data, Model, Msg, route)

{-| Dynamic per-component documentation page, mirroring matraic's component
pages. One route per slug in `data/reference.json`: overview + a reserved live
demo region + the extracted API table. Rich per-component demos come in a later
phase (a generic default demo placeholder is shown for now).
-}

import BackendTask exposing (BackendTask)
import BackendTask.File
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, a, code, div, h1, h2, p, section, span, text)
import Html.Attributes exposing (attribute, class, href)
import Json.Decode as Decode
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
    { name : String }


type alias Member =
    { name : String, kind : String, signature : String, doc : String }


type alias Component =
    { name : String, slug : String, overview : String, members : List Member }


type alias Data =
    Component


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


allComponents : BackendTask FatalError (List Component)
allComponents =
    BackendTask.File.jsonFile (Decode.list componentDecoder) "data/reference.json"
        |> BackendTask.allowFatal


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.preRender
        { head = head
        , pages = pages
        , data = data
        }
        |> RouteBuilder.buildNoState { view = view }


pages : BackendTask FatalError (List RouteParams)
pages =
    allComponents
        |> BackendTask.map (List.map (\c -> { name = c.slug }))


data : RouteParams -> BackendTask FatalError Data
data routeParams =
    allComponents
        |> BackendTask.andThen
            (\components ->
                case List.filter (\c -> c.slug == routeParams.name) components of
                    found :: _ ->
                        BackendTask.succeed found

                    [] ->
                        BackendTask.fail (FatalError.fromString ("No component for slug: " ++ routeParams.name))
            )


head : App Data ActionData RouteParams -> List Head.Tag
head app =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-m3e"
        , image =
            { url = [ "favicon.ico" ] |> UrlPath.join |> Pages.Url.fromPath
            , alt = "elm-m3e"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Ui." ++ app.data.name ++ " — Material 3 Expressive component for Elm."
        , locale = Nothing
        , title = "Ui." ++ app.data.name ++ " · elm-m3e"
        }
        |> Seo.website


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view app _ =
    let
        c =
            app.data
    in
    { title = "Ui." ++ c.name ++ " · elm-m3e"
    , body =
        [ div [ class "mx-auto max-w-4xl space-y-10" ]
            [ section [ class "space-y-3" ]
                [ p [ class "text-label-large uppercase tracking-wide text-primary" ]
                    [ a [ href "/reference", class "no-underline hover:underline" ] [ text "Components" ] ]
                , h1 [ class "text-display-small font-semibold text-on-surface" ]
                    [ text ("Ui." ++ c.name) ]
                , prose "max-w-2xl text-body-large text-on-surface-variant" c.overview
                , div [ class "flex flex-wrap items-center gap-3 pt-1" ]
                    [ code [ class "rounded bg-surface-container px-2 py-1 text-body-medium" ]
                        [ text ("import Ui." ++ c.name ++ " as " ++ c.name) ]
                    ]
                ]
            , demoRegion c
            , apiSection c
            ]
        ]
    }


demoRegion : Component -> Html msg
demoRegion c =
    section [ class "space-y-3" ]
        [ h2 [ class "text-headline-small font-semibold text-on-surface" ] [ text "Demo" ]
        , div
            [ class "grid min-h-40 place-items-center rounded-md-corner-large border border-dashed border-outline-variant bg-surface-container-lowest p-8 text-center" ]
            [ div [ class "space-y-2" ]
                [ span [ class "material-symbols-outlined text-4xl text-on-surface-variant", attribute "aria-hidden" "true" ]
                    [ text "widgets" ]
                , p [ class "text-body-medium text-on-surface-variant" ]
                    [ text ("A live " ++ c.name ++ " demo lands here in a later phase.") ]
                ]
            ]
        ]


apiSection : Component -> Html msg
apiSection c =
    section [ class "space-y-4" ]
        [ h2 [ class "text-headline-small font-semibold text-on-surface" ] [ text "API" ]
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
    div [ class "rounded-md-corner-medium border border-outline-variant bg-surface-container-lowest p-4" ]
        [ Html.pre [ class "overflow-x-auto text-body-small text-on-surface" ]
            [ code [] [ text sig ] ]
        , if m.doc == "" then
            text ""

          else
            prose "mt-2 text-body-small text-on-surface-variant" m.doc
        ]


{-| Render \\n\\n-separated text as paragraphs. -}
prose : String -> String -> Html msg
prose cls s =
    div [ class cls ]
        (s
            |> String.split "\n\n"
            |> List.filter (\para -> String.trim para /= "")
            |> List.map (\para -> p [ class "mt-2 first:mt-0 whitespace-pre-line" ] [ text para ])
        )
