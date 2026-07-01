module Route.Styles.Color exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import EscapeHatch
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (code, p, text)
import Html.Attributes exposing (class)
import Kit
import Layout
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.Heading as Heading
import M3e.Node as Node exposing (Node)
import M3e.Value as Value exposing (Supported)
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
        , description = "The M3 color roles, rendered live from the dynamic scheme."
        , locale = Nothing
        , title = "Color · elm-m3e"
        }
        |> Seo.website


{-| (label, bg utility, on-color utility) for each M3 color role pair.
-}
roles : List ( String, String, String )
roles =
    [ ( "Primary", "bg-primary", "text-on-primary" )
    , ( "On Primary Container", "bg-primary-container", "text-on-primary-container" )
    , ( "Secondary", "bg-secondary", "text-on-secondary" )
    , ( "Secondary Container", "bg-secondary-container", "text-on-secondary-container" )
    , ( "Tertiary", "bg-tertiary", "text-on-tertiary" )
    , ( "Tertiary Container", "bg-tertiary-container", "text-on-tertiary-container" )
    , ( "Error", "bg-error", "text-on-error" )
    , ( "Error Container", "bg-error-container", "text-on-error-container" )
    , ( "Surface", "bg-surface", "text-on-surface" )
    , ( "Surface Container", "bg-surface-container", "text-on-surface" )
    , ( "Surface Container High", "bg-surface-container-high", "text-on-surface" )
    , ( "Inverse Surface", "bg-inverse-surface", "text-inverse-on-surface" )
    ]


swatch : ( String, String, String ) -> Element { s | html : Supported } msg
swatch ( label, bg, on ) =
    Layout.div ("flex flex-col justify-between rounded-md-corner-medium border border-outline-variant p-4 min-h-24 " ++ bg ++ " " ++ on)
        [ Layout.span "text-label-lg font-medium" [ Kit.text label ]
        , EscapeHatch.fromHtml (code [ class "text-body-sm opacity-80" ] [ text bg ])
        ]


pageHeading : Element { s | heading : Supported } msg
pageHeading =
    Heading.view { content = Kit.text "Color" }
        [ Heading.variant Value.display, Heading.size Value.small, Heading.level "1" ]
        []


sectionHeading : String -> Element { s | heading : Supported } msg
sectionHeading label =
    Heading.view { content = Kit.text label }
        [ Heading.variant Value.headline, Heading.size Value.small, Heading.level "2" ]
        []


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


{-| A matraic-style "showcase" card: live demos in an outlined card's content slot.
-}
showcase : Element { s | html : Supported } msg -> Element { r | card : Supported } msg
showcase content =
    Card.view [ Card.variant Value.outlined ] [ Card.content content ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Color · elm-m3e"
    , body =
        List.map Element.toNode
            [ pane
                [ Layout.section "space-y-3"
                    [ pageHeading
                    , EscapeHatch.fromHtml
                        (p [ class "max-w-2xl text-body-lg text-on-surface-variant" ]
                            [ text "Material 3 derives a full set of semantic color roles from a single source color via the dynamic-color engine in <m3e-theme>. Every role is a --md-sys-color-* token; the swatches below are live — change the source color, scheme, or contrast in the app bar settings and they re-derive." ]
                        )
                    ]
                , Layout.section "space-y-3"
                    [ sectionHeading "Color roles"
                    , showcase
                        (Layout.div "grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-3"
                            (List.map swatch roles)
                        )
                    ]
                , Layout.section "space-y-3"
                    [ sectionHeading "Dynamic color"
                    , EscapeHatch.fromHtml
                        (p [ class "max-w-2xl text-body-lg text-on-surface-variant" ]
                            [ text "<m3e-theme> wraps Material's material-color-utilities to derive a full scheme from a seed at runtime. Swap the source color in the app bar to see every role above re-derive instantly." ]
                        )
                    ]
                , Layout.section "space-y-3"
                    [ sectionHeading "Forced colors"
                    , EscapeHatch.fromHtml
                        (p [ class "max-w-2xl text-body-lg text-on-surface-variant" ]
                            [ text "When the OS reports forced-colors (Windows High Contrast), components map their semantic roles onto the system palette automatically. No app changes required." ]
                        )
                    , forcedColorsCard
                    ]
                ]
            ]
    }


forcedColorsCard : Element { s | card : Supported } msg
forcedColorsCard =
    Card.view
        [ Card.variant Value.outlined ]
        [ Card.header (Heading.view { content = Kit.text "Test it" } [ Heading.variant Value.title ] [])
        , Card.content
            (EscapeHatch.fromHtml
                (text "Enable Windows High Contrast or `forced-colors: active` in dev tools. The swatches above stay legible because every role respects the forced palette.")
            )
        ]
