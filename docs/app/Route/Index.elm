module Route.Index exposing (ActionData, Data, Model, Msg, route)

{-| Documentation home for `m3e-builder` / `elm-m3e` — the type-safe, MISI Elm
builder layer (`Ui.*`) over matraic's `@m3e/web` Material 3 Expressive web
components.

The app shell (`Shared.elm`) owns the `<m3e-theme>`, the top app bar, and the
sidebar nav, so this page is just the hero + highlights content.

-}

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, a, code, div, h1, h2, h3, p, section, span, text)
import Html.Attributes exposing (class, href)
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import Ui.Avatar as Avatar
import Ui.Icon as Icon
import Ui.Shape as Shape
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
        [ div [ class "mx-auto max-w-5xl space-y-16" ]
            [ hero
            , highlights
            , statusGrid
            ]
        ]
    }


hero : Html msg
hero =
    section [ class "space-y-5" ]
        [ p [ class "text-label-large uppercase tracking-wide text-primary" ]
            [ text "elm-m3e · m3e-builder" ]
        , h1 [ class "text-display-small font-semibold text-on-surface" ]
            [ text "Type-safe Material 3 Expressive for Elm" ]
        , p [ class "max-w-2xl text-body-large text-on-surface-variant" ]
            [ text "A Make-Impossible-States-Impossible builder layer over matraic's "
            , code [ class "rounded bg-surface-container px-1.5 py-0.5 text-body-medium" ] [ text "@m3e/web" ]
            , text " web components. Typed-to-child slots, builders with required collaborators, one module per documented m3e component — invalid compositions don't compile, and there are no silent no-ops."
            ]
        , div [ class "flex flex-wrap items-center gap-3 pt-2" ]
            [ a
                [ href "/getting-started/installation"
                , class "rounded-full bg-primary px-5 py-2.5 text-label-large font-medium text-on-primary no-underline hover:opacity-90"
                ]
                [ text "Get started" ]
            , a
                [ href "/reference"
                , class "rounded-full border border-outline px-5 py-2.5 text-label-large font-medium text-on-surface no-underline hover:bg-surface-container"
                ]
                [ text "Browse the API reference" ]
            ]
        , div [ class "flex items-center gap-3 pt-4" ]
            [ div [ class "text-xl" ] [ Avatar.image { url = "/avatar-sample.svg", alt = "Sample avatar" } |> Avatar.view ]
            , div [ class "flex gap-3 text-2xl text-primary" ]
                [ Shape.new |> Shape.withClass "block w-10 h-10 bg-primary rounded-md-corner-large" |> Shape.view
                , Shape.new |> Shape.withClass "block w-10 h-10 bg-tertiary-container rounded-md-corner-extra-large" |> Shape.view
                , Shape.new |> Shape.withClass "block w-10 h-10 bg-secondary-container rounded-full" |> Shape.view
                ]
            ]
        ]


highlights : Html msg
highlights =
    section [ class "space-y-6 border-t border-outline-variant pt-12" ]
        [ h2 [ class "text-headline-medium font-semibold text-on-surface" ] [ text "Why elm-m3e" ]
        , div [ class "grid gap-4 sm:grid-cols-3" ]
            [ highlightCard "verified" "Type-safe slots"
                "Containers take typed children — an icon slot can only hold a Ui.Icon. Invalid compositions are compile errors, not runtime no-ops."
            , highlightCard "category" "One module per component"
                "53 Ui.* modules mirroring matraic's @m3e/web catalogue, each a small builder with required collaborators."
            , highlightCard "palette" "Real M3 tokens"
                "Dynamic color, density, contrast, motion and the full type scale flow from a single <m3e-theme> — switch them live in the app bar."
            ]
        ]


highlightCard : String -> String -> String -> Html msg
highlightCard icon title body =
    div [ class "rounded-md-corner-large border border-outline-variant bg-surface-container-low p-5" ]
        [ div [ class "text-3xl text-primary" ] [ Icon.material icon |> Icon.view ]
        , h3 [ class "mt-3 text-title-medium font-medium text-on-surface" ] [ text title ]
        , p [ class "mt-1 text-body-medium text-on-surface-variant" ] [ text body ]
        ]


statusGrid : Html msg
statusGrid =
    section [ class "space-y-6 border-t border-outline-variant pt-12" ]
        [ h2 [ class "text-headline-medium font-semibold text-on-surface" ] [ text "Status & roadmap" ]
        , p [ class "max-w-2xl text-body-large text-on-surface-variant" ]
            [ text "The honest current state of the standalone library." ]
        , div [ class "grid gap-4 sm:grid-cols-2" ]
            [ statusCard "Complete (53)" "Every Ui.* module compiles against the bindings — buttons, cards, dialogs, the nav family, chips, fabs, form controls, sliders, date/time pickers, tooltips, and more."
            , statusCard "Documented" "Getting Started, Styles, and per-component pages (API tables) are generated; rich per-component demos and Studies are in progress."
            , statusCard "Removed (1)" "Ui.Table — m3e ships no table element, so it does not belong in a library that wraps m3e."
            , statusCard "Generator fixed" "elm-cem now resolves TS string-literal aliases to real per-component Elm enums and emits shared attributes per-component — benefiting every binding library."
            ]
        ]


statusCard : String -> String -> Html msg
statusCard title body =
    div [ class "rounded-md-corner-large border border-outline-variant bg-surface-container-low p-5" ]
        [ h3 [ class "text-title-medium font-medium text-on-surface" ] [ text title ]
        , p [ class "mt-1 text-body-medium text-on-surface-variant" ] [ text body ]
        ]
