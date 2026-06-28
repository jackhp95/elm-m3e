module Route.Studies exposing (ActionData, Data, Model, Msg, route)

{-| Landing page for the Studies area — composed, real-world demos showing
many `Ui.*` components working together. The five studies are interactive
routes that the sidebar already links to; this page is the gallery.
-}

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (p, text)
import Html.Attributes exposing (class)
import Layout
import M3e.Button as Button
import M3e.Card as Card
import M3e.Divider as Divider
import M3e.Element as Element
import M3e.Heading as Heading
import M3e.Node as Node exposing (Node)
import M3e.Value as Value
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
    [ ( "reply", "Reply", "A Material 3 email / inbox client — nav family, app bar with search, message list, split-pane reading view, compose bottom sheet, and snackbar." )
    , ( "shrine", "Shrine", "A boutique storefront — filter chips, segmented view toggles, price slider, product cards with shape-clipped media, cart bottom sheet, and item dialog." )
    , ( "rally", "Rally", "A finance dashboard — tabs, account cards, transaction list, paginator, and live budget meters via progress indicators." )
    , ( "crane", "Crane", "A travel destination browser — scrolling row of hero shots, date picker, segmented party-size, image gallery, and segmented amenity filters." )
    , ( "settings", "Settings", "A Material 3 system settings surface — list/sublist navigation, switches, sliders, and a profile card." )
    ]


pageHeading : Node msg
pageHeading =
    Heading.view { label = "Studies", variant = Value.display }
        [ Heading.size Value.small, Heading.level 1 ]
        |> Element.toNode


studyCard : ( String, String, String ) -> Node msg
studyCard ( slug, title, body ) =
    let
        studyHref =
            "/studies/" ++ slug
    in
    Card.view
        [ Card.variant Value.elevated
        , Card.headline (Heading.view { label = title, variant = Value.title } [])
        , Card.body [ Element.html (p [ class "text-body-md text-on-surface-variant" ] [ text body ]) ]
        , Card.actions
            [ Button.view { label = "Open " ++ title, variant = Value.filled }
                [ Button.href studyHref
                , Button.target "_blank"
                , Button.rel "noreferrer noopener"
                ]
            ]
        ]
        |> Element.toNode


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Studies · elm-m3e"
    , body =
        [ Layout.container
            [ Layout.section "space-y-3"
                [ pageHeading
                , Node.raw
                    (p [ class "max-w-2xl text-body-lg text-on-surface-variant" ]
                        [ text "Studies are composed, real-world demos that show many elm-m3e components working together — the way the library is meant to be used. Each one is a real, interactive route, not a screenshot." ]
                    )
                ]
            , Divider.view [] |> Element.toNode
            , Layout.section "grid gap-4 sm:grid-cols-2"
                (List.map studyCard studies)
            ]
        ]
    }
