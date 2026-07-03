module Route.Styles.Motion exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Kit
import Layout
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.Heading as Heading
import M3e.Node as Node exposing (Node)
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
        , description = "The M3 motion system: easing and duration tokens."
        , locale = Nothing
        , title = "Motion · elm-m3e"
        }
        |> Seo.website


pageHeading : Element { s | heading : Supported } msg
pageHeading =
    Heading.view { content = Kit.text "Motion" }
        [ Heading.variant Value.display, Heading.size Value.small, Heading.level "1" ]
        []


sectionHeading : String -> Element { s | heading : Supported } msg
sectionHeading label =
    Heading.view { content = Kit.text label }
        [ Heading.variant Value.headline, Heading.size Value.small, Heading.level "2" ]
        []


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Motion · elm-m3e"
    , body =
        List.map Element.toNode
            [ pane
                [ Layout.section "space-y-3"
                    [ pageHeading
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "Material 3 motion is encoded as easing and duration tokens. The standard set drives functional transitions; the expressive set adds spring-like emphasis. <m3e-theme> exposes a motion attribute, surfaced in Ui.Theme as Theme.withMotion." ]
                        ]
                    ]
                , Layout.section "space-y-3"
                    [ sectionHeading "Schemes"
                    , Layout.ul "list-disc space-y-1.5 pl-5"
                        [ Native.li []
                            [ Kit.body Value.large
                                [ Kit.onSurfaceVariant ]
                                [ Kit.code Value.large [ Kit.onSurface ] [ Kit.text "Theme.MotionStandard" ]
                                , Kit.text " — functional, restrained transitions."
                                ]
                            ]
                        , Native.li []
                            [ Kit.body Value.large
                                [ Kit.onSurfaceVariant ]
                                [ Kit.code Value.large [ Kit.onSurface ] [ Kit.text "Theme.MotionExpressive" ]
                                , Kit.text " — emphasized, spring-driven motion for M3 Expressive surfaces."
                                ]
                            ]
                        ]
                    ]
                , Layout.section "space-y-3"
                    [ sectionHeading "Token families"
                    , Layout.ul "list-disc space-y-1.5 pl-5"
                        [ Native.li []
                            [ Kit.body Value.large
                                [ Kit.onSurfaceVariant ]
                                [ Kit.code Value.large [ Kit.onSurface ] [ Kit.text "--md-sys-motion-easing-*" ]
                                , Kit.text " — standard, emphasized, and their accel/decel variants."
                                ]
                            ]
                        , Native.li []
                            [ Kit.body Value.large
                                [ Kit.onSurfaceVariant ]
                                [ Kit.code Value.large [ Kit.onSurface ] [ Kit.text "--md-sys-motion-duration-*" ]
                                , Kit.text " — short / medium / long / extra-long steps."
                                ]
                            ]
                        ]
                    ]
                ]
            ]
    }
