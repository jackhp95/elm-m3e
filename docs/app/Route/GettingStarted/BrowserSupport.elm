module Route.GettingStarted.BrowserSupport exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, div, h1, h2, li, p, section, text, ul)
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
        , description = "Browser support for @m3e/web and elm-m3e."
        , locale = Nothing
        , title = "Browser Support · elm-m3e"
        }
        |> Seo.website


supportRow : String -> String -> Html msg
supportRow browser note =
    li [ class "flex items-baseline justify-between gap-4 border-b border-outline-variant py-2.5 last:border-0" ]
        [ Html.span [ class "text-title-small text-on-surface" ] [ text browser ]
        , Html.span [ class "text-body-medium text-on-surface-variant" ] [ text note ]
        ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Browser Support · elm-m3e"
    , body =
        [ div [ class "mx-auto max-w-3xl space-y-8" ]
            [ section [ class "space-y-3" ]
                [ h1 [ class "text-display-small font-semibold text-on-surface" ] [ text "Browser Support" ]
                , p [ class "text-body-large text-on-surface-variant" ]
                    [ text "elm-m3e renders @m3e/web custom elements, so it runs anywhere standard Web Components and ES modules run — the modern-browser baseline." ]
                ]
            , section [ class "space-y-2" ]
                [ h2 [ class "text-headline-small font-semibold text-on-surface" ] [ text "Supported browsers" ]
                , ul [ class "rounded-md-corner-large border border-outline-variant bg-surface-container-low px-5 py-2" ]
                    [ supportRow "Chrome / Edge" "Latest 2 versions"
                    , supportRow "Firefox" "Latest 2 versions"
                    , supportRow "Safari" "Latest 2 versions"
                    , supportRow "Mobile Safari / Chrome Android" "Latest 2 versions"
                    ]
                ]
            , section [ class "space-y-3" ]
                [ h2 [ class "text-headline-small font-semibold text-on-surface" ] [ text "Platform features used" ]
                , ul [ class "list-disc space-y-1.5 pl-5 text-body-medium text-on-surface-variant" ]
                    [ li [] [ text "Custom Elements v1 and Shadow DOM for the @m3e/web components." ]
                    , li [] [ text "ES modules for component registration (no-bundler import-map usage is also supported upstream)." ]
                    , li [] [ text "CSS custom properties and the light-dark() function for the M3 token cascade and dark mode." ]
                    , li [] [ text "Variable fonts for the self-hosted Material Symbols icon axes." ]
                    ]
                ]
            ]
        ]
    }
