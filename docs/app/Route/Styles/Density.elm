module Route.Styles.Density exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, div, p, section, text)
import Html.Attributes exposing (class, style)
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import Ui.Button as Button
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
        , description = "The M3 density axis and how it scales component sizing."
        , locale = Nothing
        , title = "Density · elm-m3e"
        }
        |> Seo.website


demoBar : Int -> Html msg
demoBar scaleValue =
    div [ class "space-y-2" ]
        [ p [ class "text-label-large text-on-surface-variant" ]
            [ text ("density scale " ++ String.fromInt scaleValue) ]
        , div
            [ style "--md-sys-density-scale" (String.fromInt scaleValue)
            , class "flex flex-wrap gap-2"
            ]
            (List.range 1 4
                |> List.map
                    (\_ ->
                        Button.new { label = "Action", variant = Button.Filled }
                            |> Button.view
                    )
            )
        ]


pageHeading : Html msg
pageHeading =
    Heading.new
        |> Heading.withLevel 1
        |> Heading.withVariant Heading.Display
        |> Heading.withSize Heading.Small
        |> Heading.withContent (text "Density")
        |> Heading.view


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Density · elm-m3e"
    , body =
        [ div [ class "mx-auto max-w-4xl space-y-8" ]
            [ section [ class "space-y-3" ]
                [ pageHeading
                , p [ class "max-w-2xl text-body-large text-on-surface-variant" ]
                    [ text "Density compacts components for information-dense UIs. The --md-sys-density-scale token runs 0 (default, comfortable) through negative values (more compact). Set it globally via the app bar Density control, or scope it to a subtree with an inline style." ]
                ]
            , Divider.new |> Divider.view
            , Card.new Card.Outlined
                |> Card.withHeadline "Density scale, 0 to -3"
                |> Card.withBody
                    (div [ class "space-y-6" ]
                        [ demoBar 0
                        , demoBar -1
                        , demoBar -2
                        , demoBar -3
                        ]
                    )
                |> Card.view
            ]
        ]
    }
