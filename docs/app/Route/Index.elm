module Route.Index exposing (ActionData, Data, Model, Msg, route)

{-| Documentation home for `m3e-builder` / `elm-m3e` — the type-safe, MISI Elm
builder layer (`M3e.*`) over matraic's `@m3e/web` Material 3 Expressive web
components.

The app shell (`Shared.elm`) owns the `<m3e-theme>`, the top app bar, and the
sidebar nav, so this page is just the hero + highlights content.

-}

import BackendTask exposing (BackendTask)
import EscapeHatch
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (code, div, p, text)
import Html.Attributes exposing (class)
import Kit
import Layout
import M3e.Avatar as Avatar
import M3e.Button as Button
import M3e.Card as Card
import M3e.ContentPane as ContentPane
import M3e.Divider as Divider
import M3e.Element as Element exposing (Element)
import M3e.Heading as Heading
import M3e.Icon as Icon
import M3e.Node as Node exposing (Node)
import M3e.Value as Value exposing (Supported)
import Native
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Seam
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
    RouteBuilder.single { head = head, data = data }
        |> RouteBuilder.buildNoState { view = view }


data : BackendTask FatalError Data
data =
    BackendTask.succeed {}


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-m3e"
        , image =
            { url = [ "favicon.ico" ] |> UrlPath.join |> Pages.Url.fromPath
            , alt = "elm-m3e"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Type-safe Material 3 Expressive web components for Elm."
        , locale = Nothing
        , title = "elm-m3e · type-safe Material 3 Expressive for Elm"
        }
        |> Seo.website


pane : List (Element { s | html : Supported } msg) -> Element { r | contentPane : Supported } msg
pane items =
    ContentPane.view [] (List.map ContentPane.child items)


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "elm-m3e · type-safe Material 3 Expressive for Elm"
    , body =
        List.map Element.toNode
            [ pane
                [ hero
                , Divider.view [] []
                , highlights
                , Divider.view [] []
                , statusGrid
                ]
            ]
    }


hero : Element { s | html : Supported } msg
hero =
    Layout.section "space-y-5"
        [ EscapeHatch.fromHtml
            (p [ class "text-label-lg uppercase tracking-wide text-primary" ]
                [ text "elm-m3e · m3e-builder" ]
            )
        , Heading.view { content = Kit.text "Type-safe Material 3 Expressive for Elm" }
            [ Heading.variant Value.display, Heading.size Value.small, Heading.level "1" ]
            []
        , EscapeHatch.fromHtml
            (p [ class "max-w-2xl text-body-lg text-on-surface-variant" ]
                [ text "A Make-Impossible-States-Impossible builder layer over matraic's "
                , code [ class "rounded bg-surface-container px-1.5 py-0.5 text-body-md" ] [ text "@m3e/web" ]
                , text " web components. Typed-to-child slots, builders with required collaborators, one module per documented m3e component — invalid compositions don't compile, and there are no silent no-ops."
                ]
            )
        , Layout.div "flex flex-wrap items-center gap-3 pt-2"
            [ Button.view [ Button.variant Value.filled, Button.href "/getting-started/installation" ] [ Button.child (Kit.text "Get started") ]
            , Button.view [ Button.variant Value.outlined, Button.href "/reference" ] [ Button.child (Kit.text "Browse the API reference") ]
            ]
        , Layout.div "flex items-center gap-3 pt-4"
            [ Avatar.view [ Seam.asAttribute (Html.Attributes.attribute "aria-label" "Sample avatar") ] [ Avatar.child (Native.img [ Seam.asAttribute (Html.Attributes.src "/avatar-sample.svg") ]) ]
            , EscapeHatch.fromHtml
                (div [ class "flex gap-3" ]
                    [ div [ class "block w-10 h-10 bg-primary rounded-md-corner-large" ] []
                    , div [ class "block w-10 h-10 bg-tertiary-container rounded-md-corner-extra-large" ] []
                    , div [ class "block w-10 h-10 bg-secondary-container rounded-full" ] []
                    ]
                )
            ]
        ]


sectionHeading : String -> Element { s | heading : Supported } msg
sectionHeading label =
    Heading.view { content = Kit.text label }
        [ Heading.variant Value.headline, Heading.size Value.medium, Heading.level "2" ]
        []


highlights : Element { s | html : Supported } msg
highlights =
    Layout.section "space-y-6"
        [ sectionHeading "Why elm-m3e"
        , Layout.div "grid gap-4 sm:grid-cols-3"
            [ highlightCard "verified"
                "Type-safe slots"
                "Containers take typed children — an icon slot can only hold a M3e.Icon. Invalid compositions are compile errors, not runtime no-ops."
            , highlightCard "category"
                "One module per component"
                "53 M3e.* modules mirroring matraic's @m3e/web catalogue, each a small builder with required collaborators."
            , highlightCard "palette"
                "Real M3 tokens"
                "Dynamic color, density, contrast, motion and the full type scale flow from a single <m3e-theme> — switch them live in the app bar."
            ]
        ]


highlightCard : String -> String -> String -> Element { s | card : Supported } msg
highlightCard iconName title body =
    Card.view
        [ Card.variant Value.outlined ]
        [ Card.header (Heading.view { content = Kit.text title } [ Heading.variant Value.title ] [])
        , Card.content
            (Layout.div "flex gap-3"
                [ Layout.span "shrink-0 text-primary"
                    [ Icon.view [ Icon.name iconName ] [] ]
                , EscapeHatch.fromHtml (p [ class "text-body-md text-on-surface-variant" ] [ text body ])
                ]
            )
        ]


statusGrid : Element { s | html : Supported } msg
statusGrid =
    Layout.section "space-y-6"
        [ sectionHeading "Status & roadmap"
        , EscapeHatch.fromHtml
            (p [ class "max-w-2xl text-body-lg text-on-surface-variant" ]
                [ text "The honest current state of the standalone library." ]
            )
        , Layout.div "grid gap-4 sm:grid-cols-2"
            [ statusCard "Complete (53)" "Every M3e.* module compiles against the bindings — buttons, cards, dialogs, the nav family, chips, fabs, form controls, sliders, date/time pickers, tooltips, and more."
            , statusCard "Documented" "Getting Started, Styles, and per-component pages (API tables) are generated; rich per-component demos and Studies are in progress."
            , statusCard "Removed (1)" "M3e.Table — m3e ships no table element, so it does not belong in a library that wraps m3e."
            , statusCard "Generator fixed" "elm-cem now resolves TS string-literal aliases to real per-component Elm enums and emits shared attributes per-component — benefiting every binding library."
            ]
        ]


statusCard : String -> String -> Element { s | card : Supported } msg
statusCard title body =
    Card.view
        [ Card.variant Value.outlined ]
        [ Card.header (Heading.view { content = Kit.text title } [ Heading.variant Value.title ] [])
        , Card.content (EscapeHatch.fromHtml (p [ class "text-body-md text-on-surface-variant" ] [ text body ]))
        ]
