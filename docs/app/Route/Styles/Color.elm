module Route.Styles.Color exposing (ActionData, Data, Model, Msg, route)

import BackendTask
import Head
import Head.Seo as Seo
import Kit
import Kit.Shape as Shape
import Kit.Surface as Surface exposing (Surface)
import Layout
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.Record.Heading as Heading
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


{-| (label, `bg-*` utility to exhibit, surface role) for each M3 color role pair.

The `bg-*` string is the swatch's exhibit — it is shown verbatim as the caption —
while `Surface` paints the swatch, so the demo dogfoods `Kit.Surface`.

-}
roles : List ( String, String, Surface )
roles =
    [ ( "Primary", "bg-primary", Surface.primary )
    , ( "On Primary Container", "bg-primary-container", Surface.primaryContainer )
    , ( "Secondary", "bg-secondary", Surface.secondary )
    , ( "Secondary Container", "bg-secondary-container", Surface.secondaryContainer )
    , ( "Tertiary", "bg-tertiary", Surface.tertiary )
    , ( "Tertiary Container", "bg-tertiary-container", Surface.tertiaryContainer )
    , ( "Error", "bg-error", Surface.error )
    , ( "Error Container", "bg-error-container", Surface.errorContainer )
    , ( "Surface", "bg-surface", Surface.surface )
    , ( "Surface Container", "bg-surface-container", Surface.surfaceContainer )
    , ( "Surface Container High", "bg-surface-container-high", Surface.surfaceContainerHigh )
    , ( "Inverse Surface", "bg-inverse-surface", Surface.inverseSurface )
    ]


swatch : ( String, String, Surface ) -> Element { s | html : Supported } msg
swatch ( label, bg, role ) =
    Surface.view role
        [ Layout.class "flex flex-col justify-between p-4 min-h-24"
        , Shape.corner Shape.medium
        , Surface.outlined
        ]
        [ Kit.labelText Value.large [] [ Kit.text label ]
        , Kit.code Value.small [] [ Kit.text bg ]
        ]


pageHeading : Element { s | heading : Supported } msg
pageHeading =
    Heading.view { content = Kit.text "Color" }
        [ Heading.variant Value.display, Heading.size Value.small, Heading.level 1 ]
        []


sectionHeading : String -> Element { s | heading : Supported } msg
sectionHeading label =
    Heading.view { content = Kit.text label }
        [ Heading.variant Value.headline, Heading.size Value.small, Heading.level 2 ]
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
        [ Element.toNode
            (pane
                [ Layout.section "space-y-3"
                    [ pageHeading
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "Material 3 derives a full set of semantic color roles from a single source color via the dynamic-color engine in <m3e-theme>. Every role is a --md-sys-color-* token; the swatches below are live — change the source color, scheme, or contrast in the app bar settings and they re-derive." ]
                        ]
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
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "<m3e-theme> wraps Material's material-color-utilities to derive a full scheme from a seed at runtime. Swap the source color in the app bar to see every role above re-derive instantly." ]
                        ]
                    ]
                , Layout.section "space-y-3"
                    [ sectionHeading "Forced colors"
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "When the OS reports forced-colors (Windows High Contrast), components map their semantic roles onto the system palette automatically. No app changes required." ]
                        ]
                    , forcedColorsCard
                    ]
                ]
            )
        ]
    }


forcedColorsCard : Element { s | card : Supported } msg
forcedColorsCard =
    Card.view
        [ Card.variant Value.outlined ]
        [ Card.header (Heading.view { content = Kit.text "Test it" } [ Heading.variant Value.title ] [])
        , Card.content
            (Kit.text "Enable Windows High Contrast or `forced-colors: active` in dev tools. The swatches above stay legible because every role respects the forced palette.")
        ]
