module Route.Styles.Density exposing (ActionData, Data, Model, Msg, route)

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import Kit
import Layout
import M3e
import M3e.Attributes
import M3e.Card
import HtmlIr.Element exposing (Element)
import M3e.Kind
import M3e.Values as Value
import Native
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
        , description = "The M3 density axis and how it scales component sizing."
        , locale = Nothing
        , title = "Density · elm-m3e"
        }
        |> Seo.website


{-| Elm can't set a CSS custom property (`style`/`Native.style` use
`node.style[key]=…`, which ignores `--vars`), so scope `--md-sys-density-scale`
to this subtree via a Tailwind arbitrary-property class. Literal strings per
scale so Tailwind's scanner emits all four rules.
-}
densityScaleClass : Int -> String
densityScaleClass n =
    if n <= -3 then
        "[--md-sys-density-scale:-3]"

    else if n == -2 then
        "[--md-sys-density-scale:-2]"

    else if n == -1 then
        "[--md-sys-density-scale:-1]"

    else
        "[--md-sys-density-scale:0]"


demoBar : Int -> Element { s | html : M3e.Kind.Brand } adm_ msg
demoBar scaleValue =
    Layout.div "space-y-2"
        [ Kit.labelText Value.large
            [ Kit.onSurfaceVariant ]
            [ Kit.text ("density scale " ++ String.fromInt scaleValue) ]
        , Native.node "div"
            [ Layout.class (densityScaleClass scaleValue ++ " flex flex-wrap gap-2") ]
            (List.range 1 4
                |> List.map
                    (\_ ->
                        M3e.button [ M3e.Attributes.variant Value.filled ] [ Kit.text "Action" ]
                    )
            )
        ]


pageHeading : Element { s | heading : M3e.Kind.Brand } adm_ msg
pageHeading =
    M3e.heading
        [ M3e.Attributes.variant Value.display, M3e.Attributes.size Value.small, M3e.Attributes.level 1 ]
        [ M3e.text "Density" ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Density · elm-m3e"
    , body =
        [ HtmlIr.Element.toNode
            (Doc.pane
                [ Layout.section "space-y-3"
                    [ pageHeading
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "Density compacts components for information-dense UIs. The --md-sys-density-scale token runs 0 (default, comfortable) through negative values (more compact). Set it globally via the app bar Density control, or scope it to a subtree. The scales below run 0 to -3." ]
                        ]
                    ]
                , M3e.card
                    [ M3e.Attributes.variant Value.outlined ]
                    [ M3e.Card.header (M3e.heading [ M3e.Attributes.variant Value.title ] [ M3e.text "Density scale, 0 to -3" ])
                    , M3e.Card.content
                        (Layout.div "space-y-6"
                            [ demoBar 0
                            , demoBar -1
                            , demoBar -2
                            , demoBar -3
                            ]
                        )
                    ]
                ]
            )
        ]
    }
