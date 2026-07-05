module Route.GettingStarted.BrowserSupport exposing (ActionData, Data, Model, Msg, route)

import BackendTask
import Head
import Head.Seo as Seo
import Kit
import Layout
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Divider as Divider
import M3e.Element as Element exposing (Element)
import M3e.Record.Heading as Heading
import M3e.Value as Value exposing (Supported)
import Native
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


supportRow : String -> String -> Element { s | html : Supported } msg
supportRow browser note =
    Layout.div "flex items-baseline justify-between gap-4 py-2.5"
        [ Kit.title Value.small [ Kit.onSurface ] [ Kit.text browser ]
        , Kit.body Value.large [ Kit.onSurfaceVariant ] [ Kit.text note ]
        ]


featureItem : String -> Element { s | html : Supported } msg
featureItem note =
    Native.li [] [ Kit.body Value.large [ Kit.onSurfaceVariant ] [ Kit.text note ] ]


pageHeading : Element { s | heading : Supported } msg
pageHeading =
    Heading.view { content = Kit.text "Browser Support" }
        [ Heading.variant Value.display, Heading.size Value.small, Heading.level 1 ]
        []


sectionHeading : String -> Element { s | heading : Supported } msg
sectionHeading label =
    Heading.view { content = Kit.text label }
        [ Heading.variant Value.headline, Heading.size Value.small, Heading.level 2 ]
        []


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Browser Support · elm-m3e"
    , body =
        [ Element.toNode
            (pane
                [ Layout.section "space-y-3"
                    [ pageHeading
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "elm-m3e renders @m3e/web custom elements, so it runs anywhere standard Web Components and ES modules run — the modern-browser baseline." ]
                    ]
                , Layout.section "space-y-3"
                    [ sectionHeading "Supported browsers"
                    , Card.view
                        [ Card.variant Value.outlined ]
                        [ Card.content
                            (Layout.div "flex flex-col px-2"
                                (List.intersperse (Divider.view [] [])
                                    [ supportRow "Chrome / Edge" "Latest 2 versions"
                                    , supportRow "Firefox" "Latest 2 versions"
                                    , supportRow "Safari" "Latest 2 versions"
                                    , supportRow "Mobile Safari / Chrome Android" "Latest 2 versions"
                                    ]
                                )
                            )
                        ]
                    ]
                , Layout.section "space-y-3"
                    [ sectionHeading "Platform features used"
                    , Layout.ul "list-disc space-y-1.5 pl-5"
                        [ featureItem "Custom Elements v1 and Shadow DOM for the @m3e/web components."
                        , featureItem "ES modules for component registration (no-bundler import-map usage is also supported upstream)."
                        , featureItem "CSS custom properties and the light-dark() function for the M3 token cascade and dark mode."
                        , featureItem "Variable fonts for the self-hosted Material Symbols icon axes."
                        ]
                    ]
                ]
            )
        ]
    }
