module Route.GettingStarted.Installation exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, code, div, p, pre, section, text)
import Html.Attributes exposing (class)
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import SyntaxHighlight
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


code_ : Lang -> String -> Html msg
code_ lang s =
    let
        trimmed : String
        trimmed =
            String.trim s

        wrapperClass : String
        wrapperClass =
            "overflow-x-auto rounded-md-corner-medium bg-surface-container p-4 text-body-small leading-relaxed text-on-surface"

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
            div [ class wrapperClass ]
                [ SyntaxHighlight.toBlockHtml Nothing highlighted ]

        Err _ ->
            pre [ class wrapperClass ]
                [ code [] [ text trimmed ] ]


pageHeading : Html msg
pageHeading =
    Heading.new
        |> Heading.withLevel 1
        |> Heading.withVariant Heading.Display
        |> Heading.withSize Heading.Small
        |> Heading.withContent (text "Installation")
        |> Heading.view


stepHeading : String -> Html msg
stepHeading label =
    Heading.new
        |> Heading.withLevel 2
        |> Heading.withVariant Heading.Headline
        |> Heading.withSize Heading.Small
        |> Heading.withContent (text label)
        |> Heading.view


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Installation · elm-m3e"
    , body =
        [ div [ class "mx-auto max-w-3xl space-y-8" ]
            [ section [ class "space-y-3" ]
                [ pageHeading
                , p [ class "text-body-large text-on-surface-variant" ]
                    [ text "elm-m3e is not yet on the Elm package registry. Today you vendor the Ui.* source into your project; a registry release is planned." ]
                ]
            , Divider.new |> Divider.view
            , section [ class "space-y-3" ]
                [ stepHeading "1. Add the Elm source"
                , p [ class "text-body-medium text-on-surface-variant" ]
                    [ text "Copy the Ui.* (and supporting M3e.*) modules into your project and add them to elm.json source-directories:" ]
                , code_ Json """
{
  "source-directories": [ "src", "vendor/elm-m3e" ]
}
"""
                ]
            , Divider.new |> Divider.view
            , section [ class "space-y-3" ]
                [ stepHeading "2. Register the web components"
                , p [ class "text-body-medium text-on-surface-variant" ]
                    [ text "Install @m3e/web and register the custom elements once, before your Elm app boots:" ]
                , code_ Shell """
npm i @m3e/web

// m3e-entry.js
import "@m3e/web/all";
"""
                ]
            , Divider.new |> Divider.view
            , section [ class "space-y-3" ]
                [ stepHeading "3. Import the token + utility bridge"
                , p [ class "text-body-medium text-on-surface-variant" ]
                    [ text "The tailwind-m3e-web bridge maps the M3 tokens to Tailwind v4 utilities (bg-surface, text-body-large, rounded-md-corner-large, …):" ]
                , code_ NoLang """
/* style.css */
@import "tailwindcss";
@import "tailwind-m3e-web/src/index.css";
@import "tailwind-m3e-web/generated/utilities.css";
"""
                ]
            , Divider.new |> Divider.view
            , section [ class "space-y-3" ]
                [ stepHeading "4. Wrap your app in a theme"
                , p [ class "text-body-medium text-on-surface-variant" ]
                    [ text "A single Ui.Theme owns the dynamic color, scheme, contrast, density, and motion for its subtree — usually the whole app:" ]
                , code_ Elm """
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
