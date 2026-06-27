module Route.Styles.Typography exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, div, p, section, text)
import Html.Attributes exposing (class)
import M3e.Card as Card
import M3e.Divider as Divider
import M3e.Heading as Heading
import M3e.Node as Node
import M3e.Element as Element
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


toHtml : Element.Element any msg -> Html msg
toHtml r =
    r |> Element.toNode |> Node.toHtml


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


row : ( String, String ) -> Html msg
row ( cls, label ) =
    div [ class "flex flex-wrap items-baseline justify-between gap-2 border-b border-outline-variant py-3 last:border-0" ]
        [ Html.span [ class (cls ++ " text-on-surface") ] [ text label ]
        , Html.code [ class "text-body-sm text-on-surface-variant" ] [ text cls ]
        ]


pageHeading : Html msg
pageHeading =
    Heading.view { label = "Typography", variant = Heading.Display }
        [ Heading.size Heading.Small, Heading.level 1 ]
        |> toHtml


sectionHeading : String -> Html msg
sectionHeading label =
    Heading.view { label = label, variant = Heading.Headline }
        [ Heading.size Heading.Small, Heading.level 2 ]
        |> toHtml


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Typography · elm-m3e"
    , body =
        [ div [ class "mx-auto max-w-4xl space-y-8" ]
            [ section [ class "space-y-3" ]
                [ pageHeading
                , p [ class "max-w-2xl text-body-lg text-on-surface-variant" ]
                    [ text "The M3 type scale has 15 standard roles (display, headline, title, body, label — each large/medium/small), each encoding font-size, line-height, weight, and tracking via --md-sys-typescale-* tokens. The bridge maps every role to a Tailwind utility." ]
                ]
            , Divider.view [] |> toHtml
            , section [ class "space-y-3" ]
                [ sectionHeading "The scale, live"
                , Card.view
                    [ Card.variant Card.Outlined
                    , Card.body [ Element.html (div [ class "px-2" ] (List.map row scale)) ]
                    ]
                    |> Element.toNode
                    |> Node.toHtml
                ]
            ]
        ]
    }
