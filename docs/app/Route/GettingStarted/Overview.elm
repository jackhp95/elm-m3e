module Route.GettingStarted.Overview exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html, a, code, div, h1, h2, li, p, section, text, ul)
import Html.Attributes exposing (class, href)
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


view : App Data ActionData RouteParams -> Shared.Model -> View (PagesMsg Msg)
view _ _ =
    { title = "Overview · elm-m3e"
    , body =
        [ div [ class "mx-auto max-w-3xl space-y-8" ]
            [ section [ class "space-y-3" ]
                [ h1 [ class "text-display-small font-semibold text-on-surface" ] [ text "Overview" ]
                , p [ class "text-body-large text-on-surface-variant" ]
                    [ text "elm-m3e (the m3e-builder project) is a type-safe Elm binding layer over "
                    , code [ class "rounded bg-surface-container px-1.5 py-0.5 text-body-medium" ] [ text "@m3e/web" ]
                    , text ", matraic's Material 3 Expressive web component library."
                    ]
                ]
            , section [ class "space-y-3" ]
                [ h2 [ class "text-headline-small font-semibold text-on-surface" ] [ text "The MISI philosophy" ]
                , p [ class "text-body-large text-on-surface-variant" ]
                    [ text "Every Ui.* module is a small builder that Makes Impossible States Impossible: typed-to-child slots, required collaborators at the call site, and one module per documented m3e component. Invalid compositions don't compile, and there are no silent no-ops." ]
                , ul [ class "list-disc space-y-1.5 pl-5 text-body-medium text-on-surface-variant" ]
                    [ li [] [ text "Typed slots — an icon slot only accepts a Ui.Icon, never arbitrary Html." ]
                    , li [] [ text "Builders with required collaborators — you can't render an avatar without content." ]
                    , li [] [ text "53 modules mirroring the @m3e/web catalogue 1:1." ]
                    ]
                ]
            , section [ class "space-y-3" ]
                [ h2 [ class "text-headline-small font-semibold text-on-surface" ] [ text "Relationship to @m3e/web" ]
                , p [ class "text-body-large text-on-surface-variant" ]
                    [ text "@m3e/web ships the custom elements, the dynamic-color "
                    , code [ class "rounded bg-surface-container px-1.5 py-0.5 text-body-medium" ] [ text "<m3e-theme>" ]
                    , text " engine, and the M3 design tokens. elm-m3e wraps each element in a typed Elm builder and the tokens flow through Tailwind utilities (the tailwind-m3e-web bridge)." ]
                , p [ class "text-body-large text-on-surface-variant" ]
                    [ text "Next: "
                    , a [ href "/getting-started/installation", class "text-primary hover:underline" ] [ text "Installation" ]
                    , text "."
                    ]
                ]
            ]
        ]
    }
