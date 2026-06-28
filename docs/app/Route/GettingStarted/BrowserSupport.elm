module Route.GettingStarted.BrowserSupport exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (li, p, text, ul)
import Html.Attributes exposing (class)
import Layout
import M3e.Card as Card
import M3e.Divider as Divider
import M3e.Element as Element
import M3e.Heading as Heading
import M3e.Node as Node exposing (Node)
import M3e.Value as Value
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


supportRow : String -> String -> Node msg
supportRow browser note =
    Layout.li "flex items-baseline justify-between gap-4 border-b border-outline-variant py-2.5 last:border-0"
        [ Layout.span "text-title-sm text-on-surface"
            [ Node.text browser ]
        , Layout.span "text-body-md text-on-surface-variant"
            [ Node.text note ]
        ]


pageHeading : Node msg
pageHeading =
    Heading.view { label = "Browser Support", variant = Value.display }
        [ Heading.size Value.small, Heading.level 1 ]
        |> Element.toNode


sectionHeading : String -> Node msg
sectionHeading label =
    Heading.view { label = label, variant = Value.headline }
        [ Heading.size Value.small, Heading.level 2 ]
        |> Element.toNode


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Browser Support · elm-m3e"
    , body =
        [ Layout.div "mx-auto max-w-3xl space-y-8"
            [ Layout.section "space-y-3"
                [ pageHeading
                , Node.raw
                    (p [ class "text-body-lg text-on-surface-variant" ]
                        [ text "elm-m3e renders @m3e/web custom elements, so it runs anywhere standard Web Components and ES modules run — the modern-browser baseline." ]
                    )
                ]
            , Divider.view [] |> Element.toNode
            , Layout.section "space-y-3"
                [ sectionHeading "Supported browsers"
                , Card.view
                    [ Card.variant Value.outlined
                    , Card.body
                        [ Element.fromNode
                            (Layout.ul "px-2"
                                [ supportRow "Chrome / Edge" "Latest 2 versions"
                                , supportRow "Firefox" "Latest 2 versions"
                                , supportRow "Safari" "Latest 2 versions"
                                , supportRow "Mobile Safari / Chrome Android" "Latest 2 versions"
                                ]
                            )
                        ]
                    ]
                    |> Element.toNode
                ]
            , Divider.view [] |> Element.toNode
            , Layout.section "space-y-3"
                [ sectionHeading "Platform features used"
                , Node.raw
                    (ul [ class "list-disc space-y-1.5 pl-5 text-body-md text-on-surface-variant" ]
                        [ li [] [ text "Custom Elements v1 and Shadow DOM for the @m3e/web components." ]
                        , li [] [ text "ES modules for component registration (no-bundler import-map usage is also supported upstream)." ]
                        , li [] [ text "CSS custom properties and the light-dark() function for the M3 token cascade and dark mode." ]
                        , li [] [ text "Variable fonts for the self-hosted Material Symbols icon axes." ]
                        ]
                    )
                ]
            ]
        ]
    }
