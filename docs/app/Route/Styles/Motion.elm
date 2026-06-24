module Route.Styles.Motion exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, code, div, li, p, section, text, ul)
import Html.Attributes exposing (class)
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
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
        , description = "The M3 motion system: easing and duration tokens."
        , locale = Nothing
        , title = "Motion · elm-m3e"
        }
        |> Seo.website


pageHeading : Html msg
pageHeading =
    Heading.new
        |> Heading.withLevel 1
        |> Heading.withVariant Heading.Display
        |> Heading.withSize Heading.Small
        |> Heading.withContent (text "Motion")
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
    { title = "Motion · elm-m3e"
    , body =
        [ div [ class "mx-auto max-w-3xl space-y-8" ]
            [ section [ class "space-y-3" ]
                [ pageHeading
                , p [ class "max-w-2xl text-body-large text-on-surface-variant" ]
                    [ text "Material 3 motion is encoded as easing and duration tokens. The standard set drives functional transitions; the expressive set adds spring-like emphasis. <m3e-theme> exposes a motion attribute, surfaced in Ui.Theme as Theme.withMotion." ]
                ]
            , Divider.new |> Divider.view
            , section [ class "space-y-3" ]
                [ sectionHeading "Schemes"
                , ul [ class "list-disc space-y-1.5 pl-5 text-body-medium text-on-surface-variant" ]
                    [ li [] [ code [ class "text-on-surface" ] [ text "Theme.MotionStandard" ], text " — functional, restrained transitions." ]
                    , li [] [ code [ class "text-on-surface" ] [ text "Theme.MotionExpressive" ], text " — emphasized, spring-driven motion for M3 Expressive surfaces." ]
                    ]
                ]
            , Divider.new |> Divider.view
            , section [ class "space-y-3" ]
                [ sectionHeading "Token families"
                , ul [ class "list-disc space-y-1.5 pl-5 text-body-medium text-on-surface-variant" ]
                    [ li [] [ code [ class "text-on-surface" ] [ text "--md-sys-motion-easing-*" ], text " — standard, emphasized, and their accel/decel variants." ]
                    , li [] [ code [ class "text-on-surface" ] [ text "--md-sys-motion-duration-*" ], text " — short / medium / long / extra-long steps." ]
                    ]
                ]
            ]
        ]
    }
