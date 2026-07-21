module Route.Styles.Color exposing (ActionData, Data, Model, Msg, route)

import BackendTask
import Doc
import Head
import Head.Seo as Seo
import Kit
import Kit.Shape as Shape
import Kit.Surface as Surface exposing (Surface)
import Layout
import M3e
import M3e.Attributes
import M3e.Card
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
        , description = "The M3 color roles, rendered live from the dynamic scheme."
        , locale = Nothing
        , title = "Color · elm-m3e"
        }
        |> Seo.website


{-| An accent family: the bold role and its lower-emphasis container, each with the
`bg-*` role it paints. Each `Surface` bundles the background with its paired
`text-on-*` color, so a legible swatch _is_ proof the container/on-container roles
are paired correctly — the caption reads the role name off the surface.
-}
type alias Accent =
    { name : String
    , base : Surface
    , baseBg : String
    , container : Surface
    , containerBg : String
    }


accents : List Accent
accents =
    [ Accent "Primary" Surface.primary "bg-primary" Surface.primaryContainer "bg-primary-container"
    , Accent "Secondary" Surface.secondary "bg-secondary" Surface.secondaryContainer "bg-secondary-container"
    , Accent "Tertiary" Surface.tertiary "bg-tertiary" Surface.tertiaryContainer "bg-tertiary-container"
    , Accent "Error" Surface.error "bg-error" Surface.errorContainer "bg-error-container"
    ]


{-| Neutral surface roles — the app backgrounds, no accent pairing.
-}
surfaces : List ( String, String, Surface )
surfaces =
    [ ( "Surface", "bg-surface", Surface.surface )
    , ( "Surface Container", "bg-surface-container", Surface.surfaceContainer )
    , ( "Surface Container High", "bg-surface-container-high", Surface.surfaceContainerHigh )
    , ( "Inverse Surface", "bg-inverse-surface", Surface.inverseSurface )
    ]


{-| A container/on-container pairing row: the bold role beside its container, so the
"on" color is read directly off each layer/form.
-}
accentRow : Accent -> Element { s | html : M3e.Kind.Brand } adm_ msg
accentRow accent =
    Layout.div "grid grid-cols-2 gap-3"
        [ swatch ( accent.name, accent.baseBg, accent.base )
        , swatch ( accent.name ++ " Container", accent.containerBg, accent.container )
        ]


swatch : ( String, String, Surface ) -> Element { s | html : M3e.Kind.Brand } adm_ msg
swatch ( label, bg, role ) =
    Surface.view role
        [ Layout.class "flex flex-col justify-between p-4 min-h-24"
        , Shape.corner Shape.medium
        , Surface.outlined
        ]
        [ Kit.labelText Value.large [] [ Kit.text label ]
        , Kit.code Value.small [] [ Kit.text bg ]
        ]


pageHeading : Element { s | heading : M3e.Kind.Brand } adm_ msg
pageHeading =
    M3e.heading
        [ M3e.Attributes.variant Value.display, M3e.Attributes.size Value.small, M3e.Attributes.level 1 ]
        [ M3e.text "Color" ]


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Color · elm-m3e"
    , body =
        [ HtmlIr.Element.toNode
            (Doc.pane
                [ Layout.section "space-y-3"
                    [ pageHeading
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "Material 3 derives a full set of semantic color roles from a single source color via the dynamic-color engine in <m3e-theme>. Every role is a --md-sys-color-* token; the swatches below are live — change the source color, scheme, or contrast in the app bar settings and they re-derive." ]
                        ]
                    ]
                , Layout.section "space-y-3"
                    [ Doc.sectionHeading "Container pairings"
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "Each accent comes as a bold role and a lower-emphasis container, and every role carries a paired on-* color for legible content. The swatch text is painted with that on-color, so if the label is readable the pairing is correct." ]
                        ]
                    , Doc.showcase
                        (Layout.div "grid grid-cols-1 gap-3 lg:grid-cols-2"
                            (List.map accentRow accents)
                        )
                    ]
                , Layout.section "space-y-3"
                    [ Doc.sectionHeading "Surface roles"
                    , Doc.showcase
                        (Layout.div "grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-4"
                            (List.map swatch surfaces)
                        )
                    ]
                , Layout.section "space-y-3"
                    [ Doc.sectionHeading "Dynamic color"
                    , Layout.div "max-w-2xl"
                        [ Kit.paragraph Value.large
                            [ Kit.onSurfaceVariant ]
                            [ Kit.text "<m3e-theme> wraps Material's material-color-utilities to derive a full scheme from a seed at runtime. Swap the source color in the app bar to see every role above re-derive instantly." ]
                        ]
                    ]
                , Layout.section "space-y-3"
                    [ Doc.sectionHeading "Forced colors"
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


forcedColorsCard : Element { s | card : M3e.Kind.Brand } adm_ msg
forcedColorsCard =
    M3e.card
        [ M3e.Attributes.variant Value.outlined ]
        [ M3e.Card.header (M3e.heading [ M3e.Attributes.variant Value.title ] [ M3e.text "Test it" ])
        , M3e.Card.content
            (Kit.text "Enable Windows High Contrast or `forced-colors: active` in dev tools. The swatches above stay legible because every role respects the forced palette.")
        ]
