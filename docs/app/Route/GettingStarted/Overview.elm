module Route.GettingStarted.Overview exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, a, code, div, li, p, section, text, ul)
import Html.Attributes exposing (class, href)
import M3e.Card as Card
import M3e.Divider as Divider
import M3e.Heading as Heading
import M3e.Icon as Icon
import M3e.Node as Node
import M3e.Renderable as Renderable
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


toHtml : Renderable.Renderable any msg -> Html msg
toHtml r =
    r |> Renderable.toNode |> Node.toHtml


pageHeading : Html msg
pageHeading =
    Heading.view { label = "Overview", variant = Heading.Display }
        [ Heading.size Heading.Small, Heading.level 1 ]
        |> toHtml


sectionHeading : String -> Html msg
sectionHeading label =
    Heading.view { label = label, variant = Heading.Headline }
        [ Heading.size Heading.Small, Heading.level 2 ]
        |> toHtml


highlights : List ( String, String, String )
highlights =
    [ ( "tune", "Typed Builder API", "Every component is a small builder pipeline (`Ui.Foo.new |> with* |> view`) — the compiler refuses invalid compositions before runtime." )
    , ( "design_services", "Material Design 3 Compliance", "All 53 modules track the M3 spec and the @m3e/web Custom Elements Manifest, with per-component enums in place of stringly-typed attributes." )
    , ( "verified", "Slot-Safe Composition", "Typed slots ensure an icon slot only accepts a Ui.Icon, a leading slot only accepts a leading — no orphan content quietly disappearing into the default slot." )
    , ( "palette", "Theme as Owned State", "A single Ui.Theme drives the dynamic-color engine, dark/light, contrast, density, and motion for its subtree. No app-wide globals." )
    , ( "deselect", "Tree-Shakable Bindings", "Wraps thin per-element bindings, generated from the upstream CEM. The bundle pays for what it imports." )
    , ( "verified_user", "Test-Friendly", "Render targets are real `Html msg`. Logic is testable via `Test.Html`; rendered behavior is verified via Playwright against the @m3e/web runtime." )
    ]


highlightCard : ( String, String, String ) -> Html msg
highlightCard ( iconName, title, body ) =
    Card.new
        |> Card.withVariant Card.Filled
        |> Card.withHeadline (Heading.view { label = title, variant = Heading.Title } [])
        |> Card.withBody
            [ Renderable.html
                (div [ class "flex gap-3" ]
                    [ Html.span [ class "shrink-0 text-primary" ] [ Icon.view { name = iconName } |> toHtml ]
                    , p [ class "text-body-md text-on-surface-variant" ] [ text body ]
                    ]
                )
            ]
        |> Card.toNode
        |> Node.toHtml


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Overview · elm-m3e"
    , body =
        [ div [ class "mx-auto max-w-4xl space-y-8" ]
            [ section [ class "space-y-3" ]
                [ pageHeading
                , p [ class "text-body-lg text-on-surface-variant" ]
                    [ text "elm-m3e (the m3e-builder project) is a type-safe Elm binding layer over "
                    , code [ class "rounded bg-surface-container px-1.5 py-0.5 text-body-md" ] [ text "@m3e/web" ]
                    , text ", matraic's Material 3 Expressive web component library."
                    ]
                ]
            , Divider.view [] |> toHtml
            , section [ class "space-y-4" ]
                [ sectionHeading "What you get"
                , div [ class "grid grid-cols-1 gap-4 sm:grid-cols-2" ]
                    (List.map highlightCard highlights)
                ]
            , Divider.view [] |> toHtml
            , section [ class "space-y-3" ]
                [ sectionHeading "The MISI philosophy"
                , p [ class "text-body-lg text-on-surface-variant" ]
                    [ text "Every Ui.* module is a small builder that Makes Impossible States Impossible: typed-to-child slots, required collaborators at the call site, and one module per documented m3e component. Invalid compositions don't compile, and there are no silent no-ops." ]
                , ul [ class "list-disc space-y-1.5 pl-5 text-body-md text-on-surface-variant" ]
                    [ li [] [ text "Typed slots — an icon slot only accepts a Ui.Icon, never arbitrary Html." ]
                    , li [] [ text "Builders with required collaborators — you can't render an avatar without content." ]
                    , li [] [ text "53 modules mirroring the @m3e/web catalogue 1:1." ]
                    ]
                ]
            , Divider.view [] |> toHtml
            , section [ class "space-y-3" ]
                [ sectionHeading "Relationship to @m3e/web"
                , p [ class "text-body-lg text-on-surface-variant" ]
                    [ text "@m3e/web ships the custom elements, the dynamic-color "
                    , code [ class "rounded bg-surface-container px-1.5 py-0.5 text-body-md" ] [ text "<m3e-theme>" ]
                    , text " engine, and the M3 design tokens. elm-m3e wraps each element in a typed Elm builder and the tokens flow through Tailwind utilities (the tailwind-m3e-web bridge)."
                    ]
                , p [ class "text-body-lg text-on-surface-variant" ]
                    [ text "Next: "
                    , a [ href "/getting-started/installation", class "text-primary hover:underline" ] [ text "Installation" ]
                    , text "."
                    ]
                ]
            ]
        ]
    }
