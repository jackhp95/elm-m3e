module Route.Styles.Motion exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (code, li, p, text, ul)
import Html.Attributes exposing (class)
import Layout
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
        , description = "The M3 motion system: easing and duration tokens."
        , locale = Nothing
        , title = "Motion · elm-m3e"
        }
        |> Seo.website


pageHeading : Node msg
pageHeading =
    Heading.view { label = "Motion", variant = Heading.Display }
        [ Heading.size Heading.Small, Heading.level 1 ]
        |> Element.toNode


sectionHeading : String -> Node msg
sectionHeading label =
    Heading.view { label = label, variant = Heading.Headline }
        [ Heading.size Heading.Small, Heading.level 2 ]
        |> Element.toNode


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Motion · elm-m3e"
    , body =
        [ Layout.div "mx-auto max-w-3xl space-y-8"
            [ Layout.section "space-y-3"
                [ pageHeading
                , Node.raw
                    (p [ class "max-w-2xl text-body-lg text-on-surface-variant" ]
                        [ text "Material 3 motion is encoded as easing and duration tokens. The standard set drives functional transitions; the expressive set adds spring-like emphasis. <m3e-theme> exposes a motion attribute, surfaced in Ui.Theme as Theme.withMotion." ]
                    )
                ]
            , Divider.view [] |> Element.toNode
            , Layout.section "space-y-3"
                [ sectionHeading "Schemes"
                , Node.raw
                    (ul [ class "list-disc space-y-1.5 pl-5 text-body-md text-on-surface-variant" ]
                        [ li [] [ code [ class "text-on-surface" ] [ text "Theme.MotionStandard" ], text " — functional, restrained transitions." ]
                        , li [] [ code [ class "text-on-surface" ] [ text "Theme.MotionExpressive" ], text " — emphasized, spring-driven motion for M3 Expressive surfaces." ]
                        ]
                    )
                ]
            , Divider.view [] |> Element.toNode
            , Layout.section "space-y-3"
                [ sectionHeading "Token families"
                , Node.raw
                    (ul [ class "list-disc space-y-1.5 pl-5 text-body-md text-on-surface-variant" ]
                        [ li [] [ code [ class "text-on-surface" ] [ text "--md-sys-motion-easing-*" ], text " — standard, emphasized, and their accel/decel variants." ]
                        , li [] [ code [ class "text-on-surface" ] [ text "--md-sys-motion-duration-*" ], text " — short / medium / long / extra-long steps." ]
                        ]
                    )
                ]
            ]
        ]
    }
