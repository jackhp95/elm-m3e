module Route.Styles.StateLayers exposing (ActionData, Data, Model, Msg, route)

{-| **State layers** — the translucent overlay every interactive M3 surface paints
on hover, focus, and press. Three opacity tokens (`--md-sys-state-*-state-layer-opacity`,
see `sys/state.css`) drive it, tinted with the element's on-color. Rendered live:
the m3e buttons below carry real state layers — hover, focus (Tab), and press them.
-}

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import HtmlIr.Element exposing (Element)
import Kit
import Layout
import M3e
import M3e.Attributes
import M3e.Card
import M3e.Kind
import M3e.Values as Value
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
        , description = "The M3 state-layer opacities for hover, focus, and press."
        , locale = Nothing
        , title = "State Layers · elm-m3e"
        }
        |> Seo.website


{-| `(token, value, what triggers it)` for the three state-layer opacities.
-}
states : List ( String, String, String )
states =
    [ ( "--md-sys-state-hover-state-layer-opacity", "8%", "Pointer over the element." )
    , ( "--md-sys-state-focus-state-layer-opacity", "10%", "Keyboard focus (Tab to the element)." )
    , ( "--md-sys-state-pressed-state-layer-opacity", "10%", "Active press / touch-down." )
    ]


stateRow : ( String, String, String ) -> Element { s | html : M3e.Kind.Brand } adm_ msg
stateRow ( token, value, trigger ) =
    Layout.div "flex flex-col gap-1 py-2.5"
        [ Layout.div "flex flex-wrap items-baseline justify-between gap-2"
            [ Kit.code Value.medium [ Kit.onSurface ] [ Kit.text token ]
            , Kit.code Value.medium [ Kit.onSurfaceVariant ] [ Kit.text value ]
            ]
        , Kit.body Value.medium [ Kit.onSurfaceVariant ] [ Kit.text trigger ]
        ]


demoButtons : Element { s | html : M3e.Kind.Brand } adm_ msg
demoButtons =
    Layout.div "flex flex-wrap gap-3 p-2"
        [ M3e.button [ M3e.Attributes.variant Value.filled ] [ Kit.text "Filled" ]
        , M3e.button [ M3e.Attributes.variant Value.tonal ] [ Kit.text "Tonal" ]
        , M3e.button [ M3e.Attributes.variant Value.outlined ] [ Kit.text "Outlined" ]
        , M3e.button [ M3e.Attributes.variant Value.text ] [ Kit.text "Text" ]
        ]


pageHeading : Element { s | heading : M3e.Kind.Brand } adm_ msg
pageHeading =
    M3e.heading
        [ M3e.Attributes.variant Value.display, M3e.Attributes.size Value.small, M3e.Attributes.level 1 ]
        [ M3e.text "State Layers" ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "State Layers · elm-m3e"
    , body =
        [ HtmlIr.Element.toNode
            (Doc.pane
                [ Layout.section "space-y-3"
                    [ pageHeading
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "Every interactive M3 surface paints a translucent state layer over itself to signal interaction. The layer takes the element's on-color and one of three opacities — hover, focus, or pressed — from the --md-sys-state-* tokens. It is additive: a focused-and-hovered element stacks both. m3e components render this for you; the tokens are here so you can match it in custom surfaces." ]
                        ]
                    ]
                , Layout.section "space-y-3"
                    [ Doc.sectionHeading "The three opacities"
                    , M3e.card
                        [ M3e.Attributes.variant Value.outlined ]
                        [ M3e.Card.content
                            (Layout.div "flex flex-col px-2"
                                (List.intersperse (M3e.divider [] []) (List.map stateRow states))
                            )
                        ]
                    ]
                , Layout.section "space-y-3"
                    [ Doc.sectionHeading "Live"
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "These buttons carry real state layers. Hover one for the 8% overlay, Tab to it for the 10% focus overlay, or press and hold for the 10% pressed overlay." ]
                        ]
                    , M3e.card [ M3e.Attributes.variant Value.outlined ] [ M3e.Card.content demoButtons ]
                    ]
                ]
            )
        ]
    }
