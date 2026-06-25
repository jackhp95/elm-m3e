module Route.Studies exposing (ActionData, Data, Model, Msg, route)

{-| Landing page for the Studies area — composed, real-world demos showing
many `Ui.*` components working together. The five studies are interactive
routes that the sidebar already links to; this page is the gallery.
-}

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
        , description = "Composed, real-world demos built with elm-m3e."
        , locale = Nothing
        , title = "Studies · elm-m3e"
        }
        |> Seo.website


studies : List ( String, String, String )
studies =
    [ ( "reply", "Reply", "A Material 3 email / inbox client — nav family, app bar with search, message list, split-pane reading view, compose bottom sheet, and snackbar." )
    , ( "shrine", "Shrine", "A boutique storefront — filter chips, segmented view toggles, price slider, product cards with shape-clipped media, cart bottom sheet, and item dialog." )
    , ( "rally", "Rally", "A finance dashboard — tabs, account cards, transaction list, paginator, and live budget meters via progress indicators." )
    , ( "crane", "Crane", "A travel destination browser — scrolling row of hero shots, date picker, segmented party-size, image gallery, and segmented amenity filters." )
    , ( "settings", "Settings", "A Material 3 system settings surface — list/sublist navigation, switches, sliders, and a profile card." )
    ]


pageHeading : Html msg
pageHeading =
    Heading.new
        |> Heading.withLevel 1
        |> Heading.withVariant Heading.Display
        |> Heading.withSize Heading.Small
        |> Heading.withContent (text "Studies")
        |> Heading.view


studyCard : ( String, String, String ) -> Html msg
studyCard ( slug, title, body ) =
    let
        href =
            "/studies/" ++ slug
    in
    Card.new Card.Elevated
        |> Card.withHeadline (Heading.title title)
        |> Card.withBody (p [ class "text-body-md text-on-surface-variant" ] [ text body ])
        |> Card.withActions
            [ Button.new { label = "Open " ++ title, variant = Button.Filled }
                |> Button.withHref href
                |> Button.withTarget "_blank"
                |> Button.withRel "noreferrer noopener"
            ]
        |> Card.view


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Studies · elm-m3e"
    , body =
        [ div [ class "mx-auto max-w-4xl space-y-8" ]
            [ section [ class "space-y-3" ]
                [ pageHeading
                , p [ class "max-w-2xl text-body-lg text-on-surface-variant" ]
                    [ text "Studies are composed, real-world demos that show many elm-m3e components working together — the way the library is meant to be used. Each one is a real, interactive route, not a screenshot." ]
                ]
            , Divider.new |> Divider.view
            , section [ class "grid gap-4 sm:grid-cols-2" ]
                (List.map studyCard studies)
            ]
        ]
    }
