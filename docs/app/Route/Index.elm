module Route.Index exposing (ActionData, Data, Model, Msg, route)

{-| Documentation home for `m3e-builder` / `elm-m3e` — the type-safe, MISI Elm
builder layer (`M3e.*`) over matraic's `@m3e/web` Material 3 Expressive web
components.

The app shell (`Shared.elm`) owns the `<m3e-theme>`, the top app bar, and the
sidebar nav, so this page is just the hero + highlights content.

-}

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (code, div, p, text)
import Html.Attributes exposing (class)
import M3e.Avatar as Avatar
import M3e.Button as Button
import M3e.Card as Card
import M3e.Divider as Divider
import M3e.Element as Element
import M3e.Heading as Heading
import M3e.Icon as Icon
import M3e.Node as Node exposing (Node)
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


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "elm-m3e · type-safe Material 3 Expressive for Elm"
    , body =
        [ Node.element "div"
            [ Node.rawAttr (class "mx-auto max-w-5xl space-y-16") ]
            [ hero
            , Divider.view [] |> Element.toNode
            , highlights
            , Divider.view [] |> Element.toNode
            , statusGrid
            ]
        ]
    }


hero : Node msg
hero =
    Node.element "section"
        [ Node.rawAttr (class "space-y-5") ]
        [ Node.raw
            (p [ class "text-label-lg uppercase tracking-wide text-primary" ]
                [ text "elm-m3e · m3e-builder" ]
            )
        , Heading.view { label = "Type-safe Material 3 Expressive for Elm", variant = Heading.Display }
            [ Heading.size Heading.Small, Heading.level 1 ]
            |> Element.toNode
        , Node.raw
            (p [ class "max-w-2xl text-body-lg text-on-surface-variant" ]
                [ text "A Make-Impossible-States-Impossible builder layer over matraic's "
                , code [ class "rounded bg-surface-container px-1.5 py-0.5 text-body-md" ] [ text "@m3e/web" ]
                , text " web components. Typed-to-child slots, builders with required collaborators, one module per documented m3e component — invalid compositions don't compile, and there are no silent no-ops."
                ]
            )
        , Node.element "div"
            [ Node.rawAttr (class "flex flex-wrap items-center gap-3 pt-2") ]
            [ Button.view { label = "Get started", variant = Button.Filled } [ Button.href "/getting-started/installation" ] |> Element.toNode
            , Button.view { label = "Browse the API reference", variant = Button.Outlined } [ Button.href "/reference" ] |> Element.toNode
            ]
        , Node.element "div"
            [ Node.rawAttr (class "flex items-center gap-3 pt-4") ]
            [ Avatar.view { alt = "Sample avatar" } [ Avatar.image "/avatar-sample.svg" ] |> Element.toNode
            , Node.raw
                (div [ class "flex gap-3" ]
                    [ div [ class "block w-10 h-10 bg-primary rounded-md-corner-large" ] []
                    , div [ class "block w-10 h-10 bg-tertiary-container rounded-md-corner-extra-large" ] []
                    , div [ class "block w-10 h-10 bg-secondary-container rounded-full" ] []
                    ]
                )
            ]
        ]


sectionHeading : String -> Node msg
sectionHeading label =
    Heading.view { label = label, variant = Heading.Headline }
        [ Heading.size Heading.Medium, Heading.level 2 ]
        |> Element.toNode


highlights : Node msg
highlights =
    Node.element "section"
        [ Node.rawAttr (class "space-y-6") ]
        [ sectionHeading "Why elm-m3e"
        , Node.element "div"
            [ Node.rawAttr (class "grid gap-4 sm:grid-cols-3") ]
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


highlightCard : String -> String -> String -> Node msg
highlightCard iconName title body =
    Card.view
        [ Card.variant Card.Outlined
        , Card.headline (Heading.view { label = title, variant = Heading.Title } [])
        , Card.body
            [ Element.fromNode
                (Node.element "div"
                    [ Node.rawAttr (class "flex gap-3") ]
                    [ Node.element "span"
                        [ Node.rawAttr (class "shrink-0 text-primary") ]
                        [ Icon.view { name = iconName } |> Element.toNode ]
                    , Node.raw (p [ class "text-body-md text-on-surface-variant" ] [ text body ])
                    ]
                )
            ]
        ]
        |> Element.toNode


statusGrid : Node msg
statusGrid =
    Node.element "section"
        [ Node.rawAttr (class "space-y-6") ]
        [ sectionHeading "Status & roadmap"
        , Node.raw
            (p [ class "max-w-2xl text-body-lg text-on-surface-variant" ]
                [ text "The honest current state of the standalone library." ]
            )
        , Node.element "div"
            [ Node.rawAttr (class "grid gap-4 sm:grid-cols-2") ]
            [ statusCard "Complete (53)" "Every M3e.* module compiles against the bindings — buttons, cards, dialogs, the nav family, chips, fabs, form controls, sliders, date/time pickers, tooltips, and more."
            , statusCard "Documented" "Getting Started, Styles, and per-component pages (API tables) are generated; rich per-component demos and Studies are in progress."
            , statusCard "Removed (1)" "M3e.Table — m3e ships no table element, so it does not belong in a library that wraps m3e."
            , statusCard "Generator fixed" "elm-cem now resolves TS string-literal aliases to real per-component Elm enums and emits shared attributes per-component — benefiting every binding library."
            ]
        ]


statusCard : String -> String -> Node msg
statusCard title body =
    Card.view
        [ Card.variant Card.Outlined
        , Card.headline (Heading.view { label = title, variant = Heading.Title } [])
        , Card.body [ Element.html (p [ class "text-body-md text-on-surface-variant" ] [ text body ]) ]
        ]
        |> Element.toNode
