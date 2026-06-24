module Route.Studies exposing (ActionData, Data, Model, Msg, route)

{-| Landing page for the Studies area — composed, real-world demos. The
individual study pages are built in a later phase; this lists and links them.
-}

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, div, h1, h3, p, section, span, text)
import Html.Attributes exposing (attribute, class)
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
        , description = "Composed, real-world demos built with elm-m3e."
        , locale = Nothing
        , title = "Studies · elm-m3e"
        }
        |> Seo.website


studies : List ( String, String, String )
studies =
    [ ( "dashboard", "Settings dashboard", "App bar, nav rail, cards, switches, and sliders composed into a settings surface." )
    , ( "checkout", "Checkout flow", "A multi-step stepper with form fields, selects, and a confirmation dialog." )
    , ( "inbox", "Message inbox", "List items, avatars, badges, and a snackbar for transient confirmations." )
    , ( "media", "Media gallery", "Carousel, shapes, skeletons, and a bottom sheet of details." )
    ]


studyCard : ( String, String, String ) -> Html msg
studyCard ( _, title, body ) =
    div [ class "flex flex-col gap-2 rounded-md-corner-large border border-outline-variant bg-surface-container-low p-5" ]
        [ div [ class "flex items-center gap-2" ]
            [ span [ class "material-symbols-outlined text-primary", attribute "aria-hidden" "true" ] [ text "science" ]
            , h3 [ class "text-title-medium font-medium text-on-surface" ] [ text title ]
            ]
        , p [ class "text-body-medium text-on-surface-variant" ] [ text body ]
        , span [ class "mt-1 w-max rounded-full bg-surface-container-high px-2 py-0.5 text-label-small text-on-surface-variant" ]
            [ text "Coming soon" ]
        ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Studies · elm-m3e"
    , body =
        [ div [ class "mx-auto max-w-4xl space-y-8" ]
            [ section [ class "space-y-3" ]
                [ h1 [ class "text-display-small font-semibold text-on-surface" ] [ text "Studies" ]
                , p [ class "max-w-2xl text-body-large text-on-surface-variant" ]
                    [ text "Studies are composed, real-world demos that show many elm-m3e components working together — the way the library is meant to be used. The pages below are scaffolded; the interactive builds land in a later phase." ]
                ]
            , section [ class "grid gap-4 sm:grid-cols-2" ]
                (List.map studyCard studies)
            ]
        ]
    }
