module Route.Styles.Typography exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, div, p, section, text)
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
        , description = "The M3 type scale, rendered live."
        , locale = Nothing
        , title = "Typography · elm-m3e"
        }
        |> Seo.website


scale : List ( String, String )
scale =
    [ ( "text-display-large", "Display Large" )
    , ( "text-display-medium", "Display Medium" )
    , ( "text-display-small", "Display Small" )
    , ( "text-headline-large", "Headline Large" )
    , ( "text-headline-medium", "Headline Medium" )
    , ( "text-headline-small", "Headline Small" )
    , ( "text-title-large", "Title Large" )
    , ( "text-title-medium", "Title Medium" )
    , ( "text-title-small", "Title Small" )
    , ( "text-body-large", "Body Large" )
    , ( "text-body-medium", "Body Medium" )
    , ( "text-body-small", "Body Small" )
    , ( "text-label-large", "Label Large" )
    , ( "text-label-medium", "Label Medium" )
    , ( "text-label-small", "Label Small" )
    ]


row : ( String, String ) -> Html msg
row ( cls, label ) =
    div [ class "flex flex-wrap items-baseline justify-between gap-2 border-b border-outline-variant py-3 last:border-0" ]
        [ Html.span [ class (cls ++ " text-on-surface") ] [ text label ]
        , Html.code [ class "text-body-small text-on-surface-variant" ] [ text cls ]
        ]


pageHeading : Html msg
pageHeading =
    Heading.new
        |> Heading.withLevel 1
        |> Heading.withVariant Heading.Display
        |> Heading.withSize Heading.Small
        |> Heading.withContent (text "Typography")
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
    { title = "Typography · elm-m3e"
    , body =
        [ div [ class "mx-auto max-w-4xl space-y-8" ]
            [ section [ class "space-y-3" ]
                [ pageHeading
                , p [ class "max-w-2xl text-body-large text-on-surface-variant" ]
                    [ text "The M3 type scale has 15 standard roles (display, headline, title, body, label — each large/medium/small), each encoding font-size, line-height, weight, and tracking via --md-sys-typescale-* tokens. The bridge maps every role to a Tailwind utility." ]
                ]
            , Divider.new |> Divider.view
            , section [ class "space-y-3" ]
                [ sectionHeading "The scale, live"
                , Card.new Card.Outlined
                    |> Card.withBody (div [ class "px-2" ] (List.map row scale))
                    |> Card.view
                ]
            ]
        ]
    }
