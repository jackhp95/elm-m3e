module Route.GettingStarted.Overview exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html
import Kit
import Layout
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Element as Element exposing (Element)
import M3e.Heading as Heading
import M3e.Icon as Icon
import M3e.Value as Value exposing (Supported)
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
        , description = "What elm-m3e is and how it relates to @m3e/web."
        , locale = Nothing
        , title = "Overview · elm-m3e"
        }
        |> Seo.website


pageHeading : Element { s | heading : Supported } msg
pageHeading =
    Heading.view { content = Kit.text "Overview" }
        [ Heading.variant Value.display, Heading.size Value.small, Heading.level "1" ]
        []


sectionHeading : String -> Element { s | heading : Supported } msg
sectionHeading label =
    Heading.view { content = Kit.text label }
        [ Heading.variant Value.headline, Heading.size Value.small, Heading.level "2" ]
        []


highlights : List ( String, String, String )
highlights =
    [ ( "tune", "Typed View API", "Every component is `M3e.Foo.view {required} [options]` returning typed `Element` content — the compiler refuses invalid compositions before runtime." )
    , ( "design_services", "Material Design 3 Compliance", "All 53 modules track the M3 spec and the @m3e/web Custom Elements Manifest, with per-component enums in place of stringly-typed attributes." )
    , ( "verified", "Slot-Safe Composition", "Typed slots ensure an icon slot only accepts a M3e.Icon, a leading slot only accepts a leading — no orphan content quietly disappearing into the default slot." )
    , ( "palette", "Theme as Owned State", "A single M3e.Theme drives the dynamic-color engine, dark/light, contrast, density, and motion for its subtree. No app-wide globals." )
    , ( "deselect", "Tree-Shakable Bindings", "Wraps thin per-element bindings, generated from the upstream CEM. The bundle pays for what it imports." )
    , ( "verified_user", "Test-Friendly", "Render targets are real `Html msg`. Logic is testable via `Test.Html`; rendered behavior is verified via Playwright against the @m3e/web runtime." )
    ]


highlightCard : ( String, String, String ) -> Element { s | card : Supported } msg
highlightCard ( iconName, title, body ) =
    Card.view
        [ Card.variant Value.filled ]
        [ Card.header (Heading.view { content = Kit.text title } [ Heading.variant Value.title ] [])
        , Card.content
            (Layout.div "flex gap-3"
                [ Layout.span "shrink-0"
                    [ Kit.colored [ Kit.primary ] [ Icon.view [ Icon.name iconName ] [] ] ]
                , Kit.paragraph Value.large [ Kit.onSurfaceVariant ] [ Kit.text body ]
                ]
            )
        ]


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Overview · elm-m3e"
    , body =
        List.map Element.toNode
            [ pane
                [ Layout.section "space-y-3"
                    [ pageHeading
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "elm-m3e (the m3e-builder project) is a type-safe Elm binding layer over "
                        , Native.node (Html.node "code") [] [ Kit.text "@m3e/web" ]
                        , Kit.text ", matraic's Material 3 Expressive web component library."
                        ]
                    ]
                , Layout.section "space-y-4"
                    [ sectionHeading "What you get"
                    , Layout.div "grid grid-cols-1 gap-4 sm:grid-cols-2"
                        (List.map highlightCard highlights)
                    ]
                , Layout.section "space-y-3"
                    [ sectionHeading "The MISI philosophy"
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "Every M3e.* module is a small builder that Makes Impossible States Impossible: typed-to-child slots, required collaborators at the call site, and one module per documented m3e component. Invalid compositions don't compile, and there are no silent no-ops." ]
                    , Layout.ul "list-disc space-y-1.5 pl-5"
                        [ Native.li [] [ Kit.body Value.large [ Kit.onSurfaceVariant ] [ Kit.text "Typed slots — an icon slot only accepts a M3e.Icon, never arbitrary Html." ] ]
                        , Native.li [] [ Kit.body Value.large [ Kit.onSurfaceVariant ] [ Kit.text "Builders with required collaborators — you can't render an avatar without content." ] ]
                        , Native.li [] [ Kit.body Value.large [ Kit.onSurfaceVariant ] [ Kit.text "53 modules mirroring the @m3e/web catalogue 1:1." ] ]
                        ]
                    ]
                , Layout.section "space-y-3"
                    [ sectionHeading "Relationship to @m3e/web"
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "@m3e/web ships the custom elements, the dynamic-color "
                        , Native.node (Html.node "code") [] [ Kit.text "<m3e-theme>" ]
                        , Kit.text " engine, and the M3 design tokens. elm-m3e wraps each element in a typed Elm builder and the tokens flow through Tailwind utilities (the tailwind-m3e-web bridge)."
                        ]
                    , Kit.paragraph Value.large
                        [ Kit.onSurfaceVariant ]
                        [ Kit.text "Next: "
                        , Kit.textLink "/getting-started/installation" [ Kit.primary ] [ Kit.text "Installation" ]
                        , Kit.text "."
                        ]
                    ]
                ]
            ]
    }
