module Route.GettingStarted.Installation exposing (ActionData, Data, Model, Msg, route)

import BackendTask
import Doc exposing (Lang(..), code_)
import Head
import Head.Seo as Seo
import Kit
import Layout
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.Record.Heading as Heading
import M3e.Value as Value exposing (Supported)
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


pageHeading : Element { s | heading : Supported } msg
pageHeading =
    Heading.view { content = Kit.text "Installation" }
        [ Heading.variant Value.display, Heading.size Value.small, Heading.level "1" ]
        []


stepHeading : String -> Element { s | heading : Supported } msg
stepHeading label =
    Heading.view { content = Kit.text label }
        [ Heading.variant Value.headline, Heading.size Value.small, Heading.level "2" ]
        []


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Installation · elm-m3e"
    , body =
        [ Element.toNode
            (pane
                [ Layout.section "space-y-3"
                    [ pageHeading
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "elm-m3e is not yet on the Elm package registry. Today you vendor the M3e.* source into your project; a registry release is planned." ]
                    ]
                , Layout.section "space-y-3"
                    [ stepHeading "1. Add the Elm source"
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "Copy the M3e.* (and supporting Cem.M3e.*) modules into your project and add them to elm.json source-directories:" ]
                    , code_ Json """
{
  "source-directories": [ "src", "vendor/elm-m3e" ]
}
"""
                    ]
                , Layout.section "space-y-3"
                    [ stepHeading "2. Register the web components"
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "Install @m3e/web and register the custom elements once, before your Elm app boots:" ]
                    , code_ Shell """
npm i @m3e/web

// m3e-entry.js
import "@m3e/web/all";
"""
                    ]
                , Layout.section "space-y-3"
                    [ stepHeading "3. Import the token + utility bridge"
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "The tailwind-m3e-web bridge maps the M3 tokens to Tailwind v4 utilities (bg-surface, text-body-lg, rounded-md-corner-large, …):" ]
                    , code_ NoLang """
/* style.css */
@import "tailwindcss";
@import "tailwind-m3e-web/src/index.css";
@import "tailwind-m3e-web/generated/utilities.css";
"""
                    ]
                , Layout.section "space-y-3"
                    [ stepHeading "4. Wrap your app in a theme"
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "A single M3e.Theme owns the dynamic color, scheme, contrast, density, and motion for its subtree — usually the whole app:" ]
                    , code_ Elm """
import M3e.Theme as Theme

Theme.new
    |> Theme.withSeedColor "#6750A4"
    |> Theme.withScheme Theme.Auto
    |> Theme.view [ yourApp ]
"""
                    ]
                ]
            )
        ]
    }
