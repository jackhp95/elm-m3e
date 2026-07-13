module Route.Styles.Motion exposing (ActionData, Data, Model, Msg, route)

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import Kit
import Layout
import M3e
import Markup.Atoms
import Markup.Element as Element exposing (Element)
import M3e.Record.Heading as Heading
import M3e.Kind
import M3e.Token as Value
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
        , description = "The M3 motion system: easing and duration tokens."
        , locale = Nothing
        , title = "Motion · elm-m3e"
        }
        |> Seo.website


pageHeading : Element { s | heading : M3e.Kind.Brand } msg
pageHeading =
    Heading.view { content = Markup.Atoms.text "Motion" }
        [ Heading.variant Value.display, Heading.size Value.small, Heading.level 1 ]
        []


{-| A `(token, value)` reference table: the CSS custom property on the left, its
literal value on the right, divider-separated inside an outlined card.
-}
tokenTable : List ( String, String ) -> Element { r | card : M3e.Kind.Brand } msg
tokenTable rows =
    M3e.card
        [ M3e.variantOutlined ]
        [ M3e.cardSlotContent
            (Layout.div "flex flex-col px-2"
                (List.intersperse (M3e.divider [] []) (List.map tokenRow rows))
            )
        ]


tokenRow : ( String, String ) -> Element { s | html : M3e.Kind.Brand } msg
tokenRow ( token, value ) =
    Layout.div "flex flex-wrap items-baseline justify-between gap-2 py-2.5"
        [ Kit.code Value.medium [ Kit.onSurface ] [ Kit.text token ]
        , Kit.code Value.medium [ Kit.onSurfaceVariant ] [ Kit.text value ]
        ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Motion · elm-m3e"
    , body =
        [ Element.toNode
            (Doc.pane
                [ Layout.section "space-y-3"
                    [ pageHeading
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "Material 3 motion is encoded as easing and duration tokens. The standard set drives functional transitions; the expressive set adds spring-like emphasis. <m3e-theme> exposes a motion attribute, surfaced in M3e.Theme as Theme.withMotion." ]
                        ]
                    ]
                , Layout.section "space-y-3"
                    [ Doc.sectionHeading "Schemes"
                    , Layout.ul "list-disc space-y-1.5 pl-5"
                        [ Native.li []
                            [ Kit.body Value.large
                                [ Kit.onSurfaceVariant ]
                                [ Kit.code Value.large [ Kit.onSurface ] [ Kit.text "Theme.MotionStandard" ]
                                , Kit.text " — functional, restrained transitions."
                                ]
                            ]
                        , Native.li []
                            [ Kit.body Value.large
                                [ Kit.onSurfaceVariant ]
                                [ Kit.code Value.large [ Kit.onSurface ] [ Kit.text "Theme.MotionExpressive" ]
                                , Kit.text " — emphasized, spring-driven motion for M3 Expressive surfaces."
                                ]
                            ]
                        ]
                    ]
                , Layout.section "space-y-3"
                    [ Doc.sectionHeading "Easing curves"
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "Six --md-sys-motion-easing-* cubic-beziers. The emphasized set drives prominent transitions; the standard set drives small, utility-focused ones. Each has an accelerate (entering) and decelerate (exiting) variant." ]
                        ]
                    , tokenTable
                        [ ( "--md-sys-motion-easing-emphasized", "cubic-bezier(0.2, 0, 0, 1)" )
                        , ( "--md-sys-motion-easing-emphasized-decelerate", "cubic-bezier(0.05, 0.7, 0.1, 1)" )
                        , ( "--md-sys-motion-easing-emphasized-accelerate", "cubic-bezier(0.3, 0, 0.8, 0.15)" )
                        , ( "--md-sys-motion-easing-standard", "cubic-bezier(0.2, 0, 0, 1)" )
                        , ( "--md-sys-motion-easing-standard-decelerate", "cubic-bezier(0, 0, 0, 1)" )
                        , ( "--md-sys-motion-easing-standard-accelerate", "cubic-bezier(0.3, 0, 1, 1)" )
                        ]
                    ]
                , Layout.section "space-y-3"
                    [ Doc.sectionHeading "Durations"
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "Sixteen --md-sys-motion-duration-* steps in four bands. Short for small utility transitions, medium for traversing part of the screen, long for expressive moves, extra-long for ambient motion." ]
                        ]
                    , tokenTable
                        [ ( "--md-sys-motion-duration-short-1", "50ms" )
                        , ( "--md-sys-motion-duration-short-2", "100ms" )
                        , ( "--md-sys-motion-duration-short-3", "150ms" )
                        , ( "--md-sys-motion-duration-short-4", "200ms" )
                        , ( "--md-sys-motion-duration-medium-1", "250ms" )
                        , ( "--md-sys-motion-duration-medium-2", "300ms" )
                        , ( "--md-sys-motion-duration-medium-3", "350ms" )
                        , ( "--md-sys-motion-duration-medium-4", "400ms" )
                        , ( "--md-sys-motion-duration-long-1", "450ms" )
                        , ( "--md-sys-motion-duration-long-2", "500ms" )
                        , ( "--md-sys-motion-duration-long-3", "550ms" )
                        , ( "--md-sys-motion-duration-long-4", "600ms" )
                        , ( "--md-sys-motion-duration-extra-long-1", "700ms" )
                        , ( "--md-sys-motion-duration-extra-long-2", "800ms" )
                        , ( "--md-sys-motion-duration-extra-long-3", "900ms" )
                        , ( "--md-sys-motion-duration-extra-long-4", "1000ms" )
                        ]
                    ]
                , Layout.section "space-y-3"
                    [ Doc.sectionHeading "Springs"
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "M3 Expressive replaces some easings with springs: a duration paired with an overshooting curve. Spatial springs move layout and position; effects springs animate visual properties like color and opacity." ]
                        ]
                    , tokenTable
                        [ ( "--md-sys-motion-spring-fast-spatial", "350ms cubic-bezier(0.27, 1.06, 0.18, 1)" )
                        , ( "--md-sys-motion-spring-default-spatial", "500ms cubic-bezier(0.27, 1.06, 0.18, 1)" )
                        , ( "--md-sys-motion-spring-slow-spatial", "750ms cubic-bezier(0.27, 1.06, 0.18, 1)" )
                        , ( "--md-sys-motion-spring-fast-effects", "150ms cubic-bezier(0.31, 0.94, 0.34, 1)" )
                        , ( "--md-sys-motion-spring-default-effects", "200ms cubic-bezier(0.34, 0.8, 0.34, 1)" )
                        , ( "--md-sys-motion-spring-slow-effects", "200ms cubic-bezier(0.34, 0.88, 0.34, 1)" )
                        ]
                    ]
                ]
            )
        ]
    }
