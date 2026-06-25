module Route.Styles.Shape exposing (ActionData, Data, Model, Msg, route)

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
import Ui.Shape as Shape
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
        , description = "The M3 shape scale, rendered live with Ui.Shape."
        , locale = Nothing
        , title = "Shape · elm-m3e"
        }
        |> Seo.website


steps : List ( String, String )
steps =
    [ ( "rounded-md-corner-none", "None" )
    , ( "rounded-md-corner-extra-small", "Extra small" )
    , ( "rounded-md-corner-small", "Small" )
    , ( "rounded-md-corner-medium", "Medium" )
    , ( "rounded-md-corner-large", "Large" )
    , ( "rounded-md-corner-extra-large", "Extra large" )
    , ( "rounded-full", "Full" )
    ]


swatch : ( String, String ) -> Html msg
swatch ( cls, label ) =
    div [ class "flex flex-col items-center gap-2 text-label-sm text-on-surface-variant" ]
        [ Shape.new |> Shape.withClass ("block w-16 h-16 bg-primary-container " ++ cls) |> Shape.view
        , text label
        ]


pageHeading : Html msg
pageHeading =
    Heading.new
        |> Heading.withLevel 1
        |> Heading.withVariant Heading.Display
        |> Heading.withSize Heading.Small
        |> Heading.withContent (text "Shape")
        |> Heading.view


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Shape · elm-m3e"
    , body =
        [ div [ class "mx-auto max-w-4xl space-y-8" ]
            [ section [ class "space-y-3" ]
                [ pageHeading
                , p [ class "max-w-2xl text-body-lg text-on-surface-variant" ]
                    [ text "Material 3 defines a corner-radius scale from none through full. Each step is a --md-sys-shape-corner-* token, mapped to a rounded-md-corner-* Tailwind utility. Ui.Shape renders a decorative <m3e-shape> surface that respects it." ]
                ]
            , Divider.new |> Divider.view
            , Card.new Card.Outlined
                |> Card.withHeadline (Heading.title "Corner scale")
                |> Card.withBody (div [ class "flex flex-wrap items-end gap-6" ] (List.map swatch steps))
                |> Card.view
            ]
        ]
    }
