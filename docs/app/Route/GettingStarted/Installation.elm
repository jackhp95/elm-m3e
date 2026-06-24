module Route.GettingStarted.Installation exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, code, div, h1, h2, p, pre, section, text)
import Html.Attributes exposing (class)
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


type alias Data =
    {}


type alias ActionData =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single { head = head, data = BackendTask.succeed {} }
        |> RouteBuilder.buildNoState { view = view }


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-m3e"
        , image = { url = [ "favicon.ico" ] |> UrlPath.join |> Pages.Url.fromPath, alt = "elm-m3e", dimensions = Nothing, mimeType = Nothing }
        , description = "Install elm-m3e and register the @m3e/web custom elements."
        , locale = Nothing
        , title = "Installation · elm-m3e"
        }
        |> Seo.website


code_ : String -> Html msg
code_ s =
    pre [ class "overflow-x-auto rounded-md-corner-medium bg-surface-container p-4 text-body-small leading-relaxed text-on-surface" ]
        [ code [] [ text (String.trim s) ] ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Installation · elm-m3e"
    , body =
        [ div [ class "mx-auto max-w-3xl space-y-8" ]
            [ section [ class "space-y-3" ]
                [ h1 [ class "text-display-small font-semibold text-on-surface" ] [ text "Installation" ]
                , p [ class "text-body-large text-on-surface-variant" ]
                    [ text "elm-m3e is not yet on the Elm package registry. Today you vendor the Ui.* source into your project; a registry release is planned." ]
                ]
            , section [ class "space-y-3" ]
                [ h2 [ class "text-headline-small font-semibold text-on-surface" ] [ text "1. Add the Elm source" ]
                , p [ class "text-body-medium text-on-surface-variant" ]
                    [ text "Copy the Ui.* (and supporting M3e.*) modules into your project and add them to elm.json source-directories:" ]
                , code_ """
{
  "source-directories": [ "src", "vendor/elm-m3e" ]
}
"""
                ]
            , section [ class "space-y-3" ]
                [ h2 [ class "text-headline-small font-semibold text-on-surface" ] [ text "2. Register the web components" ]
                , p [ class "text-body-medium text-on-surface-variant" ]
                    [ text "Install @m3e/web and register the custom elements once, before your Elm app boots:" ]
                , code_ """
npm i @m3e/web

// m3e-entry.js
import "@m3e/web/all";
"""
                ]
            , section [ class "space-y-3" ]
                [ h2 [ class "text-headline-small font-semibold text-on-surface" ] [ text "3. Import the token + utility bridge" ]
                , p [ class "text-body-medium text-on-surface-variant" ]
                    [ text "The tailwind-m3e-web bridge maps the M3 tokens to Tailwind v4 utilities (bg-surface, text-body-large, rounded-md-corner-large, …):" ]
                , code_ """
/* style.css */
@import "tailwindcss";
@import "tailwind-m3e-web/src/index.css";
@import "tailwind-m3e-web/generated/utilities.css";
"""
                ]
            , section [ class "space-y-3" ]
                [ h2 [ class "text-headline-small font-semibold text-on-surface" ] [ text "4. Wrap your app in a theme" ]
                , p [ class "text-body-medium text-on-surface-variant" ]
                    [ text "A single Ui.Theme owns the dynamic color, scheme, contrast, density, and motion for its subtree — usually the whole app:" ]
                , code_ """
import Ui.Theme as Theme

Theme.new
    |> Theme.withSeedColor "#6750A4"
    |> Theme.withScheme Theme.Auto
    |> Theme.view [ yourApp ]
"""
                ]
            ]
        ]
    }
