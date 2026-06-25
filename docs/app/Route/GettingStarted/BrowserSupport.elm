module Route.GettingStarted.BrowserSupport exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, div, li, p, section, text, ul)
import Html.Attributes exposing (class)
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
        [ Html.span [ class "text-title-sm text-on-surface" ] [ text browser ]
        , Html.span [ class "text-body-md text-on-surface-variant" ] [ text note ]
        ]


pageHeading : Html msg
pageHeading =
    Heading.new
        |> Heading.withLevel 1
        |> Heading.withVariant Heading.Display
        |> Heading.withSize Heading.Small
        |> Heading.withContent (text "Browser Support")
        |> Heading.view


sectionHeading : String -> Html msg
sectionHeading label =
    Heading.new
        |> Heading.withLevel 2
        |> Heading.withVariant Heading.Headline
        |> Heading.withSize Heading.Small
        |> Heading.withContent (text label)
        |> Heading.view


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Browser Support · elm-m3e"
    , body =
        [ div [ class "mx-auto max-w-3xl space-y-8" ]
            [ section [ class "space-y-3" ]
                [ pageHeading
                , p [ class "text-body-lg text-on-surface-variant" ]
                    [ text "elm-m3e renders @m3e/web custom elements, so it runs anywhere standard Web Components and ES modules run — the modern-browser baseline." ]
                ]
            , Divider.new |> Divider.view
            , section [ class "space-y-3" ]
                [ sectionHeading "Supported browsers"
                , Card.new Card.Outlined
                    |> Card.withBody
                        (ul [ class "px-2" ]
                            [ supportRow "Chrome / Edge" "Latest 2 versions"
                            , supportRow "Firefox" "Latest 2 versions"
                            , supportRow "Safari" "Latest 2 versions"
                            , supportRow "Mobile Safari / Chrome Android" "Latest 2 versions"
                            ]
                        )
                    |> Card.view
                ]
            , Divider.new |> Divider.view
            , section [ class "space-y-3" ]
                [ sectionHeading "Platform features used"
                , ul [ class "list-disc space-y-1.5 pl-5 text-body-md text-on-surface-variant" ]
                    [ li [] [ text "Custom Elements v1 and Shadow DOM for the @m3e/web components." ]
                    , li [] [ text "ES modules for component registration (no-bundler import-map usage is also supported upstream)." ]
                    , li [] [ text "CSS custom properties and the light-dark() function for the M3 token cascade and dark mode." ]
                    , li [] [ text "Variable fonts for the self-hosted Material Symbols icon axes." ]
                    ]
                ]
            ]
        ]
    }
