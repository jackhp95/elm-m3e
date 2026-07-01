module Route.GettingStarted.Installation exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (code, div, p, pre, text)
import Html.Attributes exposing (class)
import Layout
import EscapeHatch
import Kit
import M3e.Divider as Divider
import M3e.Element as Element exposing (Element)
import M3e.Heading as Heading
import M3e.Node as Node exposing (Node)
import M3e.Value as Value exposing (Supported)
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import SyntaxHighlight
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


type Lang
    = Elm
    | Json
    | Shell
    | NoLang


code_ : Lang -> String -> Element { s | html : Supported } msg
code_ lang s =
    let
        trimmed : String
        trimmed =
            String.trim s

        wrapperClass : String
        wrapperClass =
            "overflow-x-auto rounded-md-corner-medium bg-surface-container p-4 text-body-sm leading-relaxed text-on-surface"

        parsed : Result () SyntaxHighlight.HCode
        parsed =
            -- elm-syntax-highlight doesn't ship a shell parser, so fall back to noLang
            -- (still wraps everything in .elmsh spans so the surface styling stays consistent).
            case lang of
                Elm ->
                    SyntaxHighlight.elm trimmed |> Result.mapError (always ())

                Json ->
                    SyntaxHighlight.json trimmed |> Result.mapError (always ())

                Shell ->
                    SyntaxHighlight.noLang trimmed |> Result.mapError (always ())

                NoLang ->
                    SyntaxHighlight.noLang trimmed |> Result.mapError (always ())
    in
    case parsed of
        Ok highlighted ->
            -- SyntaxHighlight.toBlockHtml emits <pre class="elmsh">, so the
            -- outer wrapper is a <div> to keep the markup valid.
            EscapeHatch.fromHtml
                (div [ class wrapperClass ]
                    [ SyntaxHighlight.toBlockHtml Nothing highlighted ]
                )

        Err _ ->
            EscapeHatch.fromHtml
                (pre [ class wrapperClass ]
                    [ code [] [ text trimmed ] ]
                )


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
       


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Installation · elm-m3e"
    , body =
        List.map Element.toNode
            [ Layout.div "mx-auto max-w-3xl space-y-8"
            [ Layout.section "space-y-3"
                [ pageHeading
                , EscapeHatch.fromHtml
                    (p [ class "text-body-lg text-on-surface-variant" ]
                        [ text "elm-m3e is not yet on the Elm package registry. Today you vendor the M3e.* source into your project; a registry release is planned." ]
                    )
                ]
            , Divider.view [] []
            , Layout.section "space-y-3"
                [ stepHeading "1. Add the Elm source"
                , EscapeHatch.fromHtml
                    (p [ class "text-body-md text-on-surface-variant" ]
                        [ text "Copy the M3e.* (and supporting Cem.M3e.*) modules into your project and add them to elm.json source-directories:" ]
                    )
                , code_ Json """
{
  "source-directories": [ "src", "vendor/elm-m3e" ]
}
"""
                ]
            , Divider.view [] []
            , Layout.section "space-y-3"
                [ stepHeading "2. Register the web components"
                , EscapeHatch.fromHtml
                    (p [ class "text-body-md text-on-surface-variant" ]
                        [ text "Install @m3e/web and register the custom elements once, before your Elm app boots:" ]
                    )
                , code_ Shell """
npm i @m3e/web

// m3e-entry.js
import "@m3e/web/all";
"""
                ]
            , Divider.view [] []
            , Layout.section "space-y-3"
                [ stepHeading "3. Import the token + utility bridge"
                , EscapeHatch.fromHtml
                    (p [ class "text-body-md text-on-surface-variant" ]
                        [ text "The tailwind-m3e-web bridge maps the M3 tokens to Tailwind v4 utilities (bg-surface, text-body-lg, rounded-md-corner-large, …):" ]
                    )
                , code_ NoLang """
/* style.css */
@import "tailwindcss";
@import "tailwind-m3e-web/src/index.css";
@import "tailwind-m3e-web/generated/utilities.css";
"""
                ]
            , Divider.view [] []
            , Layout.section "space-y-3"
                [ stepHeading "4. Wrap your app in a theme"
                , EscapeHatch.fromHtml
                    (p [ class "text-body-md text-on-surface-variant" ]
                        [ text "A single M3e.Theme owns the dynamic color, scheme, contrast, density, and motion for its subtree — usually the whole app:" ]
                    )
                , code_ Elm """
import M3e.Theme as Theme

Theme.new
    |> Theme.withSeedColor "#6750A4"
    |> Theme.withScheme Theme.Auto
    |> Theme.view [ yourApp ]
"""
                ]
            ]
        ]
    }
