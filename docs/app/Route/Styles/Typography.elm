module Route.Styles.Typography exposing (ActionData, Data, Model, Msg, route)

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import Kit
import Layout
import M3e
import M3e
import HtmlIr.Element exposing (Element)
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
        , description = "The M3 type scale, rendered live."
        , locale = Nothing
        , title = "Typography · elm-m3e"
        }
        |> Seo.website


{-| The 15 M3 type-scale roles, each a live exhibit (the matching `Kit`
primitive), the Tailwind class it maps to, and the role's concrete
font-size / line-height / weight from `--md-sys-typescale-*` (see
`sys/typescale.css`). The demo dogfoods the primitives: the exhibit _is_
`Kit.display`/`headline`/… .
-}
scale : List ( Element { s | html : M3e.Kind.Brand } adm_ msg, String, String )
scale =
    [ ( Kit.display Value.large [ Kit.onSurface ] [ Kit.text "Display Large" ], "text-display-lg", "3.5625rem / 4rem · 400" )
    , ( Kit.display Value.medium [ Kit.onSurface ] [ Kit.text "Display Medium" ], "text-display-md", "2.8125rem / 3.25rem · 400" )
    , ( Kit.display Value.small [ Kit.onSurface ] [ Kit.text "Display Small" ], "text-display-sm", "2.25rem / 2.75rem · 400" )
    , ( Kit.headline Value.large [ Kit.onSurface ] [ Kit.text "Headline Large" ], "text-headline-lg", "2rem / 2.5rem · 400" )
    , ( Kit.headline Value.medium [ Kit.onSurface ] [ Kit.text "Headline Medium" ], "text-headline-md", "1.75rem / 2.25rem · 400" )
    , ( Kit.headline Value.small [ Kit.onSurface ] [ Kit.text "Headline Small" ], "text-headline-sm", "1.5rem / 2rem · 400" )
    , ( Kit.title Value.large [ Kit.onSurface ] [ Kit.text "Title Large" ], "text-title-lg", "1.375rem / 1.75rem · 400" )
    , ( Kit.title Value.medium [ Kit.onSurface ] [ Kit.text "Title Medium" ], "text-title-md", "1rem / 1.5rem · 500" )
    , ( Kit.title Value.small [ Kit.onSurface ] [ Kit.text "Title Small" ], "text-title-sm", "0.875rem / 1.25rem · 500" )
    , ( Kit.body Value.large [ Kit.onSurface ] [ Kit.text "Body Large" ], "text-body-lg", "1rem / 1.5rem · 400" )
    , ( Kit.body Value.medium [ Kit.onSurface ] [ Kit.text "Body Medium" ], "text-body-md", "0.875rem / 1.25rem · 400" )
    , ( Kit.body Value.small [ Kit.onSurface ] [ Kit.text "Body Small" ], "text-body-sm", "0.75rem / 1rem · 400" )
    , ( Kit.labelText Value.large [ Kit.onSurface ] [ Kit.text "Label Large" ], "text-label-lg", "0.875rem / 1.25rem · 500" )
    , ( Kit.labelText Value.medium [ Kit.onSurface ] [ Kit.text "Label Medium" ], "text-label-md", "0.75rem / 1rem · 500" )
    , ( Kit.labelText Value.small [ Kit.onSurface ] [ Kit.text "Label Small" ], "text-label-sm", "0.6875rem / 1rem · 500" )
    ]


row : ( Element { s | html : M3e.Kind.Brand } adm_ msg, String, String ) -> Element { s | html : M3e.Kind.Brand } adm_ msg
row ( exhibit, cls, metrics ) =
    Layout.div "flex flex-wrap items-baseline justify-between gap-2 py-3"
        [ exhibit
        , Layout.div "flex flex-col items-end"
            [ Kit.code Value.medium [ Kit.onSurfaceVariant ] [ Kit.text cls ]
            , Kit.code Value.small [ Kit.onSurfaceVariant ] [ Kit.text metrics ]
            ]
        ]


pageHeading : Element { s | heading : M3e.Kind.Brand } adm_ msg
pageHeading =
    M3e.heading
        [ M3e.variantDisplay, M3e.sizeSmall, M3e.attrLevel 1 ]
        [ Markup.M3e.text "Typography" ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Typography · elm-m3e"
    , body =
        [ HtmlIr.Element.toNode
            (Doc.pane
                [ Layout.section "space-y-3"
                    [ pageHeading
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "The M3 type scale has 15 standard roles (display, headline, title, body, label — each large/medium/small), each encoding font-size, line-height, weight, and tracking via --md-sys-typescale-* tokens. The bridge maps every role to a Tailwind utility. Each row below shows its font-size / line-height · weight from the tokens." ]
                        ]
                    ]
                , Layout.section "space-y-3"
                    [ Doc.sectionHeading "The scale, live"
                    , M3e.card
                        [ M3e.variantOutlined ]
                        [ M3e.cardSlotContent
                            (Layout.div "flex flex-col px-2"
                                (List.intersperse (M3e.divider [] []) (List.map row scale))
                            )
                        ]
                    ]
                ]
            )
        ]
    }
