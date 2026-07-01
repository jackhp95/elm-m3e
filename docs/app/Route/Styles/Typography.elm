module Route.Styles.Typography exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (p, text)
import Html.Attributes exposing (class)
import Layout
import EscapeHatch
import Kit
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Divider as Divider
import M3e.Element as Element exposing (Element)
import M3e.Heading as Heading
import M3e.Node as Node exposing (Node)
import Native
import M3e.Value as Value exposing (Supported)
import Seam
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
        , description = "The M3 type scale, rendered live."
        , locale = Nothing
        , title = "Typography · elm-m3e"
        }
        |> Seo.website


scale : List ( String, String )
scale =
    [ ( "text-display-lg", "Display Large" )
    , ( "text-display-md", "Display Medium" )
    , ( "text-display-sm", "Display Small" )
    , ( "text-headline-lg", "Headline Large" )
    , ( "text-headline-md", "Headline Medium" )
    , ( "text-headline-sm", "Headline Small" )
    , ( "text-title-lg", "Title Large" )
    , ( "text-title-md", "Title Medium" )
    , ( "text-title-sm", "Title Small" )
    , ( "text-body-lg", "Body Large" )
    , ( "text-body-md", "Body Medium" )
    , ( "text-body-sm", "Body Small" )
    , ( "text-label-lg", "Label Large" )
    , ( "text-label-md", "Label Medium" )
    , ( "text-label-sm", "Label Small" )
    ]


row : ( String, String ) -> Element { s | html : Supported } msg
row ( cls, label ) =
    Layout.div "flex flex-wrap items-baseline justify-between gap-2 border-b border-outline-variant py-3 last:border-0"
        [ Layout.span (cls ++ " text-on-surface") [ Kit.text label ]
        , Native.node (Html.node "code") [ Seam.asAttribute (class "text-body-sm text-on-surface-variant") ] [ Kit.text cls ]
        ]


pageHeading : Element { s | heading : Supported } msg
pageHeading =
    Heading.view { content = Kit.text "Typography" }
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
    { title = "Typography · elm-m3e"
    , body =
        List.map Element.toNode
            [ pane
            [ Layout.section "space-y-3"
                [ pageHeading
                , EscapeHatch.fromHtml
                    (p [ class "max-w-2xl text-body-lg text-on-surface-variant" ]
                        [ text "The M3 type scale has 15 standard roles (display, headline, title, body, label — each large/medium/small), each encoding font-size, line-height, weight, and tracking via --md-sys-typescale-* tokens. The bridge maps every role to a Tailwind utility." ]
                    )
                ]
            , Divider.view [] []
            , Layout.section "space-y-3"
                [ sectionHeading "The scale, live"
                , Card.view
                    [ Card.variant Value.outlined ]
                    [ Card.content
                        (Layout.div "px-2"
                            (List.map row scale)
                        )
                    ]
                   
                ]
            ]
        ]
    }
