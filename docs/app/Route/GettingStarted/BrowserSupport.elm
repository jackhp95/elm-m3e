module Route.GettingStarted.BrowserSupport exposing (ActionData, Data, Model, Msg, route)

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import HtmlIr.Element exposing (Element)
import Kit
import Layout
import M3e
import M3e.Attributes
import M3e.Card
import M3e.Kind
import M3e.Values as Value
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


supportRow : String -> String -> Element { s | html : M3e.Kind.Brand } adm_ msg
supportRow browser note =
    Layout.div "flex items-baseline justify-between gap-4 py-2.5"
        [ Kit.title Value.small [ Kit.onSurface ] [ Kit.text browser ]
        , Kit.body Value.large [ Kit.onSurfaceVariant ] [ Kit.text note ]
        ]


featureItem : String -> Element { s | html : M3e.Kind.Brand } adm_ msg
featureItem note =
    Native.node "li" [] [ Kit.body Value.large [ Kit.onSurfaceVariant ] [ Kit.text note ] ]


pageHeading : Element { s | heading : M3e.Kind.Brand } adm_ msg
pageHeading =
    M3e.heading
        [ M3e.Attributes.variant Value.display, M3e.Attributes.size Value.small, M3e.Attributes.level 1 ]
        [ M3e.text "Browser Support" ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Browser Support · elm-m3e"
    , body =
        [ HtmlIr.Element.toNode
            (Doc.pane
                [ Layout.section "space-y-3"
                    [ pageHeading
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "elm-m3e renders @m3e/web custom elements, so it runs anywhere standard Web Components and ES modules run — the modern-browser baseline." ]
                    ]
                , Layout.section "space-y-3"
                    [ Doc.sectionHeading "Supported browsers"
                    , M3e.card
                        [ M3e.Attributes.variant Value.outlined ]
                        [ M3e.Card.content
                            (Layout.div "flex flex-col px-2"
                                (List.intersperse (M3e.divider [] [])
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
                    [ Doc.sectionHeading "Platform features used"
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
