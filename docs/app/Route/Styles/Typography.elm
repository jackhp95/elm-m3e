module Route.Styles.Typography exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (p, text)
import Html.Attributes exposing (class)
import M3e.Card as Card
import M3e.Divider as Divider
import M3e.Element as Element
import M3e.Heading as Heading
import M3e.Node as Node exposing (Node)
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


row : ( String, String ) -> Node msg
row ( cls, label ) =
    Node.element "div"
        [ Node.rawAttr (class "flex flex-wrap items-baseline justify-between gap-2 border-b border-outline-variant py-3 last:border-0") ]
        [ Node.element "span" [ Node.rawAttr (class (cls ++ " text-on-surface")) ] [ Node.text label ]
        , Node.element "code" [ Node.rawAttr (class "text-body-sm text-on-surface-variant") ] [ Node.text cls ]
        ]


pageHeading : Node msg
pageHeading =
    Heading.view { label = "Typography", variant = Heading.Display }
        [ Heading.size Heading.Small, Heading.level 1 ]
        |> Element.toNode


sectionHeading : String -> Node msg
sectionHeading label =
    Heading.view { label = label, variant = Heading.Headline }
        [ Heading.size Heading.Small, Heading.level 2 ]
        |> Element.toNode


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Typography · elm-m3e"
    , body =
        [ Node.element "div"
            [ Node.rawAttr (class "mx-auto max-w-4xl space-y-8") ]
            [ Node.element "section"
                [ Node.rawAttr (class "space-y-3") ]
                [ pageHeading
                , Node.raw
                    (p [ class "max-w-2xl text-body-lg text-on-surface-variant" ]
                        [ text "The M3 type scale has 15 standard roles (display, headline, title, body, label — each large/medium/small), each encoding font-size, line-height, weight, and tracking via --md-sys-typescale-* tokens. The bridge maps every role to a Tailwind utility." ]
                    )
                ]
            , Divider.view [] |> Element.toNode
            , Node.element "section"
                [ Node.rawAttr (class "space-y-3") ]
                [ sectionHeading "The scale, live"
                , Card.view
                    [ Card.variant Card.Outlined
                    , Card.body
                        [ Element.fromNode
                            (Node.element "div"
                                [ Node.rawAttr (class "px-2") ]
                                (List.map row scale)
                            )
                        ]
                    ]
                    |> Element.toNode
                ]
            ]
        ]
    }
