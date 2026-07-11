module Route.GettingStarted.Installation exposing (ActionData, Data, Model, Msg, route)

import BackendTask
import Doc exposing (Lang(..), code_, message)
import Head
import Head.Seo as Seo
import Kit
import Layout
import M3e.Element as Element exposing (Element)
import M3e.Record.Heading as Heading
import M3e.Token as Value exposing (Supported)
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
        [ Heading.variant Value.display, Heading.size Value.small, Heading.level 1 ]
        []


stepHeading : String -> Element { s | heading : Supported } msg
stepHeading label =
    Heading.view { content = Kit.text label }
        [ Heading.variant Value.headline, Heading.size Value.small, Heading.level 2 ]
        []


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Installation · elm-m3e"
    , body =
        [ Element.toNode
            (Doc.pane
                [ Layout.section "space-y-3"
                    [ pageHeading
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "elm-m3e is not yet on the Elm package registry. Today you vendor the M3e.* source into your project; a registry release is planned. Follow the four steps below and you will have a themed button rendering in the browser." ]
                    , message "Prerequisites: Elm 0.19.1, Node 18+, and a bundler that can serve ES modules (Vite, esbuild, Parcel, or Webpack). The steps below assume Vite, but any bundler that runs npm packages and lets you inject a <script> tag will work."
                    ]
                , Layout.section "space-y-3"
                    [ stepHeading "1. Vendor the Elm source"
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "Clone this repository and copy its src/ (the M3e.* and supporting M3e.Html.* modules) into a vendor folder in your project:" ]
                    , code_ Shell """
git clone https://github.com/jackhp95/elm-m3e.git
cp -R elm-m3e/src your-project/vendor/elm-m3e
"""
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "Then add that folder to source-directories in your elm.json:" ]
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
                        [ Kit.text "The Elm modules emit <m3e-*> custom elements; they only render once the @m3e/web element definitions are registered. Install the package and import it once, before your Elm app boots:" ]
                    , code_ Shell """
npm i @m3e/web
"""
                    , code_ NoLang """
// m3e-entry.js — import once, before Elm.Main.init runs
import "@m3e/web/all";
"""
                    ]
                , Layout.section "space-y-3"
                    [ stepHeading "3. Add the token + utility CSS bridge"
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "tailwind-m3e-web maps the M3 design tokens to Tailwind v4 utilities (bg-surface, text-body-lg, rounded-md-corner-large, …). It is NOT published to npm — it is a private repository, vendored here as CSS only. There is no @import from a package name; you must vendor the CSS files into your project first." ]
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "If you have access to the private repo, clone it and copy its CSS into your project; otherwise copy the vendored copy from this repo (docs/vendor/tailwind-m3e-web):" ]
                    , code_ Shell """
# Option A — from the private source repo (requires access)
git clone https://github.com/jackhp95/tailwind-m3e-web.git
cp -R tailwind-m3e-web/src        your-project/vendor/tailwind-m3e-web/src
cp -R tailwind-m3e-web/generated  your-project/vendor/tailwind-m3e-web/generated

# Option B — from the copy vendored inside this repo
cp -R elm-m3e/docs/vendor/tailwind-m3e-web your-project/vendor/tailwind-m3e-web
"""
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "Then reference the vendored files by relative path from your stylesheet:" ]
                    , code_ NoLang """
/* style.css — paths are relative to your vendored copy */
@import "tailwindcss";
@import "./vendor/tailwind-m3e-web/src/index.css";
@import "./vendor/tailwind-m3e-web/generated/utilities.css";
"""
                    ]
                , Layout.section "space-y-3"
                    [ stepHeading "4. Wrap your app in a theme and render"
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "M3e.Theme is an attribute-style element (not a builder): M3e.Theme.view takes a list of attributes — color, scheme, contrast, density, variant, motion — and a list of child elements. It owns the dynamic color for its subtree, usually the whole app. Here is a complete Main.elm that renders a themed button:" ]
                    , code_ Elm """
module Main exposing (main)

import Browser
import M3e.Button as Button
import M3e.Element as Element
import M3e.Theme as Theme
import M3e.Token as Value
import Kit


main : Program () () ()
main =
    Browser.sandbox { init = (), update = \\_ model -> model, view = view }


view : () -> Html.Html ()
view _ =
    Element.toNode
        (Theme.view
            [ Theme.color "#6750A4"
            , Theme.scheme Value.auto
            ]
            [ Button.view
                [ Button.variant Value.filled ]
                [ Kit.text "It works" ]
            ]
        )
"""
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "Element.toNode turns an M3e Element into elm/html, so Browser.sandbox can render it (add `import Html` alongside the imports above). Finally, an index.html loads the CSS, registers the components, and boots Elm:" ]
                    , code_ Xml """
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="/style.css" />
  </head>
  <body>
    <div id="app"></div>
    <!-- register the <m3e-*> elements first -->
    <script type="module" src="/m3e-entry.js"></script>
    <!-- then boot Elm (compiled from Main.elm) -->
    <script type="module">
      import { Elm } from "/main.js";
      Elm.Main.init({ node: document.getElementById("app") });
    </script>
  </body>
</html>
"""
                    ]
                ]
            )
        ]
    }
